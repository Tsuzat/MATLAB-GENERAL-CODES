% This is a code to find root using newton's method
% USING EXACT DIFFERENTIATION

clc;% Clears terminal
clear all;
syms x
% Writing some instructions for user
disp("======== Instructions ========");
disp("1. Use 'exp(x)' for e^x ");
disp("2. Use 'abs(x)' for |x| ");
disp("3. Use 'log(x)' for ln(x) ");
disp("4. Use 'sqrt(x)' for √x ");

f = eval(['@(x)',input('Write function f(x) = ','s')]);% function input
df = matlabFunction(diff(f(x))); % differentiation of f(x)
Xo = input("Enter the initial guess : "); % initial guess
e = input("approximate percent relative error: "); % allowed error
X = [Xo]; % storing Xo and all iterations in a list X
N = 1; % counting for number of iterations
Check_Iteration = true; % conditional boolean

fprintf("Xr = X -(f(X)/df(X))");

% Starting while loop for iterations
while(Check_Iteration) 
    fprintf("\n========Iteration : %d========\n",N);
    %calculating X(n+1)and storing it in X
    fprintf(" X = %d; ",X(end));
    X(end+1) = X(end)-(f(X(end))/df(X(end))); 
    fprintf("f(x) = %d; df(x) = %d; Xr = %d; ",f(X(end-1)),df(X(end-1)),X(end));
    if N == 1
        fprintf("Error = ~\n");
    else
        fprintf("Error = %d\n",Error(X(end),X(end-1)));
    end
    if (Error(X(end),X(end-1))<e) % checking if error is allowed
        Check_Iteration = false; 
    end   
    N = N+1; % increment in iterations
end

fprintf("\nTHE ROOT IS : %d\n",X(end)); % Displaying final answer 
i = 1:N; 
plot(i,X); % plotting curve against i and Xi 

% Defining function 'Error' with inputs Xr and Xr_Old
function y = Error(Xr,Xr_Old)
    y = abs((Xr-Xr_Old)/Xr); % absolute value of error 
end