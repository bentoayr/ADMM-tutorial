global y; global rho; global lambda;
n = 100; lambda = 0.7; rho = 1; 
y = sign(sin(0:10*2*pi/(n-1):10*2*pi))' + 0.1*randn(n,1);

% Initialization
u_quad = randn(n,1); u_diff = randn(n-1,2); m_quad = randn(n,1); m_diff = randn(n-1,2);
z = randn(n,1);
 
for i=1:1000
    % Process left nodes
	% First process quad nodes
	for i = 1:n
            [m_quad(i) ,  u_quad(i)] = F_quad( z(i), u_quad(i),i );
        end
	% Second process diff nodes
	for j = 1:n-1 
	[m_diff(j,1),m_diff(j,2),u_diff(j,1),u_diff(j,2)] = F_diff(z(j),z(j+1),u_diff(j,1), 	u_diff(j,2));
        end
    % Process right nodes
    z = 0*z;
    for i = 2:n-1
       z(i)= (m_quad(i) + m_diff(i-1,2) + m_diff(i,1))/3;
    end
    z(1) = (m_quad(1) + m_diff(1,1))/2; 
    z(n) = (m_quad(n) + m_diff(n-1,2))/2;       
end
