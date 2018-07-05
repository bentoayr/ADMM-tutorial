function [ X ] = P_onlyOne( Z_minus_U )
    %X and Z_minus U are n by one vectors

    X =0*Z_minus_U;
    [~,b] = max(Z_minus_U);
    X(b) = 1;

end