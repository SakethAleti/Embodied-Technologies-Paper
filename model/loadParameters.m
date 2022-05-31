function [ parameters ] = loadParameters( varargin )
% =========================================================================
% LOADPARAMETERS creates a struct containing the parameters necessary for
% the simulation
% =========================================================================
% INPUT ARGUMENTS: (enter any number of pairs)
%   parameter_name          (string) name of parameter
%   parameter_value         (scalar) value of parameter
% =========================================================================
% OUTPUT:
%   parameters              (struct) contains every parameter value, each
%                                    value can be accessed by typing 
%                                    parameters.parameter_name
% =========================================================================


%% Input error calls

% ensure arguments are given in pairs
if mod(nargin,2) == 1
    error(['Invalid number of arguments. ', ...
          'Use pairs of parameter names and values'])
end

% ensure parameter_name args are strings
for i = 1:2:nargin
    if ~ischar(varargin{i})
        error(['Argument ', num2str(i), ' is not a string'])
    end
end

% ensure parameter_name args are numeric
for i = 2:2:nargin
    if ~isnumeric(varargin{i})
        error(['Argument ', num2str(i), ' is not numeric'])
    end
end


%% Default parameters
% beta_hat, pollution and cost variables scaled down by 1e3
parameters.omega    = 0.25;
parameters.beta_hat = 1950*1e3/6668;        % max pollution intensity = 
                                            % 1950*1e6/6668
parameters.price    = 103.40*599.88;        % price of electricity per GWh 
                                            % (10.34 US cents per kWh)
parameters.emp      = 29.4*4e6;             % input cost in the industry ($29.4 per MWh
                                            % in 2013
                                            % https://www.eia.gov/outlooks/archive/aeo15/pdf/electricity_generation_2015.pdf
parameters.I_1      = 36.90*599.88;         % cost of investment in period 1 
                                            % (levelized cost of advanced coal, 97.3,
                                            % minus levelized capital cost of conventional coal)
                                            % multiplied by 599.88 GWh per
                                            % plant
parameters.I_2      = parameters.omega*parameters.I_1; 
                                            % cost of investment in period 2
parameters.gamma    = 0.5;                  % pollution reduction factor from investment
parameters.rho      = 0.05;                 % variable cost increase from investment
parameters.delta    = 0.95;                 % time discount factor
parameters.alpha    = 0.50;                 % chance of party A winning
parameters.xi       = 2.392e-6;                 % social cost of pollution stock factor
parameters.psi      = 0.50;                 % pollution reduction factor
parameters.elas_D   = -0.82;                % elasticity of demand
parameters.a1       = 2;                    % pareto param 1
parameters.a2       = 2;                    % pareto param 2


%% Update parameters based on arguments

for i = 1:2:nargin
    eval(['parameters.', varargin{i}, '=', num2str(varargin{i+1}), ';']);
end


end

