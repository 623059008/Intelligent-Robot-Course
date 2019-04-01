clear, clc;
setenv('ROS_MASTER_URI', 'http://10.21.40.23:11311');
setenv('ROS_IP','10.21.40.23');
rosshutdown;
rosinit('10.21.40.23', 'NodeHost', '10.21.40.23');


linkStates = rossubscriber('/gazebo/link_states');
position = rossubscriber('/tf');
position_information = receive(position);
stateData = receive(linkStates);

xx = position_information.Transforms.Transform.Rotation.X;
yy = position_information.Transforms.Transform.Rotation.Y;
zz = position_information.Transforms.Transform.Rotation.Z;
ww = position_information.Transforms.Transform.Rotation.W;
quat = [xx yy zz ww];
euler = quat2eul(quat)*360/(2*pi);

r = euler(3);  % theta
x = position_information.Transforms.Transform.Translation.X; % x
y = position_information.Transforms.Transform.Translation.Y; % y

velpub = rospublisher('/cmd_vel');
velinfo = rosmessage(velpub);
%Destination is (0, -1)%
 velinfo.Angular.Z=0.01;
  velinfo.Linear.X = 0;
  
  % init the coordinate of the target in (3, 4)
  tx = 0;
  ty = 0;
 while (sqrt((x-tx)^2+(y-ty)^2) > 0.5)
    % tf coordinate tranform
   position = rossubscriber('/tf');
   position_information = receive(position);
   
   xx = position_information.Transforms.Transform.Rotation.X;
   yy = position_information.Transforms.Transform.Rotation.Y;
   zz = position_information.Transforms.Transform.Rotation.Z;
   ww = position_information.Transforms.Transform.Rotation.W;
   quat = [xx yy zz ww];
   
   euler = quat2eul(quat)*360/(2*pi);
    r = euler(3);  % theta , a prarmeter about the angle
    x = position_information.Transforms.Transform.Translation.X; % x
    y = position_information.Transforms.Transform.Translation.Y; % y
    dy = y-ty;  %Adjust the orientation%
    dx = x-tx;  %Adjust the orientation%
    theta = atan(dy/dx)*180/pi;
    if(mod(abs(theta-r),360)<=180)
         velinfo.Angular.Z=(theta-r)/10;
   else
      velinfo.Angular.Z=(theta-r+360)/10;
   end
    %Adjust the velocity%
    velinfo.Linear.X = 0.6 * sqrt( (x - tx)^2 + (y - ty)^2 )
    send(velpub,velinfo);
 end

% reset the parameter
velinfo.Linear.X = 0;
velinfo.Angular.Z = 0;
send(velpub,velinfo);