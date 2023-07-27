% ADMM Parameters

% 
alpha = 0.001;

% check out reasonable r vs num_balls relations here [http://www.packomania.com]
%r = 0.149;  % r = 0.149; won't work
%num_balls = 10;

r = 0.071;   % r = 0.072; won't work
num_balls = 50;

% Initialization
u_box = rand(num_balls,2);
u_coll = rand(num_balls, num_balls,4);

m_box = rand(num_balls,2);
m_coll =  rand(num_balls, num_balls,4);

z = rand(num_balls,2);

% bookeeping convergence
evol_z = [];
evol_u = [];
evol_m = [];
t = 0;
%% 
while(1)
    t = t+1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    %process left nodes
    %
    %%%%%%%%%%%%%%%%%%%%
        % first process box nodes
        m_box_old = m_box; % bookeeping convergence
        u_box_old = u_box; % bookeeping convergence
        for j = 1:num_balls
            [m_box(j,1) , m_box(j,2) ,  u_box(j,1)  , u_box(j,2)] = F_box( z(j,1), z(j,2), u_box(j,1)  , u_box(j,2)  ,alpha ,r);
        end

        % second process coll nodes
        m_coll_old = m_coll; % bookeeping convergence
        u_coll_old = u_coll; % bookeeping convergence
        for j = 1:num_balls-1
            for k = j+1:num_balls
                [ m_coll(j,k,1)  ,  m_coll(j,k,2) , m_coll(j,k,3) , m_coll(j,k,4) , u_coll(j,k,1), u_coll(j,k,2), u_coll(j,k,3), u_coll(j,k,4)] = F_coll(    z(j,1)   , z(j,2) , z(k,1), z(k,2), u_coll(j,k,1), u_coll(j,k,2), u_coll(j,k,3), u_coll(j,k,4) , alpha , r);         
            end
        end

        

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    %process right nodes
    %
    %%%%%%%%%%%%%%%%%%%%
    
    z_old = z; % bookeeping convergence
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
       
    if (mod(t,1000) == 0)
        evol_u = [evol_u , log(norm(u_box(:) - u_box_old(:)) + norm(u_coll(:) - u_coll_old(:)))];
        evol_m = [evol_m , log(norm(m_box(:) - m_box_old(:)) + norm(m_coll(:) - m_coll_old(:)))];
        evol_z = [evol_z , log(norm(z-z_old)) ];
        subplot(2,1,1);
        axis([0 1 0 1]);
        cla;
        hold on;
        draw_circle(z,r);
        plot([0,0,1,1,0],[0,1,1,0,0],'-');
        hold off;
        
        subplot(2,1,2);
        cla;
        hold on;
        plot(evol_z);
        plot(evol_m);
        plot(evol_u);
        hold off;
        drawnow;
    end
    
end
