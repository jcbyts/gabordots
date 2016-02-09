function Fa=fftconvn(A,b)
% Fa=fftconvn(A,b)

% Fn=ifftn(fftn(ones(size(A))).*fftn(b, size(A)));
% 
% Fa=ifftn(fftn(A).*fftn(b, size(A)));
% 
% Fb=Fa./Fn;

s=size(A);
sb=size(b);
% Fn=ifftn(fftn(ones(s), 2.^nextpow2(s)).*fftn(b, 2.^nextpow2(s)));

Fa=ifftn(fftn(A, s+sb-1).*fftn(b, s+sb-1));

% Fb=Fa./Fn;

