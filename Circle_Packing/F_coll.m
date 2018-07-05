function [m_1,m_2,m_3,m_4,new_u_1,new_u_2,new_u_3,new_u_4] = F_coll(z_1,z_2,z_3,z_4,u_1,u_2,u_3,u_4)
    % Compute internal updates
    [x_1,x_2,x_3,x_4] = P_coll(z_1-u_1,z_2-u_2,z_3-u_3,z_4-u_4);
   
    new_u_1 = u_1-(z_1-x_1); new_u_2 = u_2-(z_2-x_2);
    new_u_3 = u_3-(z_3-x_3); new_u_4 = u_4-(z_4-x_4);
    
    % Compute outgoing messages
    m_1 = new_u_1 + x_1; m_2 = new_u_2 + x_2;
    m_3 = new_u_3 + x_3; m_4 = new_u_4 + x_4;  
end
