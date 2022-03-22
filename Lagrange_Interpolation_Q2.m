% Calculating value of Y for given X using Lagrange Interpolation

clc;
clear all;
%==========================================================================
% Asking for user's input
disp("___Getting value of Y for given X using Lagrange Interpolation___");
Xs = input("Enter values of X (in vactor) : ");
Ys = input("Enter values of Y (in vector) : ");
x = input("Enter the value of X for desired Y : ");

%==========================================================================
% Displaying answer  
str = ['Value of Y at given x = ',num2str(x),' is equal to : ',num2str(Lagrange(x,Xs,Ys))];
fprintf("\n");
disp(str);

%==========================================================================
%Defining function Lagrange 

function Y = Lagrange(X,X_,Y_)
    n = length(X_);
    Y = 0;
    fprintf("\nY = ");
    for i = 1:n
        Multi = 1;
        for j = 1:n
            if i~=j
                Multi = Multi*(X-X_(j)) / (X_(i)-X_(j));
                fprintf("(%d-%d)/(%d-%d)* ",X,X_(j),X_(i),X_(j));
            end
        end
        Multi = Multi* Y_(i);
        fprintf(" %d ",Y_(i));
        Y = Y + Multi;
        fprintf(" + ");
    end
end