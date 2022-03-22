% This is a code to find root using Bisection Method

clc;   % Clears terminal
clear all;

% Writing some instructions for user
disp("======== Instructions ========");
disp("1. Do use 'exp(x)' for e^x ");
disp("2. Do use 'abs(x)' for |x| ");
disp("3. Do use 'log(x)' for ln(x) ");
disp("4. Do use 'sqrt(x)' for √x ");

% Taking users' input

f = eval(['@(x)',input('Write function f(x) = ','s')]); %Function equation 
Xl = input("Lower bound (Xl): "); % Lower Limit
Xu = input("Upper bound (Xu): "); % Upper Limit 
e = input("approximate percent relative error: "); % Maximum allowed error
Xr = 1; % Initializing Xr to avoid initial errors like division by '0'
Xr_Old = 0; % Variable to store old value of Xr for error calculation
Check_Iteration = true; % Initializing a boolen for logics

N = 1; % No of iterations

%Initializing while loop with condition that calculated error < allowed error 
while (Check_Iteration)
    
    fprintf("\n==========Iteration : %d ========== \n",N);
    
    fprintf("Xl = %d ; Xu = %d ; ",Xl,Xu);
    
    Xr = (Xl+Xu)/2; % Calculating Xr
    
    fprintf("Xr = %d ",Xr);
    
    fprintf(" f(Xl) = %d; f(Xr) = %d; ",f(Xl),f(Xr));
    
    if (f(Xr)*f(Xl)<0)
        Xu = Xr;
        fprintf(" 'f(Xr)*f(Xl)<0' ");
    elseif (f(Xr)*f(Xl)>0)
        Xl = Xr;
        fprintf(" 'f(Xr)*f(Xl)>0' ");
    elseif (f(Xr)*f(Xl)==0)
        fprintf(" 'f(Xr)*f(Xl)=0' ");
        Check_Iteration = false;
    end
    
    % Checking if calculated error is less or equal to allowed error
    if (N == 1)
        fprintf(" Error = ~\n");
    else
        fprintf(" Error = %d\n",Error(Xr,Xr_Old));
    end
    
    if (Error(Xr,Xr_Old)<= e)
        Check_Iteration = false; 
    end
    
    % assigning value of Xr to Xr_Old
    Xr_Old = Xr; 
    N = N + 1;
end

fprintf("\nTHE VALUE OF ROOT IS : %d.\n",Xr); % Displaying the final answer

% Defining function 'Error' with inputs Xr and Xr_Old
function y = Error(Xr,Xr_Old)
    y = abs((Xr-Xr_Old)/Xr);
end