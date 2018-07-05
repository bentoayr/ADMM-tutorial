function [] = draw_circle(centers,r)

    clf;
    theta = 0:0.01:2*pi;
    hold on;
    for i = 1:size(centers,1)
       
        x_l = centers(i,1) + r.*cos(theta);
        y_l = centers(i,2) +r.*sin(theta);
        
        scatter(x_l,y_l,1);
    end
    hold off;

end