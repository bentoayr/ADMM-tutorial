%Create random data
clc
close all
clear
a=0:0.1:1;
n = 100;
p = 2;
x(1,1:n/2) = (abs(0.1+0.9*rand(1,n/2)));
x(1,n/2+1:n) = (abs(0.1+0.9*rand(1,n/2)));
x(2,1:n/2) = x(1,1:n/2)+0.1*rand(1,n/2);
x(2,n/2+1:n) = x(1,n/2+1:n)-0.1*rand(1,n/2);
x = [x;ones(1,n)];
y=zeros(n,1);
for i=1:n/2
    y(i) = 1;
    plot(x(1,i),x(2,i),'xb','MarkerSize',8);
    hold on
end
for i=n/2+1:n
    y(i)=-1;
    plot(x(1,i),x(2,i),'or','MarkerSize',8);
    hold on
end
ss= abs(rand(1,n));
% y = sign(randn(n,1)); 
% x = randn(p,n);
% x = [x;ones(1,n)];


cvx_begin

    variable gap(n,1);
    variable hyperplane(p+1);

    minimize    (       sum(  gap) +     (0.5/10)* (pow_pos(norm(hyperplane(1:p)),2))                  )

    subject to 
        
        for i =1:n
           y(i)*hyperplane'*x(:,i) >= 1 - gap(i);
        end
        gap >= 0;

cvx_end


global rho;rho = 1;global lambda;lambda = 0.1;

%Initialization
U_pos  = randn(n,1);
U_sum  = randn(n,1);
U_norm  = randn(p,1);
U_data  = randn(p+2,n);

M_pos  = randn(n,1);
M_sum  = randn(n,1);
M_norm  = randn(p,1);
M_data  = randn(p+2,n);

Z_slack = randn(n,1);
Z_plane = randn(p+1,1);
Z_plane(p+1)=randn(1);

%ADMM iterations
for t = 1:2000
    % POSITIVE SLACK
    [M_pos, U_pos] = F_pos(Z_slack , U_pos);
    % SLACK SUM COST
    [M_sum, U_sum] = F_sum(Z_slack , U_sum);
    % SEPARATION COST
    [M_norm, U_norm] = F_separation(Z_plane(1:p) , U_norm);
    % DATA CONSTRAINT
    for i = 1:n
        [M_data(1,i), M_data(2:end,i),   U_data(1,i) , U_data(2:end,i) ] = F_data( Z_slack(i), Z_plane, U_data(1,i),U_data(2:end,i),x(:,i),y(i));
    end
    

    % Z updates
    Z_slack = M_pos + M_sum;
    for i = 1:n
        Z_slack(i) = Z_slack(i) + M_data(1,i);
    end
    Z_slack = Z_slack / 3;
    
    
    
    Z_plane(1:p) = M_norm;
    for i = 1:p
        for j = 1:n
            Z_plane(i) = Z_plane(i) + M_data(i+1,j);
        end
    end
    Z_plane(1:p) = Z_plane(1:p) / (n+1);        
    
    for i = 1:n
        Z_plane(p+1) = Z_plane(p+1)+ M_data(p+2,i);
    end
    Z_plane(p+1) = Z_plane(p+1)/n;
    

% hold on
for i=1:n/2
    y(i) = 1;
    plot(x(1,i),x(2,i),'xb','MarkerSize',8);
    hold on
end
for i=n/2+1:n
    y(i)=-1;
    plot(x(1,i),x(2,i),'or','MarkerSize',8);
    hold on
end
 
h1=plot(a, (-hyperplane(1)*a - hyperplane(3)) / (hyperplane(2)),'g','LineWidth',1);
hold on
h2=plot(a, (-Z_plane(1)*a - Z_plane(3)) / (Z_plane(2)),'m','LineWidth',1);
legend([h1 h2],{'Exact solution' 'ADMM'},'Location','northwest')

set(gca,'fontsize',12)
set(gcf,'color','w')
set(gca,'TickLabelInterpreter','latex')
set(gca, 'FontName', 'Times New Roman')
str = sprintf('Iteration: %d', t);
title(str,'fontweight','normal')
xlim([0 1])
ylim([0 1])
drawnow;
F(t) = getframe(gcf);  
if t<2000
   clf 
end
end

max(abs([Z_slack;Z_plane] - [gap;hyperplane])) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot(y,'b','LineWidth',1)



% hold on
% plot(w,'g','LineWidth',1)    
% % hold on
% plot(z,'r','LineWidth',1)

%legend('Noisy data','Filtered (CVX)','Filtered (ADMM)','fontsize','12','Interpreter','latex')
% legend('Noisy data','Filtered (CVX)','Filtered (ADMM)')

% h1 = plot(z,'r');
% set(h1,'Visible','off')
% hold on

% drawnow;
%pause(1)
% F(t) = getframe(gcf);
% if t<25
%    clf 
% end
%movie(F)

v = VideoWriter('SVM2', 'Motion JPEG AVI');
v.FrameRate = 20; 
v.Quality = 100;
open(v)
writeVideo(v,F)
close(v)



