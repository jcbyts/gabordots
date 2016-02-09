function plotMotionEnergyFilters(S)
% plot motion energy filters
% plotMotionEnergyFilters(S)
% get S with makeMotionEnergyFilters
figure(111); clf
subplot(121)
plot(S.x, S.f1(S.x), 'k'); hold on
plot(S.x, S.f2(S.x), 'Color', .5*[1 1 1])
xlabel('x')
ylabel('amp')
title('Spatial Filters')
subplot(122)
plot(S.t,S.t1(S.t), 'k'); hold on
plot(S.t,S.t2(S.t), 'Color', .5*[1 1 1])
xlabel('t')
title('Temporal Filter')

figure(112); clf
subplot(2,2,1)
imagesc(S.x,S.t*1e3,squeeze(sum(S.s1t1))')
xlabel('x')
ylabel('t (ms)')
subplot(2,2,2)
imagesc(S.x,S.t*1e3,squeeze(sum(S.s1t2))')
xlabel('x')
ylabel('t (ms)')
subplot(2,2,3)
imagesc(S.x,S.t*1e3,squeeze(sum(S.s2t1))')
xlabel('x')
ylabel('t (ms)')
subplot(2,2,4)
imagesc(S.x,S.t*1e3,squeeze(sum(S.s2t2))')
xlabel('x')
ylabel('t (ms)')
colormap gray

figure(113); clf
w=.35;
c=.2;
b=c+w+.05;
ax(1)=axes('Position', [c c w w]);
imagesc(S.x,S.t*1e3,squeeze(sum(S.left0))')
set(gca, 'Xtick', [-.7 0 .7], 'Ytick', [0 100 200])
xlabel('space (deg)')
ylabel('time (ms)')

ax(2)=axes('Position', [c b w w]);
imagesc(S.x,S.t*1e3,squeeze(sum(S.left90))')
set(gca, 'Xtick', [-.7 0 .7], 'Ytick', [0 100 200])
set(gca, 'XTickLabel', '')
% xlabel('x (deg)')
ylabel('time (ms)')

ax(3)=axes('Position', [b c w w]);
imagesc(S.x,S.t*1e3,squeeze(sum(S.right0))')
set(gca, 'Xtick', [-.7 0 .7], 'Ytick', [0 100 200])
set(gca, 'YTickLabel', '')
xlabel('space (deg)')
% ylabel('t (ms)')

ax(4)=axes('Position', [b b w w]);
imagesc(S.x,S.t*1e3,squeeze(sum(S.right90))')
set(gca, 'Xtick', [-.7 0 .7], 'Ytick', [0 100 200])
set(gca, 'XTickLabel', '', 'YTickLabel', '')
% xlabel('x (deg)')
% ylabel('t (ms)')
colormap gray