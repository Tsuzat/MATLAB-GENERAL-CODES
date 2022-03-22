% This is a code to find root using newton's method
% USING difference approximation for the derivative

clc;   % Clears terminal
% Writing some instructions for user
disp("======== Instructions ========");
disp("1. Do use 'exp(x)' for e^x ");
disp("2. Do use 'abs(x)' for |x| ");
disp("3. Do use 'log(x)' for ln(x) ");
disp("4. Do use 'sqrt(x)' for √x ");

f = eval(['@(x)',input('Write function f(x) = ','s')]);% function input
h = 0.001; % initializing h for differentiation
Xo = input("Enter the initial guess : "); % initial guess
e = input("approximate percent relative error: "); % allowed error
X = [Xo]; % storing Xo and all iterations in a list X
N = 1; % counting for number of iterations
Check_Iteration = true; % conditional boolean

% Starting while loop for iterations
while(Check_Iteration) 
    
    %calculating differentiation of f(x) at x = X(end)
    df = (f(X(end)+h)-f(X(end)))/h;
    
    %calculating X(n+1)and storing it in X
    X(end+1) = X(end)-(f(X(end))/df);  
    
    N = N+1; % increment in iterations
    if (Error(X(end),X(end-1))<e) % checking if error is allowed
        Check_Iteration = false; 
    end
    
end

Xi = ['The value of root is ',num2str(X(end))]; 
disp(Xi); % Displaying final answer 
i = 1:N; 
plot(i,X); % plotting curve against i and Xi 

% Defining function 'Error' with inputs Xr and Xr_Old
function y = Error(Xr,Xr_Old)
    y = abs((Xr-Xr_Old)/Xr); % absolute value of error 
end

