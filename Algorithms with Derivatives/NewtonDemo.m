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
for i = 1:3
    xk = points(i,1);
    yk = points(i,2);
    l = eig(h(xk, yk));
    if (double(l) > 0)
        disp('all good')
    else
        fprintf('HESSIAN NO POSITIVE DEFINITE FOR STARTING POINT %f %f.\n',xk,yk)
        disp('EXITING...');
        continue
    end
    
    while 1
        
        if norm(df(xk, yk)) < espilon
            fprintf('Min found at (%f, %f)\n', xk, yk);
            break;
            
        end
        dk = -inv(h(xk, yk))*df(xk, yk);
        
        syms t
        g = vpa(subs(f, [X,Y], [xk-d(1)*t,yk-t*d(2)]),4);
        dg_dt = diff(g,t);
        t = solve(dg_dt, t);
        t = min(double(real(t(imag(t) == 0))));
        xk = xk - t*d(1);
        yk = yk - t*d(1);
    end
end