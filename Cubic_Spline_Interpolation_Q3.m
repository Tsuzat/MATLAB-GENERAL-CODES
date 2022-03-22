% Cubic Spline Interpolation 

clc;
clear all;
%==========================================================================
% Taking user's inputs and defining variables 
X = input("Enter the values of X (in vector) : ");
Y = input("Enter the values of Y (in vector) : ");
x = input("Enter the value of X for desired Y : ");
n = length(X);
A  = zeros(n);
b = zeros(n,1);

%==========================================================================
% Calculating M (i.e. f''(x))
for i = 1:n
    if (i == 1 || i == n)
        A(i,i) = 1;
        b(i) = 0;
    else
        A(i,i-1) = X(i)-X(i-1);
        A(i,i) = 2*(X(i+1)-X(i-1)); 
        A(i,i+1) = (X(i+1)-X(i));
        b(i) = (6/(X(i+1)-X(i)))*(Y(i+1)-Y(i)) + (6/(X(i)-X(i-1)))*(Y(i-1)-Y(i));
    end
end
M = round(A\b,4);

%==========================================================================
% Finding the location of x
for i = n-1:-1:2
    if (x > X(i-1) && x <= X(i))
        break
    end
end

%==========================================================================
%Calculating value of Y at given value of x
h = X(i)-X(i-1);
f = ((X(i)-x)^3)*(M(i-1)/(6*h)) + ((x-X(i-1))^3)*(M(i)/(6*h));
f = f + (X(i)-x)*((Y(i-1)/h)-(M(i-1)*(X(i)-X(i-1))/6));
f = f + (x-X(i-1))*((Y(i)/h)-(M(i)*(X(i)-X(i-1))/6));

%==========================================================================
% Displaying the calculated value of Y (or f(x)) at given x 
str = ['Value of Y (i.e. f(x)) for x = ',num2str(x),' is equal to ',num2str(f)];
disp(str);   