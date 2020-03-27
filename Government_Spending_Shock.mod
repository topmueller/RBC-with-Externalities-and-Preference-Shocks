// Government Spending Shock

//standard deviation of shock
shocks;
var eta_g = 1;   // Government Spending Shock
end;


//performs a stochastic simulation of the model (10 Periods)
stoch_simul(order=1, irf=50, nograph);


//save var_names
var_names = M_.endo_names;
//save var_names long
var_names_long = M_.endo_names_long;

//get decimal number of gamma
x     = num2str(gamma);
num_1 = x(1);
if strlength(x) > 2
num_2 = x(3);
else
num_2 = '0';
end


//create Matlab file
@#if preferences
if exist('GHH_irfs.mat', 'file') == 0
	GHH_irfs = struct;
  //save IRFS
  GHH_irfs.eta_g.(['gamma_' num_1 '_' num_2]) = oo_.irfs;
  save 'GHH_irfs.mat' 'GHH_irfs'  'var_names' 'var_names_long'
else
	load GHH_irfs.mat;
  //save IRFS
  GHH_irfs.eta_g.(['gamma_' num_1 '_' num_2]) = oo_.irfs;
  save('GHH_irfs.mat', 'GHH_irfs', '-append');
end;

@#else
if exist('KPR_irfs.mat', 'file') == 0
	KPR_irfs = struct;
  //save IRFS
  KPR_irfs.eta_g.(['gamma_' num_1 '_' num_2]) = oo_.irfs;
  save 'KPR_irfs.mat' 'KPR_irfs'  'var_names'
else
	load KPR_irfs.mat;
  //save IRFS
  KPR_irfs.eta_g.(['gamma_' num_1 '_' num_2]) = oo_.irfs;
  save('KPR_irfs.mat', 'KPR_irfs', '-append');
end;

@#endif


//Plotting the IRFS
figure;
//looping over all variables
for jj=1:1:length(var_names)
subplot(5,3,jj);
plot(1:50, oo_.irfs.([var_names{jj} '_eta_g'])(1:50), 'b', 'linewidth', 2); hold on;
xlabel('time');
ylabel('% deviations from S.S.');
if jj==1
@#if preferences
legend(sprintf('GHH preferences with \\gamma = %g', gamma), 'fontSize',10); //add legend
@#else
legend(sprintf('KPR preferences with \\gamma = %g', gamma), 'fontSize',10); //add legend
@#endif
end

title([M_.endo_names_long{jj} ' (' var_names{jj} ')']); //Use variable names stored in M_.endo_names
sgtitle('IRFs to a Government Spending Shock', 'fontSize',14);

end
