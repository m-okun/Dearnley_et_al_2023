% Comment/uncomment for a specific dataset:
load("sleep_wake.mat") 
%load("arousal_VISp.mat") 
%load("arousal_CA1.mat") 
%load("arousal_LGd.mat") 
% For psychedelic dataset use fig1_psychedelic.m (inherently different structure of the experiment)

figure
nexttile
scatter(frA1, frA2, '.')
set(gca, Xscale = "log", Yscale = "log")
xlabel('Firing rate sample1 (spikes/s)')
ylabel('Firing rate sample2 (spikes/s)')

nexttile
scatter(frA1, frB1, '.')
set(gca, Xscale = "log", Yscale = "log")
xlabel('Firing rate brain state A (spikes/s)')
ylabel('Firing rate brain state B (spikes/s)')

nexttile; hold on
edges=0:0.2:3;
plot(edges(1:end-1), histcounts(abs(log10(frA1 ./ frA2)), edges, Normalization = "pdf"), 'k', Linewidth = 2)
scatter(median(abs(log10(frA1 ./ frA2)), 'omitnan'), 3, 'kv', 'filled')
plot(edges(1:end-1), histcounts(abs(log10(frA1 ./ frB1)), edges, Normalization = "pdf"), 'r', Linewidth = 2)
scatter(median(abs(log10(frA1 ./ frB1)), 'omitnan'), 3, 'rv', 'filled'); 
xlabel('Absolute modulation estimate')
ylabel('Probability density')

fprintf('Difference of absolute rate modulation estimates: %1.1f%% P=%1.1e\n', ...  
  median(abs(log10(frA1 ./ frB1)), 'omitnan') / median(abs(log10(frA1 ./ frA2)), 'omitnan')*100 - 100, ...
  ranksum(abs(log10(frA1 ./ frA2)), abs(log10(frA1 ./ frB1)), tail = "left")) 

