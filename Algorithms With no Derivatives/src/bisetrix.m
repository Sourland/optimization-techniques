function [isFound, alphas, betas, y1, y2, x1, x2] = bisetrix(f, a, b, epsilon, lambda, einv)
%BISETRIX Finds the [a, b] interval where minf belongs, uses algorithm 5.1.1 from the book
    % @param f - the function that we want to find the minimum
    % @param a - the lower bound of [a, b] interval
    % @param b - the upper bound of [a, b] interval
    % @param epsilon - the epsilon required by the algorithm in each step
    % @param lambda - the finishing condition of the algorithm
    % If k counter goes over 1m then the algorithm finishes, printing a failure messase
    % This is the bisetrix search algorithm without using derivatives
    found = 0;
    k = 1;
    x1 = zeros(einv, 1);
    x2 = zeros(einv, 1);
    y1 = zeros(einv, 1);
    y2 = zeros(einv, 1);
    alphas = zeros(1, einv);
    betas = zeros(1, einv);
    alphas(1) = a;
    betas(1) = b;
    while(~found)
        if(betas(k) - alphas(k) < lambda)
            isFound = "min point is between [" + string(alphas(k)) +" " + string(betas(k)) + "]\n";
            found = 1;
        else
            x1(k) = (alphas(k) + betas(k))/2 - epsilon;
            x2(k) = (alphas(k) + betas(k))/2 + epsilon;
            y1(k) = f(x1(k));
            y2(k) = f(x2(k));
        end
        if(f(x1(k)) < f(x2(k)))
            alphas(k+1) = alphas(k);
            betas(k+1) = x2(k);
        else
            alphas(k+1) = x1(k);
            betas(k+1) = betas(k);
        end
        k = k + 1;
        if(k > 1e6)
            isFound = "cannot be found\n";
            break
        end
    end
    alphas = nonzeros(alphas);
    betas = nonzeros(betas);
    y1 = nonzeros(y1);
    y2 = nonzeros(y2);
    x1 = nonzeros(x1);
    x2 = nonzeros(x2);
end
