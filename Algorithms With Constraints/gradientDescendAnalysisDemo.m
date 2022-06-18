
clc
clear
clf
close all
syms x1 x2 func(x1,x2)
func(x1,x2) = 0.5*x1^2 + 2*x2^2;
%We use the gradient decent method to minimize our functions.
epsilon = 0.01;
point = [-7 5];
gamma_k = [0.05 0.5 2 10];
gradF = gradient(func, [x1 x2]);
gv = gradF(point(1), point(2)); %gradient vector


for i = 1:length(gamma_k)
    
    gv = gradF(point(1), point(2));
    xk = zeros(1, 2);   
    xk(1,1) = point(1);
    xk(1,2) = point(2);
    k = 1;
    found = 1;
    while norm(gv) > epsilon
        gv = gradF(xk(k,1), xk(k,2)); %gradient vector
        xk(k+1,1) = xk(k,1) - gamma_k(i)*gv(1);
        xk(k+1,2) = xk(k,2) - gamma_k(i)*gv(2);
        k = k + 1;
        %ESCAPE
        if k > 1000
            fprintf("INFINITE LOOP\n");
            
            found = 2;
            break;
        elseif norm(gv) > 1e6
            fprintf("SEARCH DIVERGES\n");
            found = 3;
            break;
        end
    end
    
    h1 = figure();
    
    set(h1, 'Visible', 'off');
    fcontour(func, 'Fill', 'On');
    xlim([-abs(point(1))-2 abs(point(1))+2])
    ylim([-abs(point(2))-2 abs(point(2))+2])
    hold on;
    plot(xk(:,1),xk(:,2),'*-r');
    title({'Contour of f(x_{1}, x_{2})','Min search convergence for {\gamma}_{\kappa} = ' + string(gamma_k(i))});
    xlabel('x_{1}')
    ylabel('x_{2}')
    
    saveas(h1, 'TASK1_PLOT_' + string(i)+'.png');
    switch found
        case 1
            fprintf("Min is found at ,with gamma_k = %f,(%f, %f) point\n",gamma_k(i), xk(k,:))
            fprintf('found min at (%f, %f) and it is %f\n', xk(k,1), xk(k,2), func(xk(k,1),xk(k,2)))
        case 2
            fprintf('Entered infinite loop, search was canceled\n')
        case 3
            fprintf('Search diverges, search was canceled\n')
    end
    fprintf('\n\n\n')
    length(xk(:,1))
end

