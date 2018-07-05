function [X_data, X_plane] = P_data(Z_slack_minus_U_data_slack, Z_plane_minus_U_data_plane, x_i, y_i)

if (y_i*Z_plane_minus_U_data_plane'*x_i >= 1 - Z_slack_minus_U_data_slack)
    
    X_data = Z_slack_minus_U_data_slack;
    X_plane = Z_plane_minus_U_data_plane;
    
else
    beta = ((1-[1;y_i*x_i]'*[Z_slack_minus_U_data_slack;Z_plane_minus_U_data_plane])/([1;y_i.*x_i]'*[1;y_i*x_i]));
    X_data = Z_slack_minus_U_data_slack + beta;
    X_plane = Z_plane_minus_U_data_plane + beta*y_i*x_i;

end

