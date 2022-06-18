
function [isFound, alphas, betas, y1, y2, x1, x2] = GoldenSection(f, a, b, l)
% Function GoldenSection, follows the algorithm from paragraph 5.1.2 from the book
%   @param f - the function that we want to find the minimum
%   @param a - the lower bound of [a, b] interval
%   @param b - the upper bound of [a, b] interval
%   @param lambda - the finishing condition of the algorithm
%   If k counter goes over 1m then the algorithm finishes, printing a failure messase
%   This follows the Golden Section algorithm using a gamma factor to locate the minimum
    found = 0;
    k = 1;
    gamma = 0.618;
    len = 1e5;
    x1 = NaN *ones(len, 1);
    x1(1) = a + (1-gamma)*(b-a);
    x2 = NaN *ones(len, 1);
    x2(1) = a + gamma*(b-a);
    
    y1 = NaN *ones(len, 1);
    y2 = NaN *ones(len, 1);
    y1(1) = f(x1(1));
    y2(1) = f(x2(1));
    
    alphas = NaN *ones(1, len);
    betas = NaN *ones(1, len);
    alphas(1) = a;
    betas(1) = b;
    while(~found)
        %step 1
        if (betas(k) - alphas(k)) < l
            isFound = "Min point, using the golden section algorithm, is between [" + string(alphas(k)) +" " + string(betas(k)) + "]\n";
            break
        end
            %step 2
        if f(x1(k)) > f(x2(k)) 
            alphas(k+1) = x1(k);
            betas(k+1) = betas(k);
            x2(k+1) = alphas(k+1) + gamma*(betas(k+1) - alphas(k+1));
            x1(k+1) = x2(k);
            y2(k+1) = f(x1(k+1));
            
        %step3
        elseif f(x1(k)) < f(x2(k))
            
            alphas(k+1) = alphas(k);
            betas(k+1) = x2(k);
            x2(k+1) = x1(k);
            x1(k+1) = alphas(k+1) + (1-gamma)*(betas(k+1) - alphas(k+1));
            y1(k+1) = f(x1(k+1));
            
        end
        k = k + 1;
        if(k > len)
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