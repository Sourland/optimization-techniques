function fib_number = fib(n)
% Generate Fibonacci numbers using the dynamic programming algorithm with
%   @param n the n-th fibonacci number
%   O(n) complexity
    numbers = zeros(n, 1);
    numbers(1) = 1;
    numbers(2) = numbers(1);
    for i = 3:n
        numbers(i) = numbers(i-1) + numbers(i-2);
    end
    fib_number = numbers(n);
end