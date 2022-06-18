
function [isFound, alphas, betas, x, y] = fib_opt(f, a, b, l)
%FIB_OPT Finds the [a, b] interval where minf belongs, uses paragraph 5.1.3 from the book
%   @param f the function that we search for a min
%   @param a, b the lower and upper bounds of search interval [a. b]
%   @param l to find the number of repeats
%   fib_opt algorithm uses fibonacci numbers to locate the minimum of a function

% Find number of repeats
    done = 0;
    n = 1;
    while(~done)
        if fib(n) > (b - a)/l 
            done = 1;
        else
            n = n + 1;
        end
    end
%Implement the algorithm
    %Initialization
    x = NaN *ones(n-2, 2);
    x(1,1) = a + (fib(n-2)/fib(n))*(b - a);
    x(1,2) = a + (fib(n-1)/fib(n))*(b - a);
    
    
     y = NaN *ones(n-2, 2);
    
    
    alphas = NaN *ones(n-2, 1);
    betas = NaN *ones(n-2, 1);
    alphas(1) = a;
    betas(1) = b;
    
    for i = 1:(n-2)
        x(i, 1) = (fib(n-i-1)/fib(n-i+1))*(betas(i) - alphas(i)) + alphas(i);
        x(i, 2) = (fib(n-i)/fib(n-i+1))*(betas(i) - alphas(i)) + alphas(i);
        y(i,1) = f(x(i,1));
        y(i,2) = f(x(i,2));
        if f(x(i,2)) > f(x(i, 1))
            alphas(i+1) = alphas(i);
            betas(i+1) = x(i, 2);
        elseif f(x(i,2)) < f(x(i, 1))
            alphas(i+1) = x(i, 1);
            betas(i+1) = betas(i);
        end
    end
   isFound = "The min is between [" + string(alphas(n-2)) + ", " + string(betas(n-2)) + "]\n";
       
    
end

