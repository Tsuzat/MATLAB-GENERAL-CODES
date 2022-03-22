% THIS IS A CODE TO CALCULATE 'X' IN AX = b USING GAUSS ELIMINATION 
clc;
clear;
disp("Calculation of AX = b using Gauss Elimination");
%======================================================================
% Asking for User inputs and defining variables
n = input("Enter the number of Equations : ");
A = input("Enter the matrix A : ");
b = input("Enter the matrix b : ");
G = [A,b]; % Fusing 'A' and 'b' for further operations
l = 0;
s = 0;
%======================================================================
% Doing forward iterations ( Upper Triangular matrix )
for i = 1:n-1
%     fprintf("\n----------------------------------------------------------------------\n");
    if (G(i,i) == 0)
%         fprintf("\nDoing Row swaping to get rid of zero at diagonal Position\n");
        j = i;
        for j = j+1:n
            if G(j,i) == 0
                continue
            end
            break
        end
        % Doing Row swapping
%         fprintf("\nSwaping row %d with row %d\n",i,j);
        C = G(i,:);
        G(i,:) = G(j,:);
        G(j,:) = C;
        disp(G);
    end
    for k = 1+s:n-1
        l = G(k+1,i)/G(i,i);
        G(k+1,:) = G(k+1,:)-l*G(i,:); %Row operation
%         fprintf("\n_______OPERATION : R%d -> R%d - (%d)*(R%d)_______",k+1,k+1,l,i);
    end
    fprintf("\n");
    disp(G);
    s = s+1;
end
% Redistribution of A and b from fused matrix G
A = G(1:n,1:n);
b = G(1:n,n+1);
%======================================================================
% Calculating X without using MATLAB functions (Backward Iteration)

% fprintf("\n");
% disp("======= Upper triangular matrix (Solved A)========= ");disp(A);
% disp("========== Right Hand matrix (Solved b)============ ");disp(b);

X(n) = b(n)/A(n,n);
% fprintf("\n CALCULATIONS FOR VALUE OF VARIABLES\n");
% fprintf("X%d = %d\n",n,X(n));
for i = n-1:-1:1
   sum = 0;
%    fprintf("(%d)*X%d",A(i,i),i);
   for j = i+1:n
       sum = sum + A(i,j)*X(j);
%        fprintf(" +(%d)*X%d ",A(i,j),j);
   end
%    fprintf(" = %d",b(i));
   X(i) = (1/A(i,i))*(b(i)-sum);
%    fprintf(" => X%d = %d\n",i,X(i));
end
%======================================================================
% Displaying the final answers
disp("=======Values of variables(Value of X)=========");disp(X');