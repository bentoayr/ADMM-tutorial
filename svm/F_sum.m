function [M, new_U] = F_pos(Z , U)
    % Compute internal updates
    X = P_pos( Z - U );
   
    new_U = U + (X  -  Z);

    % Compute outgoing messages
    M = new_U + X;
 
end
