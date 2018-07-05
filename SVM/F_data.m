function [M_data,M_plane, new_U_data,new_U_plane] = F_data(Z_slack, Z_plane,U_data_slack,U_data_plane,  x_i, y_i)

    [X_data, X_plane] = P_data( Z_slack - U_data_slack , Z_plane - U_data_plane ,  x_i, y_i);
   
    new_U_data = U_data_slack + (X_data  -  Z_slack);
    new_U_plane = U_data_plane + (X_plane  -  Z_plane);

    M_plane = new_U_plane + X_plane;
    M_data = new_U_data + X_data;

end