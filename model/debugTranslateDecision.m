function [] = ...
    debugTranslateDecision(ind, ind_I_2a, ind_N_2a, ind_I_2b, ind_N_2b)
% =========================================================================
% DEBUGTRANSLATEDECISION prints out the firms decisions given a set of 
% indices from findOptimalDecision.m
% =========================================================================
    
%% Main

switch ind
    case 1
        disp('Idle')
        return
    case 2
        disp('Producing in 1A')
        ind_2a = ind_N_2a;
        ind_2b = ind_N_2b;
    case 3
        disp('Investing in 2A')
        ind_2a = ind_I_2a;
        ind_2b = ind_I_2b;   
    otherwise
        error('Unknown index for 1a')
end

switch ind_2a
    case 1
        disp('   Idle in 2A')
    case 2
        disp('   Producing in 2A')
    case 3
        disp('   Investing in 2A')
    otherwise
        error('Unknown index for 2a')
end  

switch ind_2b
    case 1
        disp('   Idle in 2B')
    case 2
        disp('   Producing in 2B')
    case 3
        disp('   Investing in 2B')
    otherwise
        error('Unknown index for 2b')
end  

end

           