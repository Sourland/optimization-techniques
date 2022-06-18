function [isFound, alphas, betas, x] = bisetrix_der(f, a, b, L)
%BISETRIX_DER Finds the [a, b] interval where minf belongs, uses paragraph 5.1.4 from the book
%   @param f the function that we search for its min
%   @param a, b the lower and upper bound of the search interval
%   @param L is the l that we use to find the number of iterations
%   This algorithm is the bisetrix search algorithms using derivatives
    df = matlabFunction(diff(f));
    n = 1;
    while(1)
        if 0.5^n <= L/(b-a)
            break
        else
            n = n + 1;
        end
    end
    x = zeros(n,1);
    values = zeros(n,1);
    alphas = zeros(n+1,1);
    alphas(1) = a;
    betas = zeros(n+1,1);
    betas(1) = b;
    for k = 1:n
        x(k) = (alphas(k)+betas(k))/2;
        values(k) = df(x(k));
        if values(k) == 0
            isFound = string(values(k)) + " is the min of the function\n";
            return;
        elseif values(k) > 0
            alphas(k+1) = alphas(k);
            betas(k+1) = x(k);
        elseif values(k) < 0
            alphas(k+1) = x(k);
            betas(k+1) = betas(k);
        end
    end
        isFound = "Min can be found between [" + string(alphas(n+1)) +", " + string(betas(n+1)) + "]\n";
    
end

