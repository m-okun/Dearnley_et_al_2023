C = load("psychedel_control.mat");
D = load("psychedel_drug.mat");

figure
nexttile
scatter((C.frA1 + C.frA2)/2, (C.frB1 + C.frB2)/2, '.k')
set(gca, Xscale = "log", Yscale = "log")
xlabel('Firing rate before (spikes/s)')
ylabel('Firing rate after (spikes/s)')
title('Control')


nexttile
scatter((D.frA1 + D.frA2)/2, (D.frB1 + D.frB2)/2, '.r')
set(gca, Xscale = "log", Yscale = "log")
xlabel('Firing rate before (spikes/s)')
ylabel('Firing rate after (spikes/s)')
title('Drug')

