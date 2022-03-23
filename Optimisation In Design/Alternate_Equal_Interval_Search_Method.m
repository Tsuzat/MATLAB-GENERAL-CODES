clc;
clear;
f = eval(['@(x)',input('Write function f(x) = ','s')]); %Function equation
x0 = input("Enter initial value: ");
step = input("Enter step: ");
x1 = x0+step;
x2 = x1+step;
accuracy = input("Enter accuracy: ");
x0_max = 100; % to avoid infinity loop

while true
    if f(x2)>f(x1) && f(x0)>f(x1)
        xl = x0;
        xu = x2;
        break;
    end
    x0 = x0+step;
    x1 = x0+step;
    x2 = x1+step;

    if x2>x0_max
        disp("Can't find xl and xu as x2>x0_max");
        break;
    end
end

width = 1e7;
i = 1; %to count iteration

while width>accuracy
    xa = xl + (xu-xl)/3;
    xb = xl + 2*(xu-xl)/3;
    if f(xa)>f(xb)
        xl = xa;
    elseif f(xb)>f(xa)
        xu = xb;
    end
    width = xu-xl;
    i = i + 1;
end
fprintf("\nTotal iterations: %d \n",i);
fprintf("Minimum point : %f \n",(xl+xu)/2);
fprintf("f(%f) = %f \n",(xl+xu)/2,f((xl+xu)/2));