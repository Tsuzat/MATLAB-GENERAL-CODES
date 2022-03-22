% Solving AX = b using LU Decomposition
clc;
clear;

disp("Solving AX = b using LU Decomposition");
%======================================================================
% Asking for User inputs and defining variables
n = input("Enter the number of Equations : ");
A = input("Enter the matrix A : ");
b = input("Enter the matrix b : ");
L = eye(n);
l = 0;
s = 0;
%======================================================================
%Arranging rows in a way that A(1,i)>= A(1,i+1 to n)
for i = 1:n
    for j = i:n
        if A(1,j)>A(1,i)
            C = A(i,:); 
            D = b(i);
            
            A(i,:) = A(j,:);
            b(i) = b(j);
            
            A(j,:) = C;
             b(j) = D;
        end
    end
end
%======================================================================
%Doing row swapping by checking zeros at main-diagonal mainly 
for i = 1:n-1
    if A(i,i)==0
        j = i;
        for j = i+1:n
            if A(j,i) == 0
                continue
            end
            break
        end
        fprintf("\nDoing Row swaping to get rid of zero at diagonal Position\n");
        fprintf("Row%d is swapped with Row%d in A and b",i,j);
        C = A(i,:); B = b(i);
        A(i,:) = A(j,:); b(i) = b(j);
        A(j,:) = C; b(j) = B;
        fprintf("\nA = \n");disp(A);
        fprintf("\nb = \n");disp(b);
    end
end
D = A; % Storing changed A in D for further references
fprintf("----Initiating A*I = A and Iterating I and right side A----");
%======================================================================
% Doing row operations for upper and lower triangular matrices
for i = 1:n-1
    for j = i+1:n
        l = A(j,i)/A(i,i);
        fprintf("\nR%d -> R%d - (%d)*R%d in A and I\n",j,j,l,i);
        A(j,:) = A(j,:)-l*A(i,:);
        L(j,:) = L(j,:)-l*L(i,:);
    end
    fprintf("\nMatrix A = \n");disp(A);
    fprintf("\nMatrix I = \n");disp(L);
end
%======================================================================
%Doing operations and re-assigning Variables
L = inv(L); % Storing final Lower Triangular Matrix
U = A; % Storing Upper Triangular Matrix 
A = D;
fprintf("Since A*I = A was used and we get A*L = U; So L needs to inverted\n");
disp("========== The Upper Triangular matrix : U ==========");disp(U);
disp("========== The Lower Triangular matrix : L ==========");disp(L);
%======================================================================
%Solving LY = b for Y and storing values of Ys in vector Y
fprintf("\n CALCULATIONS FOR VALUE OF VARIABLES\n");
fprintf("\nSolving for L*Y = b\n"); 
Y(1) = b(1)/L(1,1);
fprintf("\nY1 = %d\n",Y(1));
for i = 2:n
    sum = 0;
    fprintf("(%d)*Y%d",L(i,i),i);
    for j=1:i-1
        sum = sum + L(i,j)*Y(j);
        fprintf(" +(%d)*Y%d ",L(i,j),j);
    end
    fprintf(" = %d ",b(i));
    Y(i) = (b(i)-sum)/L(i,i);
    fprintf(" => Y%d = %d\n",i,Y(i));
end
%======================================================================
%Solving UX = Y for X and storing values of Xs in vector X
fprintf("\n CALCULATIONS FOR VALUE OF VARIABLES\n");
fprintf("\nSolving for U*X = Y\n");
X(n) = Y(n)/U(n,n);
fprintf("X%d = %d\n",n,X(n));
for i = n-1:-1:1
   sum = 0;
   fprintf("(%d)*X%d",U(i,i),i);
   for j = i+1:n
       sum = sum + U(i,j)*X(j);
       fprintf(" +(%d)*X%d ",U(i,j),j);
   end
   fprintf(" = %d ",Y(i));
   X(i) = (1/U(i,i))*(Y(i)-sum);
   fprintf(" => X%d = %d\n",i,X(i));
end
%======================================================================
%Displaying L and U and values of X
disp("========== The solutions of variables: X ==========");disp(X');