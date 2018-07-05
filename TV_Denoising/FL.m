close all
clc
clear
close all
% ADMM Parameters
n = 100;
global y;
global rho;
global lambda;

y = sign(sin(0:10*2*pi/(n-1):10*2*pi))' + 0.1*randn(n,1);


cvx_begin
variable w(n,1)

minimize (   0.5*(w-y)'*(w-y)   +   lambda*norm(w(2:end)-w(1:end-1),1)      )
cvx_end

plot(y,'b','LineWidth',1)
xlim([0 100])
ylim([-1.5 2])
set(gca,'fontsize',12)
set(gcf,'color','w')
set(gca,'TickLabelInterpreter','latex')
set(gca, 'FontName', 'Times New Roman')
% title(['Iteration: ' t])
% str = sprintf('Iteration: %d', t);
% title(str,'fontweight','normal')
F(1) = getframe(gcf);
F(2) = getframe(gcf);
hold on
plot(w,'g','LineWidth',1) 
set(gcf,'color','w')
F(3) = getframe(gcf);
lambda = 0.7;

% ADMM parameter
rho = 1;

% Initialization
u_quad = randn(n,1);
u_diff = randn(n-1,2);

m_quad = randn(n,1);
m_diff = randn(n-1,2);

z = randn(n,1);

for t=1:25
    
    %%%%%%%%%%%%%%%%%%%%
    %
    %process left nodes
    %
    %%%%%%%%%%%%%%%%%%%%%
        % first process quad nodes
        for i = 1:n
            [m_quad(i) ,  u_quad(i)] = F_quad( z(i), u_quad(i),i );
        end
        % second process diff nodes
        for j = 1:n-1
            [ m_diff(j,1), m_diff(j,2), u_diff(j,1), u_diff(j,2)] = F_diff( z(j), z(j+1) , u_diff(j,1), u_diff(j,2) );
        end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    %%%%%%%%%%%%%%%%%%%%%
    %
    %process right nodes
    %
    %%%%%%%%%%%%%%%%%%%%%
    z = 0*z;
    for i = 2:n-1
       z(i)= (m_quad(i) + m_diff(i-1,2) + m_diff(i,1))/3;
    end
    z(1) = (m_quad(1) + m_diff(1,1))/2;
    z(n) = (m_quad(n) + m_diff(n-1,2))/2;

plot(y,'b','LineWidth',1)
xlim([0 100])
ylim([-1.5 2])
set(gca,'fontsize',12)
set(gca,'TickLabelInterpreter','latex')
set(gca, 'FontName', 'Times New Roman')
set(gcf,'color','w')
% title(['Iteration: ' t])
str = sprintf('Iteration: %d', t);
title(str,'fontweight','normal')

hold on
plot(w,'g','LineWidth',1)    
set(gca,'color','w')

% hold on
plot(z,'r','LineWidth',1)
set(gcf,'color','w')

%legend('Noisy data','Filtered (CVX)','Filtered (ADMM)','fontsize','12','Interpreter','latex')
legend('Noisy data','Filtered (Exact solution)','Filtered (ADMM)')

% h1 = plot(z,'r');
% set(h1,'Visible','off')
% hold on

drawnow;
%pause(1)
F(t+3) = getframe(gcf);
if t<25
   clf 
end
end
%movie(F)

v = VideoWriter('Lasso', 'Motion JPEG AVI');
v.FrameRate = 3; 
v.Quality = 100;
open(v)
writeVideo(v,F)
close(v)
