function curb_data(trajectory)
disp('Please choose traject , 1 is rise ,2 is cycloid,3 is bio ');
close all;
simulation_circle=1;
count=100;
High=70;
Step_lenght=150;
gait_period=2;
dutyfactor=0.6;
Value=zeros(count,3,4);
Theta=zeros(count,3,4);%model robot
Length=zeros(count,3,4);%model robot
workspace=zeros(count,12);
QuantityFlow=zeros(count-1,4);

for Leg=1:4
    switch trajectory
        case 1
            [Px,Py,Pz]=stance_rise(Leg,count);%轨迹规划
            traj='stance rise';
            
        case  2
            [Px,Py,Pz]=trot_cycloid(Leg,count,High,Step_lenght,gait_period,dutyfactor);%轨迹规划
            traj='trot cycloid';
            
        case 3
            [Px,Py,Pz]=trot_bio_trajectory(Leg,count,High,Step_lenght,gait_period);
            traj='trot_bio trajectory';        
    end

    
    [theta1,theta2,theta3] = ikinematic(Leg,Px,Py,Pz);%运动学逆解
    [L1,Lfg,Leh]=Cylinder_Elongation(theta1,theta2,theta3);%液压缸边长度
    [v1,v2,v3]=Voltage_Value(L1,Lfg,Leh);%控制电压
    LegQuantity=flowrate(L1,Lfg,Leh,gait_period);%系统流量
   
    workspace(:,3*Leg-2)=Px;
    workspace(:,3*Leg-1)=Py;
    workspace(:,3*Leg)=Pz;
    QuantityFlow(:,Leg)=LegQuantity;
    
    Theta(:,1,Leg)=theta1;
    Theta(:,2,Leg)=theta2;
    Theta(:,3,Leg)=theta3;
    Length(:,1,Leg)=L1;
    Length(:,2,Leg)=Lfg;
    Length(:,3,Leg)=Leh;
    Value(:,1,Leg)=v1;
    Value(:,2,Leg)=v2;
    Value(:,3,Leg)=v3;
end
%% plot workspace trajectory
figure('Name','workspace','NumberTitle','on');
plot3(workspace(:,1),workspace(:,2),workspace(:,3),workspace(:,4),workspace(:,5),workspace(:,6),workspace(:,7),workspace(:,8),workspace(:,9),workspace(:,10),workspace(:,11),workspace(:,12));
%% save data to txt, excel mat
re=save_data(Theta,Length,Value,QuantityFlow,count,gait_period,simulation_circle);
disp('The trajectory is :');
disp( traj);
if re==0
    error('save_data');
end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             