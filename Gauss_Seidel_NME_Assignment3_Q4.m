% Solving AX = b using Gauss Seidel Method
clc;
clear all;

%==========================================================================
%Taking user inputs and declaring variables
disp("Solving AX = b using Gauss Seidel Method");
n = input("Enter the number of equations: ");
A = input("Enter the matrix A : ");
b = input("Enter the matrix b : ");
x = input("Enter initial guess vector X : ");
lambda = input("Enter relaxation parameter : ");
e = input("Enter acceptable percent relative error : ");
x_Temp = x; % To store old values of X for error calculations
%==========================================================================
% rearranging the equations to achieve convergence
for i = 1:n-1
    for j = i:n
        sum = 0;
        for k = 1:n
            if (k == i)
                continue
            else
                sum = sum + abs(A(j,k));
            end
        end
        if abs(A(i,i))>sum
            break
        end
    end
    B = A(i,:); C = b(i);
    A(i,:) = A(j,:); b(i) = b(j);
    A(j,:) = B; b(j) = C;
end
%==========================================================================
% Doing Iterations 
while(true)
    for i = 1:n
        sum = 0;
        for j = 1:n
            if (j==i)
                continue
            else
                sum = sum + A(i,j)*x(j);
            end
        end
        x(i) = (b(i)-sum)/A(i,i); %Caculating new X
        x(i) = lambda*x(i)+(1-lambda)*x_Temp(i);
    end
    if (Stop_Iteration(x,x_Temp,n,e)) % Checking the error
        break
    end
    x_Temp = x;
end
%==========================================================================
%Displaying final results
disp("Values of variables : ");disp(x');
%==========================================================================
% defining a function 'error' which returns boolean 
function logic = Stop_Iteration(E,E_Temp,N,error)
    for i = 1:N
        if (abs((E-E_Temp)/E) > error)
            logic = false;
        else
            logic = true;
        end
    end
end