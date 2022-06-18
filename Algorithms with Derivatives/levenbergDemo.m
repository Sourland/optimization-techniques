clear
clc
clf
close all

syms X Y f(X,Y)
f(X,Y) = X^3 * exp(-X^2 -Y^4);
df(X,Y) = gradient(f);
h(X,Y) = hessian(f);
epsilon = 0.001;
points = [0 0;1 1;-1 -1];
data = zeros(10,2);
xk = 1;
yk = 1;
k = 1;
data(1,:) = [xk yk];
while norm(df(xk, yk)) > epsilon
    k = k + 1;
    mk = 0;
    ARRAY = h(xk, yk) + mk*eye(2);
    [~,p] = chol(ARRAY);   
    while (p > 0)
        mk = mk + 1.1;
        ARRAY = h(xk, yk) + mk*eye(2);
        [~,p] = chol(ARRAY);
    end
    d = linsolve(ARRAY, -df(xk, yk));
    syms t
    value = f(xk + t*d(1), yk + t*d(2));
    valueF = inline(value);
    step = fminsearchbnd(valueF, 0, 0);
    %NEW XK YK
    xk = xk+step*d(1); % New x value
    yk = yk+step*d(2); % New y value
    data(k,:) = [xk yk];
    break;
end
fprintf('found min at (%f, %f) and it is %f\n', xk, yk, f(xk,yk))
figure()
fcontour(f, 'Fill', 'On');
hold on;
plot(nonzeros(data(:,1)),nonzeros(data(:,2)),'*-r');
%plot(0,0,'*-r');
