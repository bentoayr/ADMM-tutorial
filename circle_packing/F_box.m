function [m_1, m_2, new_u_1, new_u_2] = F_box(z_1, z_2, u_1, u_2)

    % compute internal updates
    [x_1 , x_2] = P_box(z_1 - u_1, z_2 - u_2);
    
    new_u_1 = u_1 - (z_1 - x_1);
    new_u_2 = u_2 - (z_2 - x_2);

    % compute outgoing messages
    m_1 = new_u_1 + x_1;
    m_2 = new_u_2 + x_2;
end
