function [ m, new_u] = F_quad(z, u, i)

    % Compute internal updates
    x = P_quad(z  -  u, i);
   
    new_u = u + (x  -  z);
    % Compute outgoing messages
    m = new_u + x;
 
end
