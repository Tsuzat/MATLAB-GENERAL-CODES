% SimpSon's 1/3 Rule to Solve integration
clc;
clear all;
%==========================================================================
%Taking User's input
disp("______ USING SimpSon's 1/3 Rule to Solve integration ______");
f = eval(['@(x)',input('Enter the function f(x) = ','s')]);
a = input("Enter the lower limit of integral: ");
b = input("Enter the upper limit of integral: ");

while(true) % asking for value of 'n' if it's not even 
    n = input("Enter the number of intervals: ");
    if mod(n,2) == 0
        break
    else
        fprintf("Please Enter 'EVEN' numbers of intervals.\n");
    end
end

h = (b-a)/n; % Initialising h
sum = 0;
%==========================================================================
%Calculating the value of integral
for i = 0:n 
    if i == 0 || i == n
        sum = sum + f(a+i*h);
    elseif mod(i,2) == 0
        sum = sum + 2*f(a+i*h);
    else
        sum = sum + 4*f(a+i*h);
    end
end
%==========================================================================
%Displaying the final answers
str = ['Value of integral is : ',num2str((h/3)*sum)];
disp(str); %Displaying the value calculated using simpson's 1/3  Rule