function [M, new_U] = F_pos(Z , U)

    X = P_pos( Z - U );
   
    new_U = U + (X  -  Z);

    M = new_U + X;

end