% Define the range and the function that are to be minimized
clear
clc
f1 = @(x) (x-3)^2 + sin(x+3)^2;
f2 = @(x) (x+1)*cos(0.5*x) + x^2;
f3 = @(x) (x+2)^2 + exp(x-2)*sin(x-3);

addpath('src');
% We will implement the golden_section search algorithm for functions fi, i = {1 ,2, 3}
%% Find minimums for f1 f2 f3 considering a variety of Ls

l = [1e-2 1e-3 1e-4 1e-5 1e-6];
a = -4;
b = 4;

for i = 1:length(l)
    tic
    [msg, alphas, betas, y1, y2, x1, x2] = GoldenSection(f1 , a, b, l(i));
    fprintf("L is %.6f\n", l(i))
    fprintf("For f1(x) " + msg)
    fprintf("This took " + toc + " seconds\n")
end
fprintf("\n\n\n\n\n")
for i = 1:length(l)
    tic
    [msg, alphas, betas, y1, y2, x1, x2] = GoldenSection(f2 , a, b, l(i));
    fprintf("L is %.6f\n", l(i))
    fprintf("For f2(x) " + msg)
    fprintf("This took " + toc + " seconds\n")
end
fprintf("\n\n\n\n\n")
for i = 1:length(l)
    tic
    [msg, alphas, betas, y1, y2, x1, x2] = GoldenSection(f3 , a, b, l(i));
    fprintf("L is %.6f\n", l(i))
    fprintf("For f3(x) " + msg)
    fprintf("This took " + toc + " seconds\n")
end



warning off
mkdir('task2');
cd('task2');
which GoldenSection
for i= 1:length(l)
    h1 = figure();set(gcf,'Visible', 'off');
    [~, alphas, betas, y1, y2,x1, x2] = GoldenSection(f1 , a, b, l(i));
    subplot(1, 2, 1);
    plot(alphas);
    xlabel('k');
    ylabel("{\alpha}")
    title('Subplot 1: {\alpha}');
    
    hold on;
    
    subplot(1,2,2);
    plot(betas);
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
    [~, alphas, betas, y1, y2,x1, x2] = GoldenSection(f2 , a, b, l(i));
    subplot(1, 2, 1);
    plot(alphas);
    xlabel('k');
    ylabel("{\alpha}")
    title('Subplot 1: {\alpha}');
    
    hold on;
    
    subplot(1,2,2);
    plot(betas);
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
    title("f(x) = (x+1)cos(0.5x) + x^{2}");
    hold off;
    subplot(1,2,2);
    hold on;
    scatter(x2, y2, '.g');
    fplot(f2)
    saveas(gcf, "f2_x1x2_"+string(i)+".png");
end

for i= 1:length(l)
    h1 = figure();set(gcf,'Visible', 'off');
    [~, alphas, betas, y1, y2,x1, x2] = GoldenSection(f3 , a, b, l(i));
    subplot(1, 2, 1);
    plot(alphas);
    xlabel('k');
    ylabel("{\alpha}")
    title('Subplot 1: {\alpha}');
    
    hold on
    
    subplot(1,2,2);
    plot(betas);
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



