
%% Prelims

% loads predefined parameters and updates with user-defined changes
% parameters = loadParameters('gamma', 0.5);
% loadParameters('example_param', 5') => parameters.example_param = 5
% can input any number of param_name, param_value pairs to this function


%% Example Run

% just guesses
parameters.taxes_1a  = 416.02;
parameters.taxes_2a  = 242.94;
parameters.prices_1a = 88394;
parameters.prices_2a = 88394;
parameters.prices_2b = 88394;

% debug params
debug = struct;
debug.taxes = 1;  
debug.prices = 1; 
debug_off = debug;
debug_off.taxes = 0;
debug_off.prices = 0;

fprintf(['\n' repmat('=', 1, 55) '\nRunning Example Simulation...\n\n'])

% the following is a single run of the simulation with the given taxes and
% prices, the debug params are turned on so it will show what the partial
% eq (?) optimal taxes are and the differences in quantities supplied and
% demanded; both are helpful in finding the true optimal parameters
[firm_data, tax_residual, output_residual, output_aggregates,          ...
    pollution_aggregates, employment_aggregates, welfare, surplus ] =  ...
    runSimulationSingle( parameters, debug ); %#ok<ASGLU>

fprintf([repmat('=', 1, 55) '\n'])


%% Optimization Params

M = 5; % total iterations
N = 5; % max iterations spent optimizing each price
tol_f = @(M) 10^(3-M);
p_guess = [1, 1, 1]*88394; % guess for [p_1a, p_2a, p_2b]
t_guess = [1.7, 1]*243;
tax_1a_type = 'optimal';
tax_2a_type = 'optimal';


%% Optimize Taxes/Prices

[t_1a_opt, t_2a_opt, p_1a_opt, p_2a_opt, p_2b_opt] = ...
    optimizeTaxesPrices(parameters, p_guess, t_guess, M, N, ...
    tol_f, tax_1a_type, tax_2a_type);

parameters.taxes_1a  = t_1a_opt;
parameters.taxes_2a  = t_2a_opt;
parameters.prices_1a = p_1a_opt;
parameters.prices_2a = p_2a_opt;
parameters.prices_2b = p_2b_opt;

p_guess = [p_1a_opt, p_2a_opt, p_2b_opt];
t_guess = [t_1a_opt, t_2a_opt];


%% Results 

[firm_data, tax_residual, output_residual, output_aggregates,          ...
    pollution_aggregates, employment_aggregates, welfare, surplus ] =  ...
    runSimulationSingle( parameters, debug_off);

fprintf('\nSocial Welfare at Computed Optimal T&P: %f\n', welfare(1))

% firms_producing_1a, firms_producing_2a, firms_producing_2b,
% firms_investing_1a, firms_investing_2a, firms_investing_2b,
% firms_idle_1a, firms_idle_2a, firms_idle_2b, output_1a, output_2a,
% output_2b, pollution_1a, pollution_2a, pollution_2b, employment_1a, 
% employment_2a, employment_2b, welfare_social, welfare_1a, welfare_2a, 
% welfare_2b, producer_surplus_1a, producer_surplus_2a,
% producer_surplus_2b, consumer_surplus_1a, consumer_surplus_2a,
% consumer_surplus_2b, taxes_1a, taxes_2a, prices_1a, prices_2a, prices_2b

results_row = [reshape(firm_data', 1, 9), output_aggregates,       ...
    pollution_aggregates, employment_aggregates, welfare, surplus,  ...
    parameters.taxes_1a, parameters.taxes_2a, parameters.prices_1a, ...
    parameters.prices_2a, parameters.prices_2b];
