
clear
clc

addpath('src');
syms f1(x) f2(x) f3(x)
f1(x) = (x-3)^2 + sin(x+3)^2;
f2(x) = (x+1)*cos(0.5*x) + x^2;
f3(x) = (x+2)^2 + exp(x-2)*sin(x-3);

a = -4;
b = 4;
l = [1e-2 1e-3 1e-4 1e-5 1e-6];

for i = 1:length(l)
    tic
    [msg, alphas, betas, x] = bisetrix_der(f1 , a, b, l(i));
    fprintf("L is %.6f\n", l(i))
    fprintf("For f1(x) " + msg)
    fprintf("This took " + toc + " seconds\n")
end
fprintf("\n\n\n\n\n")
for i = 1:length(l)
    tic
    [msg, alphas, betas, x] = bisetrix_der(f2 , a, b, l(i));
    fprintf("L is %.6f\n", l(i))
    fprintf("For f2(x) " + msg)
    fprintf("This took " + toc + " seconds\n")
end
fprintf("\n\n\n\n\n")
for i = 1:length(l)
    tic
    [msg, alphas, betas, x] = bisetrix_der(f3 , a, b, l(i));
    fprintf("L is %.6f\n", l(i))
    fprintf("For f3(x) " + msg)
    fprintf("This took " + toc + " seconds\n")
end

warning off
mkdir('task4');
cd('task4');
which bisetrix_der;
for i= 1:length(l)
    h1 = figure();set(gcf,'Visible', 'off');
    [~, alphas, betas, xi] = bisetrix_der(f1 , a, b, l(i));
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
    
    
    
    hold on;
    fplot(f1);
    scatter(xi, f1(xi), '.r');
    
    title("f(x) = (x-3)^{2} + sin(x+3)^{2}");
    saveas(gcf, "f1_x1x2_"+string(i)+".png");
end

for i= 1:length(l)
    h1 = figure();set(gcf,'Visible', 'off');
    [~, alphas, betas, xi] = bisetrix_der(f2 , a, b, l(i));
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
   
    hold on;
    fplot(f2);
    scatter(xi, f2(xi), '.r');
    
    title("f(x) = (x+1)cos(0.5x) + x^{2}");
    saveas(gcf, "f2_x1x2_"+string(i)+".png");
end

for i= 1:length(l)
    h1 = figure();set(gcf,'Visible', 'off');
    [~, alphas, betas, xi] = bisetrix_der(f3 , a, b, l(i));
    subplot(1, 2, 1);
    plot(alphas, '.-');;
    xlabel('k');
    ylabel("{\alpha}")
    title('Subplot 1: {\alpha}');
    
    hold on
    
    subplot(1,2,2);
    plot(betas, '.-');;
    xlabel('k');
    ylabel("{\beta}")
    title('Subplot 2: {\beta}');
    saveas(gcf, "f3_ab_"+string(i)+".png");
    
    h1 = figure();set(gcf,'Visible', 'off');
    hold on;
    fplot(f3);
    scatter(xi, f3(xi), '.r');
    
    title("f(x) = (x+2)^{2} + e^{x-2}sin(x-3)");
    saveas(gcf, "f3_x1x2_"+string(i)+".png");
end
pause(1)
cd ..
