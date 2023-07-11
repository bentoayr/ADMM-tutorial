% ADMM Parameters
rho = 1;
global r;
r = 0.15;
num_balls = 10;

% Initialization
u_box = randn(num_balls,2);
u_coll = randn(num_balls, num_balls,4);

m_box = randn(num_balls,2);
m_coll =  randn(num_balls, num_balls,4);

z = randn(num_balls,2);

for t=1:100000
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    %process left nodes
    %
    %%%%%%%%%%%%%%%%%%%%
        % first process box nodes
        for j = 1:num_balls
            [m_box(j,1) , m_box(j,2) ,  u_box(j,1)  , u_box(j,2)] = F_box( z(j,1), z(j,2), u_box(j,1)  , u_box(j,2)  );
        end
        % second process coll nodes
        for j = 1:num_balls-1
            for k = j+1:num_balls
                [ m_coll(j,k,1)  ,  m_coll(j,k,2) , m_coll(j,k,3) , m_coll(j,k,4) , u_coll(j,k,1), u_coll(j,k,2), u_coll(j,k,3), u_coll(j,k,4)] = F_coll(    z(j,1)   , z(j,2) , z(k,1), z(k,2), u_coll(j,k,1), u_coll(j,k,2), u_coll(j,k,3), u_coll(j,k,4) );         
            end
        end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    %process right nodes
    %
    %%%%%%%%%%%%%%%%%%%%
    
    z = 0*z;
    
    for j = 1:num_balls
        z(j,1) = z(j,1) + m_box(j,1);
        z(j,2) = z(j,2) + m_box(j,2);
    end
    for j = 1:num_balls-1
        for k = j+1:num_balls
            z(j,1) = z(j,1) + m_coll(j,k,1);
            z(j,2) = z(j,2) + m_coll(j,k,2);
            z(k,1) = z(k,1) + m_coll(j,k,3);
            z(k,2) = z(k,2) + m_coll(j,k,4);
        end
    end
    z = z / num_balls;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
    
    draw_circle(z,r);
    drawnow;
    %pause(0.01);
end

