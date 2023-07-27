function [x_1, x_2, x_3, x_4] = P_coll(z_minus_u_1, z_minus_u_2, z_minus_u_3, z_minus_u_4 , r)
    
    d = sqrt((z_minus_u_1 - z_minus_u_3)^2  + (z_minus_u_2 - z_minus_u_4)^2);
    if (d > 2*r)
        x_1 = z_minus_u_1; x_2 = z_minus_u_2;
        x_3 = z_minus_u_3; x_4 = z_minus_u_4;
        return;
    end  
    x_1 = 0.5*(z_minus_u_1 + z_minus_u_3)  +  r*(z_minus_u_1 - z_minus_u_3)/d;
    x_2 = 0.5*(z_minus_u_2 + z_minus_u_4)  +  r*(z_minus_u_2 - z_minus_u_4)/d;
    x_3 = 0.5*(z_minus_u_1 + z_minus_u_3)  -  r*(z_minus_u_1 - z_minus_u_3)/d;
    x_4 = 0.5*(z_minus_u_2 + z_minus_u_4)  -  r*(z_minus_u_2 - z_minus_u_4)/d;
end

