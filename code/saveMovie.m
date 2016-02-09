function saveMovie(filename, M)
% save a movie as an mp4
% saveMovie(filename, M)
v=VideoWriter(filename,'MPEG-4');
open(v)
M=(M-min(M(:)))/(max(M(:))-min(M(:)));
for k=1:size(M,3)
    writeVideo(v, M(:,:,k))
end
close(v)