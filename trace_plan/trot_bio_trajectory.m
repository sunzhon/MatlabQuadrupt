
function [Px,Py,Pz]=trot_bio_trajectory(Leg,count,High,Step_length,gait_cycle)
% 下等运动
%机器人初始位置
T=gait_cycle;
% count=100;
step=T/count;
length=Step_length;
% high=100/2;
high=High;
X=480;
Z=360;
t1=0:step:T/4-step;
t2=T/4:step:T/2-step;
t3=T/2:step:T-step;

switch Leg
    case 1      %前右腿
        Px0=500;
        Pz0=-1180;
        Py0=-200;
        
    case 2      %前左腿
        Px0=500;
        Pz0=-1180;
        Py0=200;
        
    case 3      %后右腿
        Px0=-500;
        Pz0=-1180;
        Py0=-200;
        
    case 4      %后左腿
        Px0=-500;
        Pz0=-1180;
        Py0=200;
end
Px11=X/T*t1+Px0;
Pz11=Z/T*t1+Pz0;
%x2=length+high*cos(6.6949-17.9223/T*t2);
%y2=length+high*sin(6.6949-17.9223/T*t2);
Px12=length+high*cos(pi-acos(0.6)-((6*pi-4*acos(0.6))/T*(t2-T/4)))+Px0;
Pz12=high+high*sin(pi-acos(0.6)-((6*pi-4*acos(0.6))/T*(t2-T/4)))+Pz0;
Px2=2*length-300/T*t3+Px0;
Px1=[Px11,Px12];
Pz1=[Pz11,Pz12];
% subplot(2,2,1);
Pz2=Pz0+zeros(1,count/2);
Py=Py0+zeros(count,1);
switch Leg
    case 1
   
        Px=[Px1,Px2];
        Px=Px';
        Pz=[Pz1,Pz2];
        Pz=Pz';
  
        subplot(4,3,1);
        plot(Px);
        title('QY-Px');
        subplot(4,3,2);
        plot(Pz);
        title('QY-Pz');
        subplot(4,3,3);
        plot(Px,Pz);
        title('QY-Px-Pz');
    case 2
        
        
        Px=[Px2,Px1];
        Px=Px';
        Pz=[Pz2,Pz1];
        Pz=Pz';
        
        subplot(4,3,4);
        plot(Px);
        title('QZ-Px');
        subplot(4,3,5);
        plot(Pz);
        title('QZ-Pz');
         subplot(4,3,6);
        plot(Px,Pz);
        title('QZ-Px-Pz');

    case 3
        
   
        Px=[Px2,Px1];
        Px=Px';
        Pz=[Pz2,Pz1];
        Pz=Pz';
        
        subplot(4,3,7);
        plot(Px);
        title('HY-Px');
        subplot(4,3,8);
        plot(Pz);
        title('HY-Pz');
         subplot(4,3,9);
        plot(Px,Pz);
        title('HY-Px-Pz');

    case 4

        Px=[Px1,Px2];
        Px=Px';
 
        Pz=[Pz1,Pz2];
        Pz=Pz';
        
        
        subplot(4,3,10);
        plot(Px);
        title('HZ-Px');
        subplot(4,3,11);
        plot(Pz);
        title('HZ-Pz');
         subplot(4,3,12);
        plot(Px,Pz);
        title('HY-Px-Pz');
end

end



