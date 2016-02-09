function playMovie(M, p, p2)

if nargin<2
    p=.015;
end
sp=1;

if nargin==3
    assert(all(size(p)==size(M)))
    M2=p;
    p=p2;
    sp=2;
    clim2=[min(M2(:)) max(M2(:))];
end
    



clim=[min(M(:)) max(M(:))];
figure(gcf)
clf
colormap gray
n=size(M,3);
for k=1:n
    subplot(1,sp,1)
    imagesc(M(:,:,k), clim); drawnow
    
    if nargin==3
        subplot(1,sp,2)
        imagesc(M2(:,:,k), clim2); drawnow
    end
    pause(p)
end