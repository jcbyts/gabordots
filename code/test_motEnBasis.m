

screenInfo=getScreen('nhb');

M=makeMotionEnergyFilters('Gabor', screenInfo);


ny=200; nx=200; nt=200;

nBasis=500;
coh=.9;
nr=ceil(nBasis*coh);
R=zeros(ny,nx,nt); R(randi(numel(R), nr,1))=1;
L=zeros(ny,nx,nt); L(randi(numel(R), nBasis-nr,1))=1;
sum(R(:))
X=R-L;
me0=(squeeze(sum(sum(R)))-squeeze(sum(sum(L))));
%%
L=fftconvn(L, M.left90);
R=fftconvn(R, M.right90);
playMovie(L+R)
C=L+R;

% saveMovie(['~/Desktop/coh' num2str(ceil(100*(coh-.5))) '.mp4'], C)
% me=getMotionEnergy(C,M);

%%
clf
% plot(me/10e5); hold on
plot(filter(M.t2(M.t), 1, me0))


%%
nPulses=7;
ptimes=1:5:(5*nPulses);
R=zeros(ny,nx,nt);
L=zeros(ny,nx,nt);
gridxy=1+nx/2+ceil(gabs.makeGrid([0 0], 0)*nx/2);
gridxy(gridxy>ny)=ny;
nGabors=numel(gridxy)/2;
x=round(randn(nPulses,1)*5+2);
[dirmat, cohidx]=gabs.genCohMat(x, []);

for kPulse=1:nPulses
    for kGabor=1:nGabors
        if dirmat(kPulse)>0
            R(gridxy(2,kGabor),gridxy(1,kGabor),ptimes(kPulse)+randi(5))=cohidx(kPulse, kGabor);
        else
            L(gridxy(2,kGabor),gridxy(1,kGabor),ptimes(kPulse)+randi(5))=cohidx(kPulse, kGabor);
        end
    end
end

R=fftconvn(R, M.right90);
L=fftconvn(L, M.left90);
playMovie(R+L)
C=R+L;
saveMovie('~/Desktop/gabs.mp4', C)
%%
clf
F=fft3axes(C-mean(C(:)), screenInfo.ppd, screenInfo.ppd, screenInfo.Fr);
imagesc((squeeze(sum(F))))


%%
