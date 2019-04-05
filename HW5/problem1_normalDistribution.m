%problem1 par1 
%»­ÕýÌ«·Ö²¼Í¼

clear all; clc ;
x = -4:0.1:4;
y = normpdf(x, 0, 1);
figure;
plot(x,y);
grid;
%legend('normal distribution');
hold on;
area(x , y);