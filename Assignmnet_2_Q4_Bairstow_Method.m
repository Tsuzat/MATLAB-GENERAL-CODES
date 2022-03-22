clear all;
clc;
syms x;
P = x^5+2*x^4-8*x^3-14*x^2-41*x+60; % Polynomial expression 
% Taking inputs from user 
s = input("Enter the value of s: "); 
r = input("Enter the value of r: ");
Es = input("Approximate percent relative error for s : ");
Er = input("Approximate percent relative error for r : ");
ai = coeffs(P); % Storing coefficients of P
fprintf("\nCoefficients of polynomial P, ai (from 0 to 5) : ");disp(ai);
bi = []; % To store values of b
ci = []; % To store values of c
S =  x^2-r*x-s; % Defining S

% Calculating values of b
[R1,Q1] = polynomialReduce(P,S);%Dividing P to S  

fprintf("\nCONSIDERING,P(x) = (x^2-%d*x-%d)*Q(x)+ R1\nSo;",r,s);
fprintf("\nQ(x) = ");disp(Q1);
fprintf("\nR1 = ");disp(R1);

Coe = fliplr(coeffs(R1));%Storing coefficient of R1 in reverse order
bi(1) = Coe(2)+r*Coe(1);% b(n)is actually bi(n+1) and so on
bi(2) = Coe(1);

fprintf("OR R1 = (%d)*(X - %d) + (%d)",bi(2),r,bi(1))

fprintf("\nSo; b0 = %d and b1 = %d\n",bi(1),bi(2));
fprintf("\nAgain; Considering Q(x) = (x^2-r*x-s)*F(x) + R2 \n");

% Calculating values of c
[R2,Q2] = polynomialReduce(Q1,S);% Dividing Q1 to S
fprintf("\nF(x) = ");disp(Q2);
fprintf("\nR2 = ");disp(R2);
Coe = fliplr(coeffs(R2));
ci(4) = Coe(1); % c(n)is actually ci(n+1) and so on
ci(3) = Coe(2)+r*Coe(1);
ci(2) = bi(2)+r*ci(3)+s*ci(4);
fprintf("OR R2 = (%d)*(X - %d) + (%d)",ci(4),r,ci(3));
fprintf("\nSo; c3 = %d ; c2 = %d",ci(4),ci(3));
fprintf("\nc1 = b1+r*c2+s*c3 = %d",ci(2));

n = 1; %no of iterations

while(true) % Initiating while
    fprintf("\n\n-------------------------------- ITERATION : %d --------------------------------\n",n);
    fprintf("\nr = %d ; s = %d\n",r,s);
    A = [ci(2) ci(3); ci(3) ci(4)]; % A is actually [c1 c2; c2 c3]
    B = [bi(1); bi(2)]; % B is actually [b0; b1]
    X =  A\B; % Calculating X which is [Δr; Δs]
    fprintf("\nSOLVING [c1 c2; c2 c3]*[Δr; Δs] = [b0; b1]");
    fprintf("\nΔr = %d ; Δs = %d\n",X(1),X(2));
    r = r - X(1); % Updating the values
    s = s - X(2);
    
    r = round(r,4);
    s = round(s,4);
    
    fprintf("\nUPDATING THE VALUES OF r (r-Δr) AND s (s-Δs)\nr = %d ; s = %d\n",r,s);
    fprintf("\nApproximate percent relative error for r : %d",abs(X(1)/r));
    fprintf("\nApproximate percent relative error for s : %d",abs(X(2)/s));
    if (abs(X(1)/r)<Er && abs(X(2)/s)<Es) % Checking for percent relative error
        break
    end
    fprintf("\nCALCULATING bi and ci:\n");
    fprintf("\nbn = an\nb(n-1) = a(n-1) + r*bn\nbi = ai + r*b(i+1)+ s*b(i+2)\n");
    fprintf("\ncn = bn\nc(n-1) = b(n-1) + r*cn\nci = bi + r*c(i+1)+ s*c(i+2)\n");
    bi(6) = ai(6); % calculating b5 is bi(6)
    ci(6) = bi(6);
    bi(5) = ai(5)+r*bi(6);
    ci(5) = bi(5)+r*bi(6);
    for k = fliplr(1:4)
        bi(k) = ai(k)+r*bi(k+1)+s*bi(k+2);
        ci(k) = bi(k)+r*ci(k+1)+s*ci(k+2);
    end
    fprintf("\nbi (from b0 to b5) : ");disp(bi);
    fprintf("\nci (from c0 to c5) : ");disp(ci);
    n = n + 1;
