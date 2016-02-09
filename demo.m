
addpath code

screenInfo=getScreen();
M=makeMotionEnergyFilters('Gabor', screenInfo);

% screen dimensions (in pixels/frames)
s=[200 200 200]; % y, x, t

nElements=500; % number of elements to show

coh=.9; % fraction of rightward moving elements

% generate a stimulus
[S, coefs]=genStimulusSpace(s, nElements, coh, M);

playMovie(S)

%% look in fourier domain
clf
[ff, fx, ~, ft]=fft3axes(M.left90, screenInfo.ppd, screenInfo.ppd, screenInfo.Fr);
subplot(121)
imagesc(ft, fx, squeeze(sum(ff)))
title('Left Filter Spectrum')

[fs, fx, ~, ft]=fft3axes(S, screenInfo.ppd, screenInfo.ppd, screenInfo.Fr);
subplot(122)
imagesc(ft, fx, squeeze(sum(fs)))
title(['Stimulus fraction right: ' num2str(coh)])


%% save movie if you want to play in quicktime
% save('filename.mp4', S)