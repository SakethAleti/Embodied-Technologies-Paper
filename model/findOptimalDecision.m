function [ ind, ind_I_2a, ind_N_2a, ind_I_2b, ind_N_2b ] = ...
    findOptimalDecision(x, beta, parameters, t_1a, t_2a, p_1a, p_2a, p_2b) 
% =========================================================================
% FINDOPTIMALDECISION returns a firms optimal decision given its x and beta
% =========================================================================
% INPUT ARGUMENTS: (enter any number of pairs)
%   ...
% =========================================================================
% OUTPUT:
%   ind                    (vector) 1 if idle, 2 if producing, 3 if
%                                   investing in period 1
%   ind_I_2a               (vector) assuming a firm is investing in 1a, 
%                                   1 if idle, 2 if producing in period 2a
%   ind_I_2b               (vector) assuming a firm is investing in 1a, 
%                                   1 if idle, 2 if producing in period 2b
%   ind_N_2a               (vector) assuming a firm is producing in 1a, 
%                                   1 if idle, 2 if producing, 3 if 
%                                   investing in period 2a
%   ind_N_2b               (vector) assuming a firm is investing in 1a, 
%                                   1 if idle, 2 if producing, 3 if 
%                                   investing in period 2b
% =========================================================================

%% Unpack params 

beta_hat  = parameters.beta_hat;
price     = parameters.price;
emp       = parameters.emp; 
I_1       = parameters.I_1;
I_2       = parameters.I_2;
gamma     = parameters.gamma;
rho       = parameters.rho;
delta     = parameters.delta;
alpha     = parameters.alpha;


%% Main

% Max profit in period 2a for firms that have invested in period 1
[pi_I_2a, ind_I_2a] = max([0, p_2a - (1+rho)*x - ...
 t_2a*(1-gamma)*beta]);
% Noninvesting max profit in period 2a
[pi_N_2a, ind_N_2a] = max([0, p_2a - x - t_2a*beta, p_2a - x - ...
 t_2a*(1-gamma)*beta - I_2]);

% Max profit in period 2b for firms that have invested in period 1
[pi_I_2b, ind_I_2b] = max([0, p_2b - (1+rho)*x]);
% Noninvesting max profit in period 2b
[pi_N_2b, ind_N_2b] = max([0, p_2b - x]);

% Present value expected profit for a firm investing in period 1
pi_I_1a = p_1a - (1+rho)*x - t_1a*(1-gamma)*beta - I_1 + delta* ...
          (alpha*(pi_I_2a) + (1-alpha)*(pi_I_2b));

% Present value expected profit for a firm producing in period 1
pi_N_1a = p_1a - x - t_1a*beta + delta*(alpha*(pi_N_2a) + (1-alpha)*(pi_N_2b));    


% Firms may exit, produce in period 1, or invest in period 1
profit_mat = [0, pi_N_1a, pi_I_1a];

[~, ind] = max(profit_mat);


end
