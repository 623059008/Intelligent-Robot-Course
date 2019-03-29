clear; clc;
GM = 3.986005e14;   % earth's universal gravitational [m^3/s^2]
c = 2.99792458e8;   % speed of light (m/s)
omegae_dot = 7.2921151467e-5;  % earth's rotation rate (rad/sec)
alpha = 1e3;

x = alpha * [0.36, 15.2, 15.3, 12.9];
y = alpha * [7.90, 7.86, 3.4, 20.6];
z = alpha * [2.1, 17.3, 0.3, 7.8];
% b = [1.2, 3.2, 0.7, 1.8];
p = []; % fake p
rp = []; % real p

b = 0;
coordinate=alpha*[1.1, 0.8, 1.4];
init_pos = coordinate;
for i=[1:4]
   %p(i) = calcdistance([x(i), y(i), z(i)], coordinate, b(i) ); 
   rp(i) = realdistance([x(i), y(i), z(i)], coordinate);
end
limitation = 10;

coordinate = [0, 0, 0];
for i=[1:4]
   p(i) = calcdistance([x(i), y(i), z(i)], coordinate, b ); 
   %rp(i) = realdistance([x(i), y(i), z(i)], coordinate);
end


for k=[1:5]
    
mat = ones(4, 4);
for i=[1:4]
    mat(i,1)=(x(i)-coordinate(1))/(p(i) - b);
    mat(i,2)=(y(i)-coordinate(2))/(p(i) - b);
    mat(i,3)=(z(i)-coordinate(3))/(p(i) - b);
end

delta_p = p - rp;
f = inv(mat).*delta_p;
del_v = getF(f);

if del_v <= limitation
    break; 
end


coordinate(1) = coordinate(1) + f(1);
coordinate(2) = coordinate(2) + f(2);
coordinate(3) = coordinate(3) + f(3);
b = b + f(4);
end

scatter3(x,y,z,'filled');
hold on
scatter3(coordinate(1), coordinate(2), coordinate(3), 'r', 'filled');
scatter3(init_pos(1), init_pos(2), init_pos(3), 'g', 'filled');
hold off

function d = getF(f)
    d = f.^2
    d = sqrt(sum(d(:)))
end

function p = realdistance(A, B)
    C = A - B;
    C = C.^2;
    p = sqrt(sum(C(:)));
end

function p = calcdistance( A, B, b)
   c = 2.99792458e8;   % speed of light (m/s)
   C=A-B;
   C=C.^2;
   p = sqrt(sum(C(:))) + c * b;
end
