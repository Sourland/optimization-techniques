tic
clc
clear
clf
close all
syms x y func(x,y)
func(x,y) = 0.5*x^2 + 2*y^2;
%We use the max decent method to minimize our functions.
points = [[0 0];[1 1];[-1 -1]];
epsilon = 0.01;

%A - Using a constant gamma_k
gamma_k = 1;
gradF = gradient(func, [x y]);
xk = zeros(1, 1);   
xk(1,1) = points(3,1);
xk(1,2) = points(3,2);
k = 1;

gv = gradF(xk(1,1), xk(1,2)); %gradient vector

while norm(gv) > epsilon


    gv = gradF(xk(k,1), xk(k,2)); %gradient vector
    xk(k+1,1) = xk(k,1) - gamma_k*gv(1);
    xk(k+1,2) = xk(k,2) - gamma_k*gv(2);
    k = k + 1;
    %ESCAPE
    if k > 10000
        fprintf("INFINITE LOOP\n");
        toc
        return
    end
end
fprintf('found min at (%f, %f) and it is %f\n', xk(k,1), xk(k,2), func(xk(k,1),xk(k,2)))
figure()
fcontour(func, 'Fill', 'On');
hold on;
plot(xk(:,1),xk(:,2),'*-r');
toc
fprintf("Min is found at ,with gamma_k constant,(%f, %f) point\n", xk(k,:));

%B Using the min rule for gamma_k

clear
points = [[0 0];[-1 -1];[1 1]];
epsilon = 0.001;
format long
syms X Y;
f = X^3 * exp(-X^2 -Y^4);
func(X,Y) = f;
% Initial Guess:
x = zeros(1e3,1);
y = zeros(1e3,1);
x(1) = -1;
y(1) = -1;
% Gradient Computation:
df_dx = diff(f, X);
df_dy = diff(f, Y);
g0 = [subs(df_dx,[X,Y], [x(1),y(1)]) subs(df_dy, [X,Y], [x(1),y(1)])];
d = -(g0); % Search Direction
i = 1;
while 1

    if i > 1e3
        fprintf("OSCILLATION\n");
    break;
    end
    i = i + 1;
    I = [x(i),y(i)];
    syms t
    z=I-(t*g0);%search direction
    g = vpa(subs(f, [X,Y], [x(i)-d(1)*t,y(i)-t*d(2)]),4);
    dg_dt = diff(g,t);
    t = solve(dg_dt, t);
    t = min(double(real(t(imag(t) == 0))));
    x(i+1) = I(1)-t*d(1); % New x value
    y(i+1) = I(2)-t*d(2); % New y value
    g_o = [subs(df_dx,[X,Y], [x(i),y(i)]) subs(df_dy, [X,Y], [x(i),y(i)])];
    i = i+1;
    g_1 = [subs(df_dx,[X,Y], [x(i),y(i)]) subs(df_dy, [X,Y], [x(i),y(i)])]; % Updated Gradient
    if norm(g_o) < epsilon
        break
    end
    d=-(g_1);
end

X_coordinate = x';
Y_coordinate = y';

% Plots:
figure()
fcontour(f, 'Fill', 'On');
hold on;
plot(x,y,'*-r');
% Output:
fprintf('Initial Objective Function Value: %d\n\n',subs(f,[X,Y], [x(1),y(1)]));
fprintf('Number of Iterations for Convergence: %d\n\n', i);
fprintf('Point of Minima: [%d,%d]\n\n', x(i), y(i));
fprintf('Objective Function Minimum Value after Optimization: %d\n\n', subs(f,[X,Y], [x(i),y(i)]));
fprintf('Number of calls = %f\n', round(i, 1));
%%
%USING THE ARMIJO RULE 
clearvars -except func gv 

a = 1e-1;
b = 1/2;
s = 3.36    ;
epsilon = 0.001;
syms x y f(x,y)
f(x,y) = x^3 * exp(-x^2 -y^4);
df(x,y) = gradient(f);
xk = -1;
yk = -1;
dk = -df(xk, yk);
data = zeros(3, 4);
k = 1;
data(k,:) = [xk yk dk(1) dk(2)];
while norm(dk) > epsilon

    mk = 0;

    while 1
        if (double(f(xk, yk)) > double(f(xk + dk(1)*s*b^mk,yk + dk(2)*s*b^mk)) - a*s*b^mk *double(df(xk, yk)* transpose(dk)))     
            break
        else
            mk = mk + 1;
        end
    end
    xk = double(xk + s*b^mk * dk(1));
    yk = double(yk + s*b^mk * dk(2));
    dk = -df(xk, yk);  
    k = k + 1;
    data(k,:) = [xk yk dk(1) dk(2)];
end
figure()
fcontour(f, 'Fill', 'On');
hold on;
plot(data(:,1),data(:,2),'*-r');




