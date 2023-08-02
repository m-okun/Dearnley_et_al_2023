% Comment/uncomment for a specific dataset:
load("sleep_wake.mat") 
%load("arousal_VISp.mat") 
%load("arousal_CA1.mat") 
%load("arousal_LGd.mat") 

frA = (frA1 + frA2)/2;
frB = (frB1 + frB2)/2;

figure
nexttile; hold on
h = cdfplot(frA); h.Color =  'k'; h.LineStyle = '--';
h = cdfplot(frB); h.Color =  'r'; h.LineStyle = '-.';
set(gca, Xscale = "log")
xlim([1e-2 1e2])
legend('state A', 'state B')
xlabel('Firing rate (spikes/s)')
ylabel('Cumulative probability')

nexttile; hold on
mfr_thresh = 0.01;
pdA_gamma = fitdist(frA(frA > mfr_thresh), 'Gamma');
pdB_gamma = fitdist(frB(frB > mfr_thresh), 'Gamma');
x = -2:0.02:2;
plot(x, logammaPDF(pdA_gamma.b, pdA_gamma.a, x, 10), 'k--')
plot(x, logammaPDF(pdB_gamma.b, pdB_gamma.a, x, 10), 'r-.')
xlabel('Firing rate (spikes/s)')
ylabel('Probability density')

nexttile; hold on
scatter((log10(frA)+log10(frB))/2, (log10(frB) - log10(frA)), '.k')
yline(0, 'k--')
xlim([-2 2])
ylim([-2 2])
xlabel('Mean log-rate')
ylabel('Modulation index')

nexttile; hold on
recs = unique(recID)';
s = [];
for r = recs % loop on individual recordings
  s(end+1, :) = [std(log10(frA1(frA1 > mfr_thresh & recID == r))),  std(log10(frB1(frB1 > mfr_thresh & recID == r)))]; 
end
scatter(s(:, 1), s(:, 2), 'ks', 'filled')
xlim([min(s(:)) - 0.05, max(s(:))+ 0.05])
ylim(xlim)
plot(xlim, ylim, 'k--')
axis square
xlabel('Log-rate st. dev. (state A)')
ylabel('Log-rate st. dev. (state B)')

