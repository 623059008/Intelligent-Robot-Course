clear all; 
clc; 
close all;

b = 1;
maxvalue = calc_maxValue(b);
data_x = [];

for n = 1 : 1000000
    x = random('unif',-b, b, 1, 1);
    y = random('unif', 0, maxvalue, 1, 1);
    f = func(x);
    while (y > f)
        x = random('unif',-b, b, 1, 1);
        y = random('unif', 0, maxvalue, 1, 1);
        f = func(x);    
    end
    data_x(n) = x;
end

x_min = min(data_x);
x_max = max(data_x);
x = linspace(x_min, x_max, 1000);
yy = hist(data_x, x);
yy = yy / length(data_x);
bar(x, yy);


function mx=calc_maxValue(b)
    mx = abs(b)
    mx = max(mx, 1)
end

function f=func(x)
    if -1 <= x && x <= 1
        f = abs(x)
    else 
        f = 0
    end
end

