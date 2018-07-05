function [x_1 , x_2 ] = P_box(z_minus_u_1, z_minus_u_2)

    global r;

    x_1 = min([1-r, max([r, z_minus_u_1])]);
    x_2 = min([1-r, max([r, z_minus_u_2])]);
  
end

