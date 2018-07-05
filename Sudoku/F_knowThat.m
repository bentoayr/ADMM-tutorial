function [ M, new_U ] = F_knowThat(k, Z, U )
%   Detailed explanation goes here

    X = P_knowThat(k, Z - U );
   
    new_U = U + (X  -  Z);

    M = new_U + X;


end

