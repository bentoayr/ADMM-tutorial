n = 10; p = 4000; y = sign(randn(n,1)); x = randn(p,n); x = [x;ones(1,n)];% Create random data
global rho; rho = 1; global lambda; lambda = 0.1; %Initialization
U_pos  = randn(n,1); U_sum  = randn(n,1); U_norm  = randn(p,1); U_data  = randn(p+2,n);
M_pos  = randn(n,1); M_sum  = randn(n,1); M_norm  = randn(p,1); M_data  = randn(p+2,n);
Z_slack = randn(n,1); Z_plane = randn(p+1,1); 
%ADMM iterations
for t = 1:1000
    [M_pos, U_pos] = F_pos(Z_slack , U_pos); % POSITIVE SLACK
    [M_sum, U_sum] = F_sum(Z_slack , U_sum); % SLACK SUM COST
    [M_norm, U_norm] = F_separation(Z_plane(1:p) , U_norm); % SEPARATION COST
    for i = 1:n  % DATA CONSTRAINT
       [M_data(1,i), M_data(2:end,i),U_data(1,i),U_data(2:end,i)] = F_data( Z_slack(i),Z_plane, 	U_data(1,i),U_data(2:end,i),x(:,i),y(i));
    end
    % Z updates
    Z_slack = M_pos + M_sum; 
    for i = 1:n
        Z_slack(i) = Z_slack(i) + M_data(1,i);
    end
    Z_slack = Z_slack / 3; Z_plane(1:p) = M_norm;
    for i = 1:p
        for j = 1:n
            Z_plane(i) = Z_plane(i) + M_data(i+1,j);
        end
    end
    Z_plane(1:p) = Z_plane(1:p) / (n+1);
    for i = 1:n
        Z_plane(p+1) = Z_plane(p+1) + M_data(p+2,i);
    end
    Z_plane(p+1) = Z_plane(p+1)/n;
end
