clc
close all

motionModel = robotics.OdometryMotionModel;

motionModel.Noise = [0.01 0.01 0.01 0.01];
 
previousPoses = ones(100,3);

currentOdom = [2 2 2];

data = zeros(100,3,100);

data(:,:,:) = NaN;

odm = zeros(3,100);
odom(:,:) = NaN;
t = 1;

ax = gca;


hold on
while t < 10
    
    odom(1,t) = currentOdom(1);
    odom(2,t) = currentOdom(2);
    odom(3,t) = currentOdom(3);
    
    currentPoses = motionModel(previousPoses, currentOdom);
    
    data(:,:,t) = currentPoses(:,:);
    
    currentOdom = currentOdom + [1 0 0];
    
    previousPoses = currentPoses;
    
    t = t + 1;
end

while t < 20
    
    odom(1,t) = currentOdom(1);
    odom(2,t) = currentOdom(2);
    odom(3,t) = currentOdom(3);
    
    currentPoses = motionModel(previousPoses, currentOdom);
    
    data(:,:,t) = currentPoses(:,:);
    
    currentOdom = currentOdom + [0 1 0];
    
    previousPoses = currentPoses;
    
    t = t + 1;
end

n = 1;

for n = 1 : 20
  
    
        
    scatter(data(:,1,n),data(:,2,n),'filled');
    hold on 
 
   
       pause(1)
end

