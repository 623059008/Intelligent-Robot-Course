close all;
clc;
clear all;


r = 1;
t = 2;
theta = 0;
delta = 1;
[a1, a2, a3, a4, a5, a6] = deal(0, 0.03, 0.2, 0.04, 0.03, 0.02);
[u1, u2, u3] = deal(0.02, 0.03, 0.04);

sample = @(x) x * randn(1);

[v0, w0, r0] = deal(1, 1, 0);
[v, w, r] = deal(v0, w0, r0);

tmp1 = a1 * (v0^2) + a2 * (w0^2);
tmp2 = a3 * (v0^2) + a4 * (w0^2);
tmp3 = a5 * (v0^2) + a6 * (w0^2);

x = [];
y = [];

for n = 1:500
    while (true)
        [v , w, r] = deal(v0+sample(tmp1), w0+sample(tmp2), sample(tmp3));
        x(n) = u1 + v/w * (-sin(theta) + sin(theta + w * delta) );
        y(n) = u2 + v/w * ( cos(theta) - cos(theta + w * delta) );
        if ( x(n) >= 0.7 && x(n) <= 1 && y(n) >= 0.4 && y(n) <= 0.5) == false
            break;
        end
    end
end

scatter(x, y , 'r.');
hold on;

plot(0, 1, '.');
hold on;
plot(0.8*cos(-pi/2:0.1:1-pi/2), 1+0.8*sin(-pi/2:0.1:1-pi/2));
hold on;
plot(1.2*cos(-pi/2:0.1:1-pi/2), 1+1.2*sin(-pi/2:0.1:1-pi/2));
hold on;
plot(0.2*cos(0:0.1:2*pi+0.1), 0.2*sin(0:0.1:2*pi+0.1));
hold on;
plot(cos(1-pi/2)+0.2*cos(0:0.1:2*pi+0.1), 1+sin(1-pi/2)+0.2*sin(0:0.1:2*pi+0.1));
hold on;
rectangle('Position',[0.7 0.4 0.3 0.1],'LineWidth',1,'EdgeColor','black'); 
hold on;
axis equal;