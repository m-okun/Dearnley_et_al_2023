% Comment/uncomment for a specific dataset:
%load("sleep_wake.mat")
%load("arousal_VISp.mat")
%load("arousal_CA1.mat")
%load("arousal_LGd.mat")
load("psychedel_drug.mat")

scatterMarkerSize = 16;
color_pop1 = [1 0.5 0];
color_pop2 = [0.5 0 0.5];

uI = frA1 <= frB1; % upregulated neurons
dI = frA1 > frB1; % downregulated neurons

figure
for subpop = 1:2 % loop on the two subpopulations
  switch subpop
    case 1
      color_pop = color_pop2;
      I = dI & frA2 > 0 & frB2 > 0;
    case 2
      color_pop = color_pop1;
      I = uI & frA2 > 0 & frB2 > 0;
  end
  mlfr = (log10(frA2(I))+log10(frB2(I)))/2; % mean log firing rate
  mi = log10(frB2(I)) - log10(frA2(I)); % modulaiton index


  nexttile; hold on;
  scatter(mlfr, mi, scatterMarkerSize, 'o', 'filled', MarkerEdgeColor = 'none', MarkerFaceColor = color_pop, MarkerFaceAlpha = 0.25)
  yline(0, 'k--')
  xlim([-2 2])
  ylim([-2 2])
  xlabel('Mean log-rate')
  ylabel('Modulation index')

  nexttile; hold on;
  stdbinSize = 0.5;  
  for r = -1-stdbinSize/2:stdbinSize:1+stdbinSize/2    
    swarmchart((r+stdbinSize/2)*ones(sum(mlfr >= r & mlfr < r+stdbinSize), 1), mi(mlfr >= r & mlfr < r+stdbinSize), ...
      scatterMarkerSize, 'o', 'filled',  MarkerEdgeColor = 'none', MarkerFaceColor = color_pop, MarkerFaceAlpha = 0.25, XJitterWidth = 0.2);
    plot(r+stdbinSize/2, mean(mi(mlfr >= r & mlfr < r+stdbinSize)), 'ko') 
    errorbar(r+stdbinSize/2, mean(mi(mlfr >= r & mlfr < r+stdbinSize)), std(mi(mlfr >= r & mlfr < r+stdbinSize)), 'k')    
  end
  xlabel('Mean log-rate')
  ylabel('Modulation index')
end % loop on subpopulations 

