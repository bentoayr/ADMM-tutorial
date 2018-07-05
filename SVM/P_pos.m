function [X] = P_pos(Z_minus_U)

    X = max(Z_minus_U,0);

end
