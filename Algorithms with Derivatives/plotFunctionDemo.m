%TASK 1
% Plot the function f = x^3 * exp(-x^2 - y^4)
clear
clc
clf
close all
%3D Plot of f
x = linspace(-1, 2, 75);
y = linspace(-2, 1, 75);
[x, y] = meshgrid(x, y);
z = sin(x+y)*sin(x.^2);
surf(x,y,z)
%view([15 15])
title('Plot of f(x_{1}, x_{2}) = 0.5x_{1}^{2} + 2x_{2}^{2}')
xlabel('x_{1}')
ylabel('x_{2}')
zlabel('f(x_{1}, x_{2})')
colormap cool
colorbar
%Contour and quiver of f
figure()
x = linspace(-5, 5, 45);
y = linspace(-5, 5, 45);
[x, y] = meshgrid(x, y);
z = 0.5*x.^2 + 2*y.^2;
contour(x,y,z)
title('Contour and Quiver of f(x_{1}, x_{2}) = 0.5x_{1}^{2} + 2x_{2}^{2}')
xlabel('x_{1}');
ylabel('x_{2}');
zlabel('z');
hold on
grid on
[dx,dy] = gradient(z,0.11);
quiver(x,y,dx, dy)


