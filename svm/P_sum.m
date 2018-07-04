function [X] = P_sum(Z_minus_U)
    
    global rho
    
    X =  Z_minus_U  - (1 / rho);
    
end
