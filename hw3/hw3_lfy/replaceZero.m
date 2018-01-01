function [r] = replaceZero(x)
    [m,n] = size(x);
        for q = 1:m
            if strcmp(x(q,2),{' ?'}) == 1
               x(q,2) = {' Private'}
            end
            if strcmp(x(q,7),{' ?'}) == 1
               x(q,7) = {' Other service'}
            end
            if strcmp(x(q,14),{' ?'}) == 1
                x(q,14) = {' Others'}
            end
        end
    r = x;
end