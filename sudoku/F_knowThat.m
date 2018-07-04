function [ M, new_U ] = F_knowThat(k, Z, U )
    
    % Compute internal updates
    X = P_knowThat(k, Z - U );
   
    new_U = U + (X  -  Z);

    % Compute outgoing messages
    M = new_U + X;
 
end
