function [M, new_U] = F_sum(Z, U)

    X = P_sum( Z - U );
   
    new_U = U + (X  -  Z);

    M = new_U + X;

end


