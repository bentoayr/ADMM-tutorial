function [ x ] = P_quad( z_minus_u, i )
    global y;
    global rho;
    x = (z_minus_u*rho + y(i))/(1+rho);
end
