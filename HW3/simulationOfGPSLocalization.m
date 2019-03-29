clear;
clc;

GM = 3.986005e14;   % earth's universal gravitational [m^3/s^2]
c = 2.99792458e8;   % speed of light (m/s)
omegae_dot = 7.2921151467e-5;  % earth's rotation rate (rad/sec)
dd = 1e12;
SatellitePosition1 = dd*[1.0, 2.0, 3.0];
SatellitePosition2 = dd*[2.5, 3.4, 1.2];
SatellitePosition3 = dd*[1.3, 1.2, 2.3];
SatellitePosition4 = dd*[1.5, 2.1, 2.6];

x = dd*[1.0, 2.5, 1.3, 1.5];
y = dd*[2.0, 3.4, 1.2, 2.1];
z = dd*[3.0, 1.2, 2.3, 2.6];
scatter3(x,y,z,'filled');
hold on

userx = dd*[2.2];
usery = dd*[3.2];
userz = dd*[3.3];
userPosition = [2.2, 3.2, 3.3];
scatter3(userx, usery, userz, 'r', 'filled');
hold off

