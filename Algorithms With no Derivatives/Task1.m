% Define the range and the function that are to be minimized
clear
clc
addpath('src');
f1 = @(x) (x-3)^2 + sin(x+3)^2;
f2 = @(x) (x+1)*cos(0.5*x) + x^2;
f3 = @(x) (x+2)^2 + exp(x-2)*sin(x-3);
% x = -4:0.001:4;
% y = (x+2).^2 + exp(x-2).*sin(x-3);
% Bisectrix search algorithm for functions fi, i = {1 ,2, 3} is found in src file bisetrix.m
%% Find minimums for f1 f2 f3 considering a variety of epsilons
epsilons = [1e-1 1e-2 1e-3 1e-4 1e-5 1e-6]; %1en = 1*10^n
einv = [1e1 1e2 1e3 1e4 1e5 1e6];
L = 1e-2;
a = -4;
b = 4;

for i = 1:length(epsilons)
    tic
    [msg, alphas, betas, y1, y2, x1, x2] = bisetrix(f1 , a, b, epsilons(i), L, einv(i));
    fprintf("Epsilon is %.6f\n", epsilons(i))
    fprintf("For f1(x) " + msg)
    fprintf("This took " + toc + " seconds\n")
end
fprintf("\n\n\n\n\n")
for i = 1:length(epsilons)
    tic
    [msg, alphas, betas, y1, y2, x1, x2] = bisetrix(f2 , a, b, epsilons(i), L, einv(i));
    fprintf("Epsilon is %.6f\n", epsilons(i))
    fprintf("For f2(x) " + msg)
    fprintf("This took " + toc + " seconds\n")
end
fprintf("\n\n\n\n\n")
for i = 1:length(epsilons)
    tic
    [msg, alphas, betas, y1, y2, x1, x2] = bisetrix(f3 , a, b, epsilons(i), L, einv(i));
    fprintf("Epsilon is %.6f\n", epsilons(i))
    fprintf("For f3(x) " + msg)
    fprintf("This took " + toc + " seconds\n")
end


%% Implementing the 2nd part of Task 1
%In part 2 of task 1 epsilon = 0.001. We are asked to study the change of
%f1 f2 f3 for various l values. We need to add the change of a and b with
%a,b being the limits of our study interval [a, b]. bisetrix function will
%return all the alphas and betas that were used during the search. We have
%created a 2nd function to plot and save everything as png to use for our
%report
warning off
epsilon = 0.001;
l = [0.1 0.01 0.005 0.0025];
mkdir('task1');
cd('task1');
which bisetrix;
for i= 1:length(l)
    h1 = figure();set(gcf,'Visible', 'off');
    [~, alphas, betas, y1, y2,x1, x2] = bisetrix(f1 , a, b, epsilon, l(i), 10000);
    
    subplot(1, 2, 1);
    plot(alphas, '.-');
    xlabel('k');
    ylabel("{\alpha}")
    title('Subplot 1: {\alpha}');
    
    hold on;
    
    subplot(1,2,2);
    plot(betas, '.-');
    xlabel('k');
    ylabel("{\beta}")
    title('Subplot 2: {\beta}');
   
    saveas(gcf, "f1_ab_"+string(i)+".png");
    h1 = figure();set(gcf,'Visible', 'off');
    
    xlim([-2.5 0.5]);
    
    subplot(1, 2, 1);
    hold on;
    scatter(x1, y1, '.r');
    fplot(f1);
    title("f(x) = (x-3)^{2} + sin(x+3)^{2}");
    hold off;
    subplot(1,2,2);
    hold on;
    scatter(x2, y2, '.g');
    fplot(f1);
    saveas(gcf, "f1_x1x2_"+string(i)+".png");
end

for i= 1:length(l)
    h1 = figure();set(gcf,'Visible', 'off');
    [~, alphas, betas, y1, y2,x1, x2] = bisetrix(f2 , a, b, epsilon, l(i), 1000);
    subplot(1, 2, 1);
    plot(alphas, '.-');
    xlabel('k');
    ylabel("{\alpha}")
    title('Subplot 1: {\alpha}');
    
    hold on;
    
    subplot(1,2,2);
    plot(betas, '.-');
    xlabel('k');
    ylabel("{\beta}")
    title("Subplot 2: {\beta}");
    saveas(gcf, "f2_ab_"+string(i)+".png");
    h1 = figure();set(gcf,'Visible', 'off');
    
    xlim([-2.5 0.5]);
    
    subplot(1, 2, 1);
    hold on;
    scatter(x1, y1, '.r');
    fplot(f2);
    title("f(x) = (x+1)cos(0.5*x) + x^{2};");
    hold off;
    subplot(1,2,2);
    hold on;
    scatter(x2, y2, '.g');
    fplot(f2)
    saveas(gcf, "f2_x1x2_"+string(i)+".png");
end

for i= 1:length(l)
    h1 = figure();set(gcf,'Visible', 'off');
    [~, alphas, betas, y1, y2,x1, x2] = bisetrix(f3 , a, b, epsilon, l(i), 1000);
    subplot(1, 2, 1);
    plot(alphas, '.-');
    xlabel('k');
    ylabel("{\alpha}")
    title('Subplot 1: {\alpha}');
    
    hold on
    
    subplot(1,2,2);
    plot(betas, '.-');
    xlabel('k');
    ylabel("{\beta}")
    title('Subplot 2: {\beta}');
    saveas(gcf, "f3_ab_"+string(i)+".png");
    h1 = figure();set(gcf,'Visible', 'off');
    
    xlim([-2.5 0.5]);
    
    subplot(1, 2, 1);
    hold on;
    scatter(x1, y1, '.r');
    fplot(f3);
    title("f(x) = (x+2)^{2} + e^{x-2}sin(x-3)");
    hold off;
    subplot(1,2,2);
    hold on;
    scatter(x2, y2, '.g');
    fplot(f3);
    saveas(gcf, "f3_x1x2_"+string(i)+".png");
end
pause(1)
cd ..


