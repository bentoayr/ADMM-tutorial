function [ M, new_U ] = F_onlyOne( Z, U )
%M, Z and U are n by one vectors

    X = P_onlyOne( Z - U );
   
    new_U = U + (X  -  Z);

    M = new_U + X;

end