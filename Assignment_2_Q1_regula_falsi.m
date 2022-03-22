% This is a code to find root using regula falsi Method

clc;   % Clears terminal
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
Check_Iteration = true;

disp("Xr = Xl - (f(Xl)*(Xu-Xl))/(f(Xu)-f(Xl))");
N = 1; % No of Iterations

%Initializing while loop with condition that calculated error < allowed error 
while (Check_Iteration)
    
    fprintf("\n==========Iteration : %d ========== \n",N);
    
    fprintf("Xl = %d; Xu = %d; f(Xl) = %d; f(Xu) = %d; ",Xl,Xu,f(Xl),f(Xu));
    
    Xr = Xl - (f(Xl)*(Xu-Xl))/(f(Xu)-f(Xl)); % Calculating Xr
    
    fprintf(" Xr = %d; ",Xr);
    
    % Checking if calculated error is less or equal to allowed error
    if (N == 1)
        fprintf(" Error = ~\n");
    else
        fprintf(" Error = %d\n",Error(Xr,Xr_Old));
    end
    if (Error(Xr,Xr_Old)<= e)
        Check_Iteration = false;
    end
    % assigning value of Xr to Xr_Old and Xl
    Xr_Old = Xr; 
    Xl = Xr;
    N = N + 1;
end

fprintf("\nTHE VALUE OF ROOT : %d\n",Xr); % Displaying the final answer

% Defining function 'Error' with inputs Xr and Xr_Old
function y = Error(Xr,Xr_Old)
    y = abs((Xr-Xr_Old)/Xr);
end