end
fprintf("\n\nSolving x^2-r*x-s for r = %d and s = %d USING SHRI DHARA CHARYA FORMULA\n",r,s);
fprintf("Roots are : \n");disp(roots([1,-r,-s]));

%Solving for cubic polynomial
fprintf("\n__________________________________________________________________________________\n");
fprintf("\n\nNOW SOLVING FOR CUBIC POLYNOMIAL Q(x) => P(x) = (x^2-(%d)*x-(%d))*Q(x)\n",r,s);
S =  x^2-r*x-s;
[R1,Q1] = polynomialReduce(P,S); % Q1 is quotient of P/S
fprintf("\n Q(x) = ");disp(Q1);
r = 1; % Initial guess
s = 1;
fprintf("Taking Initial Guess as r = %d and s = %d\n",r,s);
ai = coeffs(Q1); % storing coefficients of Q1

n = 1; %no of Iterations

while(true) % Initiating while loop
    fprintf("\n\n-------------------------------- ITERATION : %d --------------------------------\n",n);
    fprintf("\nCALCULATING bi and ci:\n");
    fprintf("\nbn = an\nb(n-1) = a(n-1) + r*bn\nbi = ai + r*b(i+1)+ s*b(i+2)\n");
    fprintf("\ncn = bn\nc(n-1) = b(n-1) + r*cn\nci = bi + r*c(i+1)+ s*c(i+2)\n");
    % calculating values of b and c and storing in bi and ci
    bi(4) = ai(4);
    ci(4) = bi(4);
    bi(3) = ai(3)+r*bi(4);
    ci(3) = bi(3)+r*ci(4);
    for k = fliplr(1:2)
        bi(k) = ai(k)+r*bi(k+1)+s*bi(k+2);
        ci(k) = bi(k)+r*ci(k+1)+s*ci(k+2);
    end
    fprintf("\nbi (from b0 to b5) : ");disp(bi);
    fprintf("\nci (from c0 to c5) : ");disp(ci);
    A = [ci(2) ci(3); ci(3) ci(4)]; % A is actually [c1 c2; c2 c3]
    B = [bi(1); bi(2)]; % B is actually [b0; b1]
    X =  A\B; % Calculating X which is [Δr; Δs]
    fprintf("\nSOLVING [c1 c2; c2 c3]*[Δr; Δs] = [b0; b1]");
    fprintf("\nΔr = %d ; Δs = %d\n",X(1),X(2));
    r = r - X(1); % Updating r and s
    s = s - X(2);
    
    r = round(r,4);
    s = round(s,4);
    
    fprintf("\nUPDATING THE VALUES OF r AND s\nr = %d ; s = %d\n",r,s);
    fprintf("\nApproximate percent relative error for r : %d",abs(X(1)/r));
    fprintf("\nApproximate percent relative error for s : %d",abs(X(2)/s));
    if (abs(X(1)/r)<Er && abs(X(2)/r)<Es)
        break
    end
    n = n + 1;
end
fprintf("\n\nSolving x^2-r*x-s for r = %d and s = %d USING SHRI DHARA CHARYA FORMULA\n",r,s);
fprintf("\nRoots are : \n");disp(roots([1,-r,-s]));
S =  x^2-r*x-s; 
[R2,Q2] = polynomialReduce(Q1,S); % calculating last factor/Quotient
fprintf("\n\nAT FINAL WE HAVE : \n");disp(Q2);fprintf(" = 0\n")
fprintf("\nSo, Last root would be : ");
disp(double(solve(Q2,x))); % Displaying last root