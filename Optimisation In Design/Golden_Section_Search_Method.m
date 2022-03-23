clc;
clear;
f = eval(['@(x)',input('Write function f(x) = ','s')]); %Function equation
x0 = input("Enter initial value: ");
accuracy = input("Enter Accuracy: ");
step = input("Enter step: ");
x1 = x0+step;
x2 = x1+step;
x0_max = 100;
% to find the interval
while true
    fprintf("f(%f) = %f, f(%f) = %f, f(%f) = %f \n",x0,f(x0),x1,f(x1),x2,f(x2));
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

fprintf("\nInterval (%f, %f)\n",x0,x2);

w = @(x)((x-xl)/(xu-xl));
accuracy_W = abs(w(accuracy));

aw = 0;
bw = 1;
Lw = 1;
i = 1;
%iterations
while Lw > accuracy_W
    fprintf("========Iteration %d =========\n",i);
    w1 = aw + 0.618*Lw;
    w2 = bw - 0.618*Lw;
    fprintf("w1 = %f, w2 = %f\n",w1,w2);
    if f(w(w1))>f(w(w2))
        fprintf("since f(w(w1)) > f(w(w2)) so bw = w1\n");
        bw = w1;
    elseif f(w(w2))>f(w(w1))
        fprintf("since f(w(w1)) < f(w(w2)) so aw = w2\n");
        aw = w2;
    end
    Lw = abs(bw-aw);
    fprintf("Lw = %f\n",Lw);
    i = i + 1;
end
x1 = aw*(xu-xl) + xl;
x2 = bw*(xu-xl) + xl;

fprintf("Minimum point: %f \n",(x1+x2)/2);
fprintf("f(%f) = %f \n",(x1+x2)/2,f((x1+x2)/2));