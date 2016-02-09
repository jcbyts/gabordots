function S = makeMotionEnergyFilters(filterMode, screenInfo)
% generate motion energy filters
% S = makeMotionEnergyFilters(filterMode, screenInfo)
% 
% Inputs
%
%   filterMode  parameterization of motion energy filter
%           Options: 
%               Kiani2008 - 4th order cauchy function and temporal kernel
%                           from Movshon 88
%               AdelsonBergen85 - gaussian 2nd and 3rd derivatives with
%                           same temporl kernel
%               Gabor     - cosine with gaussian envelope

% 2016  jly

if ~exist('filterMode', 'var') || isempty(filterMode)
    filterMode='Gabor';
end

if ~exist('screenInfo', 'var')
    screenInfo=[];
end

defScreenInfo.Fr=60;  % 60Hz was the frame-rate of our monitors
defScreenInfo.ppd=35.3660; % pix per deg from 118cm with the 55" LG

screenInfo=mergefield(screenInfo, defScreenInfo);

switch filterMode
    case 'Kiani2008'
        % spatial filters
        sigma=.35;
        % from kiani
        f1=@(x) cos(atan(x/sigma)).^4.*cos(4*atan(x/sigma));
        f2=@(x) cos(atan(x/sigma)).^4.*sin(4*atan(x/sigma));
        
        % temporal filters
        t1=@(t) (60*t).^3 .* exp(-60*t) .* (1./factorial(3) - (60*t).^2./factorial(3+2));
        t2=@(t) (60*t).^5 .* exp(-60*t) .* (1./factorial(5) - (60*t).^2./factorial(5+2));
    case 'AdelsonBergen85'
        % from adelson bergen - gaussian derivatives
        sigma=.2;
        f1=@(x) -x.*exp(-.5*x.^2/sigma^2)/(sigma^3*sqrt(2*pi));
        f2=@(x) -(sigma^2 - x.^2).*exp(-.5*x.^2/sigma^2)/(sigma^5.*sqrt(2*pi));
        
        % temporal filters
        t1=@(t) (60*t).^3 .* exp(-60*t) .* (1./factorial(3) - (60*t).^2./factorial(3+2));
        t2=@(t) (60*t).^5 .* exp(-60*t) .* (1./factorial(5) - (60*t).^2./factorial(5+2));
    case 'Gabor'
        % gabors you can tune to the stimulus frequency
        sigma=.2;
        th=3*pi;
        f1=@(x) exp(-x.^2/2/sigma^2).*cos(x*th);
        f2=@(x) exp(-x.^2/2/sigma^2).*sin(x*th);
        
        % temporal filters
        tsig=.05;
        tf=7*2*pi;
        t1=@(t) exp(-t.^2/2/tsig^2).*cos(t*tf);
        t2=@(t) exp(-t.^2/2/tsig^2).*sin(t*tf);
end

% y dimension: gaussian window 
fy=@(y) exp(-y.^2/2/sigma^2);

S.f1=f1;
S.f2=f2;
S.fy=fy;
S.t1=t1;
S.t2=t2;

%% construct space-time separable filters
S.t=(0:(1/screenInfo.Fr):.25)';
S.x=(-1:(1/screenInfo.ppd):1)';
S.y=(-1:(1/screenInfo.ppd):1)';

S.s1t1=makeSeparableFilter(fy(S.y), f1(S.x), t1(S.t));
S.s1t2=makeSeparableFilter(fy(S.y),f1(S.x),t2(S.t));
S.s2t1=makeSeparableFilter(fy(S.y),f2(S.x),t1(S.t));
S.s2t2=makeSeparableFilter(fy(S.y),f2(S.x),t2(S.t));

%% build oriented filters
S.right0=S.s1t1+S.s2t2;
S.left0=-S.s1t1+S.s2t2;

S.right90=-S.s1t2+S.s2t1;
S.left90=S.s1t2+S.s2t1;