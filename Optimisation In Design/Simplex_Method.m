clc;
clear;

N = input("Enter the number of variables : "); %Inputting no. of variables
Xns = strjoin(compose('x%d', 1:N), ',');%composing a string containing variables
func_str = input("Write function f(x1,x2,...xn): ",'s');
f = str2func(sprintf('@(%s) %s', Xns, func_str));

X1 = input("Enter X1 (as cell): ");
X2 = input("Enter X2 (as cell): ");
X3 = input("Enter X3 (as cell): ");
X_temp = [X1{:},X2{:},X3{:}];
xc = cell(1,N);
xr = cell(1,N);
x_new = cell(1,N);
accuracy = input("Enter accuracy: ");
gamma = 1.5;
beta = 0.5;
er = 1e7;
itr = 1;

while er>accuracy
    %fprintf("Iteration: %d and error: %d \n",itr,er);
    % finding best, worst and next worst point
    temp = [f(X1{:}), f(X2{:}), f(X3{:})];
    t_max = max(temp);
    t_min = min(temp);
    for i = 1:3
        if temp(i) == t_max
            xh = {X_temp(2*i), X_temp(2*i-1)};
        elseif temp(i) == t_min
            xl = {X_temp(2*i), X_temp(2*i-1)};
        else
            xg = {X_temp(2*i), X_temp(2*i-1)};
        end
    end
    for i = 1:N
        xc{1,i} = (xl{i}+xg{i})/2;
        xr{1,i} = 2*xc{i} - xh{i};
    end
    if f(xr{:})<f(xl{:})
        for i = 1:N
            x_new{1,i} = (1+gamma)*xc{i} - gamma*xh{i};
        end
    elseif f(xr{:}) >= f(xh{:})
        for i = 1:N
            x_new{1,i} = (1-beta)*xc{i} + beta*xh{i};
        end
    elseif f(xg{:}) < f(xr{:}) && f(xr{:}) < f{xn{:}}
        for i = 1:N
            x_new{1,i} = (1+beta)*xc{i} - beta*xh{i};
        end
    end
    xh = x_new;
    er =  sqrt( sqr(f(xh{:}) - f(xc{:})) + sqr(f(xg{:}) - f(xc{:})) + sqr(f(xl{:}) - f(xc{:}) )/ (N+1) );
    itr = itr+1;
    X1 = xh;
    X2 = xg;
    X3 = xl;
    X_temp = [X1{:},X2{:},X3{:}];
    fprintf("\nXg: (%d, %d)",xg{1},xg{2});
    fprintf("\nXh: (%d, %d)",xh{1},xh{2});
    fprintf("\nXl: (%d, %d)",xl{1},xl{2});

end

min_f = min([f(xg{:}),f(xh{:}),f(xl{:})]);
disp(num2str(min_f));