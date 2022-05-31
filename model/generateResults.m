
%% Prelim

% results with no parameter changes
parameters = loadParameters;
main
results_array = [results_row, parameters.gamma, parameters.rho, ...
            parameters.delta, parameters.alpha, parameters.psi, ...
            parameters.elas_D, parameters.a1, parameters.a2, parameters.xi];

        
%% Parameter Ranges

% values to try, excluding default value
gamma_range  = [0.3, 0.7];    % pollution reduction factor from investment
rho_range    = [0.01, 0.10]; % variable cost increase from investment
delta_range  = [0.90, 1.00]; % time discount factor
alpha_range  = [0.3, 0.7];    % chance of party A winning
psi_range    = [0.3, 0.7];    % pollution reduction factor
elas_D_range = [-1, -0.6];  % elasticity of demand
a1_range     = [1.8, 2.2];      % pareto param 1
a2_range     = [1.8, 2.2];      % pareto param 2

param_names = {'gamma', 'rho', 'delta', 'alpha', 'psi', ...
    'elas_D', 'a1', 'a2'};


param_container = containers.Map(param_names, {gamma_range, rho_range, ...
    delta_range, alpha_range, psi_range, elas_D_range, a1_range, a2_range}); 

%param_container = containers.Map({'xi'}, {linspace(2.3907e-6, 2.3944e-6, 20)});

%% Main Loop

% Optimize taxes and prices for each set of parameters
for i = 1:length(param_names)
  
    % for each parameter
    param_name = param_names{i};
    param_range = param_container(param_name);
    n = length(param_range);
    
    % for each value in parameter's value range
    for j = 1:n
        
        % load params with this particular param updated
        parameters = loadParameters(param_name, param_range(j));
        
        % display param value
        disp([newline repmat(' ', 1, 17) repmat('=', 1, 25) newline ...
            repmat(' ', 1, 23)  param_name ' = ' ...
            num2str(param_range(j)) newline ...
            repmat(' ', 1, 17) repmat('=', 1, 25)])
        
        % optimize
        main

        % save to results
        results_row = [results_row, parameters.gamma, parameters.rho, ...
            parameters.delta, parameters.alpha, parameters.psi, ...
            parameters.elas_D, parameters.a1, parameters.a2, parameters.xi];
        results_array = [results_array; results_row];
        
    end
    
end


