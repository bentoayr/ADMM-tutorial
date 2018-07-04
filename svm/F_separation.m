function [M, new_U] = F_separation(Z, U)

    % Compute internal updates
    X = P_separation( Z - U );
   
    new_U = U + (X  -  Z);

    % Compute outgoing messages
    M = new_U + X;
 
end
