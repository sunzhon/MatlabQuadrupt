function [theta1,theta2,theta3] = ikinematic(leg,Px,Py,Pz)
% The author is suntao
% DATA is 2015/7/15
% 三关节的旋转角度
% b w h 分别表示机器人机身的长、宽和高
% a c 分别表示O1到O2的竖直方向和横向的距离
% L2 L3 分别表示大腿和小腿的长度
% A,B 是逆解的中间变量
% model_type=0,this means phisical,=1,this is virtual robot
     
        b=.990/2;%单位 m
        w=.440/2;
        h=.285;%%%%机身体高度，此参数不准
        L2=.360;
        L3=.580;
        a=.020;
        c=.070;

switch leg
    case 1
        X=Py-c+w;
        Y=Pz+h;
        theta1 = asin(-c./((X.^2 + Y.^2).^(1/2))) -atan(X./Y);
        
        A=Py.*sin(theta1) - Pz.*cos(theta1) - a - h.*cos(theta1) - c.*sin(theta1) + w.*sin(theta1);
        B=Px -b;%90度
    case 2
        X=Py+c-w;
        Y=Pz+h;
        theta1 = asin(-c./(X.^2 + Y.^2).^(1/2)) - atan(X./Y);
        
        A=Py.*sin(theta1) - Pz.*cos(theta1) - a - h.*cos(theta1) + c.*sin(theta1) - w.*sin(theta1);
        B=Px-b;
    case 3
        
        X=-Py+c-w;
        Y=Pz+h;
        theta1 = asin(-c./(X.^2 + Y.^2).^(1/2)) - atan(X./Y);
        
        A=c*sin(theta1) - Pz.*cos(theta1) - Py.*sin(theta1) - h*cos(theta1) - a - w*sin(theta1);
        B=-Px - b;
        
    case 4
        
        X=-Py-c+w;
        Y=Pz+h;
        theta1 = asin(-c./(X.^2 + Y.^2).^(1/2)) - atan(X./Y);
        
        A=w*sin(theta1) - Pz.*cos(theta1) - Py.*sin(theta1) - h*cos(theta1) - c*sin(theta1) - a;
        B=- Px - b;
        
end
theta1=zeros(size(Px));
theta3=acos((A.^2+B.^2-L2^2-L3^2)/(2*L2*L3));
theta2=acos((L3.*sin(theta3).*B+(L2+L3.*cos(theta3)).*A)./(L2^2+L3^2+2*L2*L3.*cos(theta3)));


theta2_min=-10/180*pi;
theta2_max=60/180*pi;
theta3_min=35/180*pi;
theta3_max=95/180*pi;

if (min(theta2)>theta2_min)||(max(theta2)<theta2_max)||(min(theta3)>theta3_min)||(max(theta3)<theta3_max)
   ;
else
    error('motion_unsolve theta error, the solution be out of range!');
end
end



