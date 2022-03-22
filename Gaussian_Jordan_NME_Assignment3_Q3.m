% Solving for matrix inverse using Gauss Jordan
clc;
clear;
%====================================================================
% taking user's input and defining variables
disp("Solving Matrix inverse using Gauss Jordan Method");
n = input("Enter order of the square matrix: ");
A = input("Enter the square Matrix: ");
B = eye(n); % Reference Unit matrix
Z = A; % Replicating A into Z
G = [A,B]; % Fusing A and B for further operations
fprintf("\n----------------------------------------------------------------------\n");
fprintf("\n FUSING A and I FOR FURTHER CALCULATIONS\n");disp(G);
%====================================================================
%Doing row swapping by checking zeros at main-diagonal mainly in A
for i = 1:n-1
    if G(i,i)==0
        j = i;
        for j = i+1:n
            if G(j,i) == 0
                continue
            end
            break
        end
        fprintf("\n---Doing Row swaping to get rid of zero at diagonal Position---\n");
        fprintf("\n____Swaping row %d with row %d____\n",i,j);
        C = G(i,:); 
        G(i,:) = G(j,:); 
        G(j,:) = C; 
        disp(G);
    end
end
%====================================================================
% Doing operations for get inverse (Mainly converting original A into I)
for i = 1:n
    l = G(i,i);
    G(i,:) = l\G(i,:);
    fprintf("\nR%d -> R%d/%d\n",i,i,l);
    disp(G);
    for j = 1:n
        if ( i == j)
            continue
        end
        fprintf("\n_______OPERATION : R%d -> R%d - (%d)*R%d_______",j,j,G(j,i),i);
        G(j,:) = G(j,:)-G(j,i)*G(i,:);
    end
    fprintf("\n");
    disp(G);
end
%====================================================================
inv_A = G(1:n,n+1:2*n);
disp("============The inverse of matrix A ( = inv_A)============");
disp(inv_A);