% Comment/uncomment for a specific dataset:
%load("sleep_wake.mat") 
%load("arousal_VISp.mat") 
%load("arousal_CA1.mat") 
%load("arousal_LGd.mat") 
load("psychedel_drug.mat") 

uI = frA1 <= frB1; % upregulated neurons
dI = frA1 > frB1; % downregulated neurons

color_pop1 = [1 0.5 0];
color_pop2 = [0.5 0 0.5];

figure
nexttile; hold on;
h = cdfplot(frA2(uI)); h.Color = color_pop1; h.LineStyle = '--';
h = cdfplot(frB2(uI)); h.Color = color_pop1; h.LineStyle = '-.';
h = cdfplot(frA2(dI)); h.Color = color_pop2; h.LineStyle = '--';
h = cdfplot(frB2(dI)); h.Color = color_pop2; h.LineStyle = '-.';
legend('subpopulation 1, state A', 'subpopulation 1, state B', 'subpopulation 2, state A', 'subpopulation 2, state B')
set(gca, Xscale = "log")
xlim([1e-2 1e2])
xlabel('Firing rate (spikes/s)')
ylabel('Cumulative probability')
grid off

nexttile; hold on;
recs = unique(recID)';
I = frA2 > 0 & frB2 > 0; % log(0) = -inf
m = [];
for r = recs % loop on individual recordings
  m(end+1, :) = [mean(log10(frA2(uI & recID == r & I))),  mean(log10(frB2(uI & recID == r & I))), ...
    mean(log10(frA2(dI & recID == r & I))),  mean(log10(frB2(dI & recID == r & I)))];

  if sum(uI & recID == r & I) < 10 
    m(end, [1 2]) = NaN; % too few neurons
  end
  if sum(dI & recID == r & I) < 10 
    m(end, [3 4]) = NaN; % too few neurons
  end
end
scatter(m(:, 1), m(:, 2), 'o', 'filled', MarkerEdgeColor = 'none', MarkerFaceColor = color_pop1)
scatter(m(:, 3), m(:, 4), 'o', 'filled', MarkerEdgeColor = 'none', MarkerFaceColor = color_pop2)

xlim([min(m(:)) - 0.05, max(m(:))+ 0.05])
ylim(xlim)
plot(xlim, ylim, 'k--')
axis square
xlabel('Subpopulation mean log-rate (state A)')
ylabel('Subpopulation mean log-rate (state B)')

fprintf('Change in median mean log-rate (across experiments), downregulated subpopulation (%1.0f%% of neurons): %1.2f P = %1.1e\n', ...  
  sum(dI & I)/sum(I)*100, median(m(:, 4), 'omitnan') - median(m(:, 3), 'omitnan'), signtest(m(:, 3), m(:, 4)))
fprintf('Change in median mean log-rate (across experiments),   upregulated subpopulation (%1.0f%% of neurons): %1.2f P = %1.1e\n', ...  
  sum(uI & I)/sum(I)*100, median(m(:, 2), 'omitnan') - median(m(:, 1), 'omitnan'), signtest(m(:, 1), m(:, 2)))

