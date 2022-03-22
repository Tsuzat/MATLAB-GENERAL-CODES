%  Gauss-Quadrature formula to Solve integration
clc;
clear all;
%==========================================================================
%Taking User's input
disp("______ USING Gauss-Quadrature formula to Solve integration ______");
f = eval(['@(x,y)',input('Enter the function f(x,y) = ','s')]);
ax = input("Enter the lower limit for x: ");
bx = input("Enter the upper limit for x: ");
ay = input("Enter the lower limit for y: ");
by = input("Enter the upper limit for y: ");
nx = input("Enter the Gaussian Point in x direction: ");
ny = input("Enter the Gaussian Point in y direction: ");
xi = input("Enter Xi nodes(in vector): "); 
Cxi = input("Enter Xi weight(in vector) :"); 
yi = input("Enter Yi nodes(in vector): "); 
Cyi = input("Enter Yi weight(in vector) :");
%==========================================================================

one = (bx-ax)/2;
two = (bx+ax)/2;
three = (by-ay)/2;
four = (by+ay)/2;

sum = 0;
for i =1:nx
    for j = 1:ny
        x = one*xi(i)+two;
        y = three*yi(j)+four;
        sum = sum + (Cxi(i)*Cyi(j))*f(x,y);
    end
end
str = ['Value of calculated integral is : ',num2str(one*three*sum)];
disp(str);