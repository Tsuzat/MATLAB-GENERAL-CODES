%Code to find minimum point and value
% Using Equal Interval Search Method
clc; % clears terminal
clear; % clears workspace
f = eval(['@(x)',input('Write function f(x) = ','s')]); %Function equation
delta = input("Enter Step Size: "); %delta input
accuracy = input("Enter Accuracy: "); %accuracy input
x0 = input("Initial Value: "); %initial value input
xl = x0; % storing it in a temperary variable xl
x0_max = 100; % setting maximum to avoid infinite loop
x1 = 0; % initializing x1
x2 = 0; % initializing x2
width = 1e7; % initial width 1x10^7
i = 1; %to calculate interations
reduction = 1; %reduction

% initializing iterations 
while (width>accuracy)
    q = reduction*delta; %used to increament x0
    x0 = xl;
    % incrementing the value of x0 by q till
    % we find a minimum point
    while (true)
        x1 = x0+q;
        x2 = x1+q;
        %condition to check minimum point
        if (f(x2)>f(x1) && f(x0)>f(x1))
            xl = x0;
            break;
        end
        % handling infinite loop
        if (x0>x0_max)
            fprintf("No solution found x0>x0_max");
            break;
        end
        x0 = x0+q;
    end
    width = x2-xl;
    i = i + 1;
    reduction = reduction/10;
end
fprintf("\nTotal number of iterations: %s \n",num2str(i));
disp("Minimum value : "+ num2str((xl+x2)/2));
disp("f("+num2str((xl+x2)/2)+") = "+ num2str(f((xl+x2)/2)));