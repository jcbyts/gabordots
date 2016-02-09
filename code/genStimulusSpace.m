function [S, coeff]=genStimulusSpace(sz, n, coh, M)
% generate sparse coefficients for stimulus
% S=genStimuluSpace(sz, nElements, coh, M)
% Inputs
%
%   sz  [1 x 3]      y,x,t dimensions of stimulus
%   n   [1 x 1]      number of elements to show
%   coh [1 x 1]      fraction of rightward elements
%   M  [struct]      filter base


nr=ceil(n*coh);
R=zeros(sz); R(randi(numel(R), nr,1))=1;
L=zeros(sz); L(randi(numel(R), n-nr,1))=1;
coeff=R-L;

L=fftconvn(L, M.left90);
R=fftconvn(R, M.right90);
S=R+L;


