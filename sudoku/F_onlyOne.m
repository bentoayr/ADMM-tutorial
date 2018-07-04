function [ M, new_U ] = F_onlyOne( Z, U )
    %M, Z and U are n by one vectors

    % Compute internal updates
    X = P_onlyOne( Z - U );
   
    new_U = U + (X  -  Z);

    % Compute outgoing messages
    M = new_U + X;
 
end
