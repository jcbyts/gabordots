function [me, mer, mel, memovie]=getMotionEnergy(S, M)
% [me, mer, mel, memovie]=getMotionEnergy(S, M)
mel=fftconvn(S, M.left90).^2 + fftconvn(S, M.left0).^2;
mer=fftconvn(S, M.right90).^2 + fftconvn(S, M.right0).^2;
memovie=mer-mel;
mer=squeeze(sum(sum(mer)));
mel=squeeze(sum(sum(mel)));
me=mer-mel;