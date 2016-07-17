clc;
count=2000;
theta2_low=-6/180*pi;
theta2_high=59/180*pi;
theta3_low=38/180*pi;
theta3_high=105/180*pi;
theta=zeros(count,3);
works=zeros(count,3);
theta(:,2)=theta2_low+(theta2_high-theta2_low)*rand(count,1);
theta(:,3)=theta3_low+(theta3_high-theta3_low)*rand(count,1);
for i=1:count
    [works(i,1),works(i,2),works(i,3)]=motion_solve(theta(i,1),theta(i,2),theta(i,3));
end

plot(works(:,3),works(:,2),'b*');
