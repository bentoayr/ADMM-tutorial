function [ m_1, m_2, new_u_1, new_u_2 ] = F_diff( z_1, z_2, u_1, u_2 )


    [x_1, x_2] = P_diff(z_1  -  u_1, z_2 - u_2);
   
    new_u_1 = u_1 + (x_1  -  z_1);
    new_u_2 = u_2 + (x_2  -  z_2);

    m_1 = new_u_1 + x_1;
    m_2 = new_u_2 + x_2;


end

