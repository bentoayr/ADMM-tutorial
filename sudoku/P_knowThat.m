function [ X ] = P_knowThat( k, Z_minus_U )
    %Z_minus_U is an n by 1 vector
 
    X = 0*Z_minus_U;
    X(k) = 1;
 
end
