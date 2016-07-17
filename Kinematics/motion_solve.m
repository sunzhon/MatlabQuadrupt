%% this function base cordination is kuan joint
function [Px,Py,Pz]=motion_solve(theta1,theta2,theta3)
L2=357;
L3=577;
a=20;
c=70;
sigma=a+L2*cos(theta2)+L3*cos(theta2+theta3);
Px=sin(theta1)*sigma-c*cos(theta1);
Py=-L2*sin(theta2)-L3*sin(theta2+theta3);
Pz=-c*sin(theta1)-cos(theta1)*sigma;
end