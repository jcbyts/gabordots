function yxt=makeSeparableFilter(y,x,t)
% make a space-time separable 3D filter
ny=numel(y);
nx=numel(x);


yxt=y(:)*x(:)';

if nargin >2
    nt=numel(t);
    yxt=yxt(:)*t(:)';
    yxt=reshape(yxt, ny, nx, nt);
end
