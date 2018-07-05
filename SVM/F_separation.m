function [M, new_U] = F_separation(Z, U)

    X = P_separation( Z - U );
   
    new_U = U + (X  -  Z);

    M = new_U + X;

end

