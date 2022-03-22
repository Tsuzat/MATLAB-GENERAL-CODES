% Newton Raphson Method to solve linear equations with multiple variables

clc; % clears the terminal 
clear; % clears the workspace
% disp("======== Instructions ========"); % Displaying some instructions 
% disp("1. Do use 'exp(x)' for e^x. 2. Do use 'abs(x)' for |x|");
% disp("3. Do use 'log(x)' for ln(x). 4. Do use 'sqrt(x)' for √x  ");
% disp("5. The code might get crashed for particular initial guess");

% DEFINING THE VARIABLES ARE BEING USED

N = input("Enter the number of equations : "); %Inputting no. of variables
Xns = strjoin(compose('x%d', 1:N), ',');%composing a string containing variables
F = cell(N,1); % Initializing cell to store equations
J = []; % For storing realtime jacobian matrix
B = []; % for storing real time values of functions
f = 0; % to store real time value of a function
Check_Iterations = true; % boolean to check logics
h = 0.0001; % Initializing h for calculation of differentiation
Xs = cell(N,1); % to contain values of variables at real time

% Inputting Functions and storing in F cell
for i = 1:N  
    func_str = input("Write function f(x1,x2,...xn): ",'s');
    F{i} = str2func(sprintf('@(%s) %s', Xns, func_str));
end

% Inputting initial Guesses and storing in Xs cell 
for k = 1:N
   str = input(sprintf('Enter initial guess of x%d: ',k),'s');
   Xs{k} = str2double(str);
end
e = input("Approximate percent relative error: "); % Inputting allowed error
n = 1; % no. of iterations

% INITIATING WHILE LOOP UNDER CONDITION THAT IF VALUE OF VARIABLES IS
% SATISFYING approximate percent relative error
while(Check_Iterations)
    
    fprintf("\n============== Iteration : %d ==============\n",n);
    
    for i = 1:N
        fprintf("\nX%d = %d\n",i,Xs{i});
    end
    
    % Calculating 'J' jacobian matrix using nested for loop 
    for i = 1:N
        B(i)= F{i}(Xs{:}); % storing the value of functions in B
        for j = 1:N
            
            % For calculation of f'(x) using difference method
            f = F{i}(Xs{:}); % Realtime value of function
            Xs{j} = Xs{j}+h; % adding h to calculate f'(x)
            J(i,j) = (F{i}(Xs{:})-f)/h;
            Xs{j} = Xs{j}-h; % Nullifying addition of h
        end
    end
    
    fprintf("\nJ = \n");disp(J);
    fprintf("\nb = \n");disp(B');
    
    X = J\B'; % Calculating Δx and assigning it in X
    
    fprintf("\nΔX = \n");disp(X); 
    
    % Iterating values of Variables stored in Xs
    for k = 1:N
        Xs{k} = Xs{k}- X(k);
    end
    
    fprintf("\nX = \n");disp(Xs);
    
    % Checking for approximate percent relative errors for all variables.
    % If all variables satisfies the conditions Check_Iterations will be
    % changed to 'false' and while loop will stop, otherwise iteration
    % will be continued. 
    
    for k = 1:N
        if (n==1)
            fprintf(" Error e%d of X%d = ~\n",k,k);
        else
            fprintf(" Error e%d of X%d = %d\n",k,k,abs(X(k)/Xs{k}));
        end
        if (abs(X(k)/Xs{k})<e) % If error is less than 'e'
            Check_Iterations = false;
        else
            Check_Iterations = true;
        end
    end
    n = n+1;
end

% Displaying the root value of variables
for i = 1:N
        fprintf("\nTHE VALUE OF ROOT X%d = %d ; \n",i,Xs{i});
end