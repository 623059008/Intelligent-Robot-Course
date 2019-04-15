
function landmark()
    clear;
    close;
    clc;
    
    [a, b, c, d] = deal([0, 0], [0, 1], [2, 1], [1, 2]);
    points = zeros(20, 2);
    da = pdist2(a, d);
    db = pdist2(b, d);
    dc = pdist2(c, d);
    noise = [0, 0, 0];

    ptr = 0.10;
    options = optimoptions('fsolve', 'Algorithm', 'levenberg-marquardt');
    for i = 1:20
        noise(1) = da + ptr * rand();
        noise(2) = db + ptr * rand();
        noise(3) = dc + ptr * rand();
        points(i, :) = fsolve(@cal, [0 0], options);
    end
    
    function [res] = cal(p)
        res(1) = abs(pdist2(a, p) - noise(1));
        res(2) = abs(pdist2(b, p) - noise(2));
        res(3) = abs(pdist2(c, p) - noise(3));
    end

    x = [a(1), b(1), c(1)];
    y = [a(2), b(2), c(2)];
    scatter(x, y, 'r', 'filled'); hold on
    scatter(points(:,1), points(:,2), 'b', 'filled');
end


