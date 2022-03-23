clear;
clc;

% defining the function of 3 variables and it's three partial fraction
f = @(x1,x2,x3) (x1.^2+2*x2.^2+2*x3.^2+2*x1*x2+2*x2*x3);
df1 = @(x1,x2,x3) (2*x1 + 2*x2);
df2 = @(x1,x2,x3) (4*x2 + 2*x1 + 2*x3);
df3 = @(x1,x2,x3) (4*x3 + 2*x2);

x = input("Enter initial guess vector: ");
epsilon = input("Enter convergence parameter for problem: ");
delta = input("Enter the step size for the 1-D search: ");
eps = input("Enter the convergence parameter for 1-D search: ");

%calculation for gradient vector c and its magnitude |c|, Grf:Gradient
% vector of the function to be minimize

Grf = [df1(x(1),x(2),x(3)) df2(x(1),x(2),x(3)) df3(x(1),x(2),x(3))];
s = sqrt(sum(Grf.^2));
if s<=epsilon
    disp("Convergence has occur");
    fprintf("The variables are %f %f %f\n",x(1),x(2),x(3));
    fprintf("Corresponding function value : %f\n",f(x(1),x(2),x(3)));
    return
end

d = 0;
Grf_pre = Grf;
beta = Grf/Grf_pre;

while s > epsilon
    d = -Grf + beta*d; %d is the search direction according to Conjugate Gradient method

    %starting the 1-D search to compute step size alpha -> alp
    alp = 0;
    xold = x; %x = xold + alp*d

    %calculation of initial interval

    a = alp;
    c = a + delta; 
    xa = xold + a*d;
    xc = xold + c*d;
    while f(xc(1),xc(2),xc(3)) > f(xa(1),xa(2),xa(3))
        disp("Function is not decreasing with starting point for line search");
        xl = input("Enter another starting point: ");
        a = xl;
        c = a + delta;
    end
    
    b = a + 2*delta;
    xc = xold + c*d;
    xb = xold + b*d;
    while f(xb(1),xb(2),xb(3)) <= f(xc(1),xc(2),xc(3))
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
        if f(xa(1),xa(2),xa(3)) < f(xb(1),xb(2),xb(3)) 
            xu = b;
        elseif f(xa(1),xa(2),xa(3)) > f(xb(1),xb(2),xb(3))
            xl = a;
        else
            xl = a;
            xu = b;
        end
    end
    %disp("Conversence in 1-D line has occur");
    alp = (xl+xu)/2;
    %fprintf("The value of alpha in this iteration is %f\n",alp);
    x = xold + alp*d;
    %fprintf("The value of new iterates are %f %f %f\n", x(1),x(2),x(3));

    Grf = [df1(x(1),x(2),x(3)) df2(x(1),x(2),x(3)) df3(x(1),x(2),x(3))];
    beta = Grf / Grf_pre;
    Grf_pre = Grf;
    s = sqrt(sum(Grf.^2));
    if s <= epsilon
        disp("Convergence has occur");
        fprintf("The variables are %f %f %f\n",x(1),x(2),x(3));
        fprintf("Corresponding function value : %f\n",f(x(1),x(2),x(3)));
        return
    end
end