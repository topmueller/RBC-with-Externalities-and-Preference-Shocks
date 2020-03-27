clear all
load KPR_irfs 
load GHH_irfs

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preference Shock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Plotting the IRFS
figure(1);
%looping over all variables
for jj=1:1:length(var_names)
subplot(5,3,jj);
plot(1:50, KPR_irfs.eta_zeta.gamma_1_0.([var_names{jj} '_eta_zeta'])(1:50), 'b', 'linewidth', 2); hold on;
plot(1:50, GHH_irfs.eta_zeta.gamma_1_0.([var_names{jj} '_eta_zeta'])(1:50), 'r--', 'linewidth', 2); 
zero_plot(1) = plot(1:50,zeros(1,50));
set(zero_plot(1),'LineWidth', 1, 'LineStyle', ':',  'Marker', 'none', 'Color', 'k');
xlabel('time');
ylabel('% deviations from S.S.');
if jj==1
legend('King Plosser Rebelo preferences', 'Greenwood Hercowitz Huffman preferences', 'fontSize',10);
end

title([var_names_long{jj} ' (' var_names{jj} ')']); 
sgtitle('IRFs to a Preference Shock', 'fontSize',14);

end

