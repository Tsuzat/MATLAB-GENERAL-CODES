%This is a code to find Quadratic curve fitting
 
clc;
clear all;

%==========================================================================
% Taking User inputs and declaring variables
disp("____Finding values of 'a', 'b' and 'c' in Quadratic curve y = ax^2+bx+c____");
X = input("Enter values of X in form of vector : ");
Y = input("Enter values of Y in form of vector : ");
[~,n] = size(X); % Getting no. of Xs and Ys 
%==========================================================================
fprintf("\nX = ");disp(X);
fprintf("\nY = ");disp(Y);
fprintf("\nX^2 = ");disp(X.^2);
fprintf("\nX^3 = ");disp(X.^3);
fprintf("\nX^4 = ");disp(X.^4);
fprintf("\nY*X = ");disp(X.*Y);
fprintf("\nY*X^2 = ");disp(X.^2.*Y);

%==========================================================================
% Calculating the values of variables using matrix method
A = [sum(X.^4) sum(X.^3) sum(X.^2); sum(X.^3) sum(X.^2) sum(X); sum(X.^2) sum(X) n];
b = [sum(X.^2.*Y); sum(X.*Y); sum(Y)];
a_b_c = A\b; % Solving for values of a, b and c
fprintf("\nValue of variable a,b and c = ");disp(a_b_c');

%==========================================================================
% Calculating Coefficient of determination
sum1 = 0;
sum2 = 0;
Y_avg = sum(Y)/n;
fprintf("\nY_avg = ");disp(Y_avg);
for i = 1:n
    sum1 = sum1 + (Y(i)-Y_avg)^2;
    sum2 = sum2 + (Y(i) - a_b_c(1)*X(i)^2 - a_b_c(2)*X(i) - a_b_c(3))^2; 
end
St = sum1/n;
fprintf("\nSt = ");disp(St);
Sr = sum2/n;
fprintf("\nSr = ");disp(Sr);
r_Square = 1 - Sr/St;

%==========================================================================
% Displaying Answers
disp("===============================================================");
[n,~] = size(a_b_c);
disp("Displaying answers by doing manual operations");
for i = 1:n
    str = [sprintf('The value of %s is : ',char(96+i)),num2str(a_b_c(i))];
    disp(str); % Displaying values of variables a,b and c
end

str = ['Coefficient of determination is : ',num2str(r_Square)];
disp(str); % Displaying value of Coefficient of determination

disp("===============================================================");
disp("Displaying value of a,b and c using MATLAB function polyfit(x,y,n)"); 
disp(polyfit(X,Y,2));