
%% Prelims

parameters = loadParameters('example_param', 5');
parameters_original = parameters;


%% Optimize Taxes/Prices

M = 3; % total iterations
N = 5; % max iterations spent optimizing each subiteration
tol_f = @(M) 10^(3-M);
p_guess = [11.5, 11.5, 11.5]; % guess for [p_1a, p_2a, p_2b]
t_guess = [5, 5];
tax_1a_type = 'optimal';
tax_2a_type = 'optimal';

[t_1a_opt, t_2a_opt, p_1a_opt, p_2a_opt, p_2b_opt] = ...
    optimizeTaxesPrices(parameters, p_guess, t_guess, M, N, ...
    tol_f, tax_1a_type, tax_2a_type);

t_1a  = t_1a_opt;
t_2a  = t_2a_opt;
p_1a = p_1a_opt;
p_2a = p_2a_opt;
p_2b = p_2b_opt;


%% Check Decisions

x_points    = 5;
beta_points = 5;

x_range = linspace(0, max([p_1a, p_2a, p_2b]), x_points);
beta_range = linspace(0, parameters.beta_hat, beta_points);

for i = 1:length(x_range)
    
    x = x_range(i);
    
    for j = 1:length(beta_range)
        
        beta = beta_range(j);

        [ ind, ind_I_2a, ind_N_2a, ind_I_2b, ind_N_2b ] =               ...
            findOptimalDecision(x, beta, parameters, t_1a, t_2a, p_1a,  ...
            p_2a, p_2b);

        fprintf('(x, beta) = (%f, %f)\n', x, beta)

        debugTranslateDecision(ind, ind_I_2a, ind_N_2a, ...
            ind_I_2b, ind_N_2b)
            
    end
    
end
            
            
            
            
            
            
            
            