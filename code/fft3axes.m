function [fview,fs_x, fs_y, fs_z]=fft3axes(X,fx,fy,fz, fmode)
% 3d fourier transform and axes in proper units
% [fview,fs_x, fs_y]=fft2axes(X,fx,fy)
if ~exist('fmode', 'var')
    fmode='abs';
end

nyqx=fx/2;
nyqy=fy/2;
nyqz=fz/2;
% fs_x=fftshift([0:nyqx-1 -nyqx:-1]);
% fs_y=fftshift([0:nyqy-1 -nyqy:-1]);
% fs_z=fftshift([0:nyqz-1 -nyqz:-1]);



switch fmode
    case 'abs'
        f=abs(fftn(X));
    case 'real'
        f=real(fftn(X));
    case 'imag'
        f=imag(fftn(X));
end

fview=fftshift(f);
s=size(fview);

fs_x=linspace(-nyqx, nyqx, s(1));
fs_y=linspace(-nyqy, nyqy, s(2));
fs_z=linspace(-nyqz, nyqz, s(3));


% s=size(X);
% % setup to take fft
% nfft_row  = 2^nextpow2(s(1));   % number of samples with zero padding
% nfft_col = 2^nextpow2(s(2));   % number of samples with zero padding
% % take fft
% Y = fft2(X, nfft_row, nfft_col);
%
% % build axes
% fs_x  = fx/2 * linspace(-1,1,nfft_col);
% fs_y = fy/2 * linspace(-1,1,nfft_row);
% xinds = fftshift(1:length(fs_x));
% yinds = fftshift(1:length(fs_y));
% % fourier power
% fview = abs(Y);
% fview=fview(yinds, xinds);


