function [ x_1, x_2 ] = P_diff( z_minus_u_1,z_minus_u_2)
    
    global rho;
    global lambda;
    
    beta = max(-lambda/rho, min(lambda/rho,(z_minus_u_2 - z_minus_u_1)/2));
    x_1 = z_minus_u_1 + beta;
    x_2 = z_minus_u_2 - beta;
    
end

