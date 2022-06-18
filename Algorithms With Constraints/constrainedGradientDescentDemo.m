tic
clear
clf
close all
syms x1 x2 func(x1,x2)
func(x1,x2) = 0.5*x1^2 + 2*x2^2;
%We use the gradient decent method to minimize our functions.
epsilon = [0.01 0.02 0.01];
point = [-10 5;-7 5; 17 -5];
constrains = [-15 15;-20 12];
gamma_k = [0.05, 0.3, 0.1];
sk = [8 10 0.5];
task = 4;
gradF = gradient(func, [x1 x2]);
gv = gradF(point(task-1,1), point(task-1,2)); %gradient vector


xk = zeros(1, 2);   
xk(1,:) = pointProjection(point(task-1,:), constrains);
xk(1,:) = point(task-1,:);

k = 1;
while norm(gv) > epsilon(task-1)
    gv = gradF(xk(k,1), xk(k,2)); %gradient vector
    
    x_senior = xk(k,:) - sk(task-1)*transpose(gv);
    x_senior = pointProjection(x_senior, constrains);
    
    xk(k+1,:) = xk(k,:) + gamma_k(task-1)*(x_senior-xk(k,:));
    k = k + 1;
    %ESCAPE
    if k > 1000
        fprintf("INFINITE LOOP\n");
        toc
        break;
    end
end
h1 = figure();    
set(h1, 'Visible', 'off');
fcontour(func, 'Fill', 'On');
xlim([-abs(point(task-1,1))-2 abs(point(task-1,1))+2])
ylim([-abs(point(task-1,2))-2 abs(point(task-1,2))+2])
hold on;
plot(xk(:,1),xk(:,2),'*-r');
title({'Contour of f(x_{1}, x_{2})','Min search convergence for {\gamma}_{\kappa} = ' + string(gamma_k(task-1)) + ' and s_{\kappa} = ' + string(sk(task-1))});
xlabel('x_{1}')
ylabel('x_{2}')
saveas(h1, 'TASK'+ string(task) +'_PLOT_' +string(task) + '.png');
toc
fprintf("Min is found at ,(%f, %f) point, with gamma_k = %f,\n",gamma_k, xk(k,:))
fprintf('min is %f\n', func(xk(k,1),xk(k,2)))
fprintf('Number of steps is %d\n', k);