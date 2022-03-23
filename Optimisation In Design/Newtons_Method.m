clear;
clc;

f = @(x1,x2) (10*x1^4 - 20*x1^2*x2 + 10*x2^2 + x1^2 - 2*x1 +5);

df1 = @(x1,x2) (40*x1^3-40*x1*x2+2*x1-2);
df2 = @(x1,x2) (-20*x1^2+20*x2);

d2f1 = @(x1,x2) (120*x1^2-40*x2+2);
d2f2 = @(x1,x2) 20;
d2f12 = @(x1,x2) (-40*x1);

x = input("Enter the initial guess Vector: ");
epsilon = input("Enter convergence parameter for problem: ");
delta = input("Enter the step size for the 1-D search: ");
eps = input("Enter the convergence parameter for 1-D search: ");

Grf = @(x) [df1(x(1),x(2)) df2(x(1),x(2))];
H = @(x) [d2f1(x(1),x(2)) d2f12(x(1),x(2)) ; d2f12(x(1),x(2)) d2f2(x(1),x(2))];
s = sqrt(sum(Grf(x).^2));

if s<=epsilon
    disp("Convergence has occur");
    fprintf("The variables are %f %f\n",x(1),x(2));
    fprintf("Corresponding function value : %f\n",f(x(1),x(2)));
    return
end

while s > epsilon

    eigH = eig(H(x));
    %checking for positive definiteness of H
    if eigH(1)<0 && eigH(2)<0
        disp("H is not positive definite");
        x = input("Enter new starting point vector: ");
    end

    d = - H(x) \ (Grf(x))'; %d is the search direction according to steepest desent method
    d = d';
    %starting the 1-D search to compute step size alpha -> alp
    alp = 0;
    xold = x; %x = xold + alp*d

    %calculation of initial interval

    a = alp;
    c = a + delta; 
    xa = xold + a*d;
    xc = xold + c*d;
    while f(xc(1),xc(2)) > f(xa(1),xa(2))
        disp("Function is not decreasing with starting point for line search");
        xl = input("Enter another starting point: ");
        a = xl;
        c = a + delta;
    end
    
    b = a + 2*delta;
    xc = xold + c*d;
    xb = xold + b*d;
    while f(xb(1),xb(2)) <= f(xc(1),xc(2))
        a = c;
        c = b;
        b = b + delta;
        xc = xold + c*d;
        xb = xold + b*d;
    end
    
    xl = a;
    xu = b;
    
    %starting the iteration of the method
    while abs(xu-xl) > eps
        a = xl + (xu-xl)/3;
        b = xl + (xu-xl)*2/3;
        xa = xold + a*d; 
        xb = xold + b*d;
        if f(xa(1),xa(2)) < f(xb(1),xb(2)) 
            xu = b;
        elseif f(xa(1),xa(2)) > f(xb(1),xb(2))
            xl = a;
        else
            xl = a;
            xu = b;
        end
    end
    
    alp = (xl+xu)/2;
    x = xold + alp*d;

    s = sqrt(sum(Grf(x).^2));
    if s <= epsilon
        disp("Convergence has occur");
        fprintf("The variables are %f %f\n",x(1),x(2));
        fprintf("Corresponding function value : %f\n",f(x(1),x(2)));
        return
    end
end



