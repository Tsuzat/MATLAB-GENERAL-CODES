% MATLAB code for position analysis and animation of Quick return mechanism
%link length
l2 = 20;
l1 = 30;
l3 = 60;
l4 = 20;
l7 = 45;

%--------------------------------------------------------------------------
for th=0:0.1:8*pi
    
    %to draw a reference horizontal line at point 0
    plot([-50 50],[0 0]); hold on;
    %to draw a reference horizontal line for slider tool
    plot([-70 40],[45 45]); hold on;
    %to draw a vertical reference line
    plot([0 0],[-10 50]); hold on;
    %to plot a crank
    plot([0 l2*cos(th)],[l1 l1-l2*sin(th)],'o-','linewidth',2); hold on;
    th2 = atan((l2*sin(th)-l1)/(l2*cos(th)));
    if (th2<0)
        th2 = th2+pi;
    end
    
    %to plot lever link
    plot([0 -l3*cos(th2)],[0 l3*sin(th2)],'o-','linewidth',2); hold on;
    th3 = asin((l3*sin(th2)-l7)/l4);
    %to plot link4
    plot([-l3*cos(th2) -l3*cos(th2)-l4*cos(th3)],[l3*sin(th2) l7],'o-','linewidth',2); hold off;
    %plot axis setup
    axis(gca,'equal');
    axis([-100 100 -100 100]);

%animation time period
pause(0.1)

end