clear
%load KPR_irfs_rho_0_9 
%load GHH_irfs_rho_0_9
load KPR_irfs_rho_0
load GHH_irfs_rho_0


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
plot(1:50, KPR_irfs.eta_zeta.gamma_1_5_ext.([var_names{jj} '_eta_zeta'])(1:50), 'r--', 'linewidth', 2); 
plot(1:50, KPR_irfs.eta_zeta.gamma_2_0_ext.([var_names{jj} '_eta_zeta'])(1:50), 'g--', 'linewidth', 2); 
zero_plot(1) = plot(1:50,zeros(1,50));
set(zero_plot(1),'LineWidth', 1, 'LineStyle', ':',  'Marker', 'none', 'Color', 'k');
xlabel('time');
ylabel('% deviations from S.S.');
if jj==1
legend('\gamma = 1','\gamma = 1.5', '\gamma = 2' ,'fontSize',10);
end

title([var_names_long{jj} ' (' var_names{jj} ')']); 
sgtitle('IRFs to a Preference Shock', 'fontSize',14);

end


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Government Spending Shock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Plotting the IRFS
figure(2);
%looping over all variables
for jj=1:1:length(var_names)
subplot(5,3,jj);
plot(1:50, KPR_irfs.eta_g.gamma_1_0.([var_names{jj} '_eta_g'])(1:50), 'b', 'linewidth', 2); hold on;
plot(1:50, KPR_irfs.eta_g.gamma_1_5_ext.([var_names{jj} '_eta_g'])(1:50), 'r--', 'linewidth', 2); 
plot(1:50, KPR_irfs.eta_g.gamma_2_0_ext.([var_names{jj} '_eta_g'])(1:50), 'g--', 'linewidth', 2); 
zero_plot(1) = plot(1:50,zeros(1,50));
set(zero_plot(1),'LineWidth', 1, 'LineStyle', ':',  'Marker', 'none', 'Color', 'k');
xlabel('time');
ylabel('% deviations from S.S.');
if jj==1
legend('\gamma = 1','\gamma = 1.5', '\gamma = 2' ,'fontSize',10);
end

title([var_names_long{jj} ' (' var_names{jj} ')']); 
sgtitle('IRFs to a Government Spending Shock', 'fontSize',14);

end


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Technology Shock
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Plotting the IRFS
figure(3);
%looping over all variables
for jj=1:1:length(var_names)
subplot(5,3,jj);
plot(1:50, KPR_irfs.eta_z.gamma_1_0.([var_names{jj} '_eta_z'])(1:50), 'b', 'linewidth', 2); hold on;
plot(1:50, KPR_irfs.eta_z.gamma_1_5_ext.([var_names{jj} '_eta_z'])(1:50), 'r--', 'linewidth', 2); 
plot(1:50, KPR_irfs.eta_z.gamma_2_0_ext.([var_names{jj} '_eta_z'])(1:50), 'g--', 'linewidth', 2); 
zero_plot(1) = plot(1:50,zeros(1,50));
set(zero_plot(1),'LineWidth', 1, 'LineStyle', ':',  'Marker', 'none', 'Color', 'k');
xlabel('time');
ylabel('% deviations from S.S.');
if jj==1
legend('\gamma = 1',' \gamma = 1.5', '\gamma = 2' ,'fontSize',10);
end

title([var_names_long{jj} ' (' var_names{jj} ')']); 
sgtitle('IRFs to a Technology Shock', 'fontSize',14);

end
