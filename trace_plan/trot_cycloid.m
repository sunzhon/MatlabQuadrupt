function [Px,Py,Pz]=trot_cycloid(leg,count,H,S,T,dutyfactor)
%% The author is suntao
% DATA is 2015/7/15
% 下等运动
%机器人初始位置
% H=70;
% S=150;
% T=1;
%% 
Ty=(1-dutyfactor)*T;
step=T/count;
t1=0:step:Ty-step;%0-1
t11=0:step:Ty/2-step;%0-0.5
t12=Ty/2:step:Ty-step;%0.5-1
t2=Ty:step:T-step;%1-2


switch leg
    case 1      %前右腿
        Px0=523;
        Pz0=-1136;
        Py0=-220;
        
    case 2      %前左腿
        Px0=523;
        Pz0=-1136;
        Py0=220;
        
    case 3      %后右腿
        Px0=-523;
        Pz0=-1136;
        Py0=220;
        
    case 4      %后左腿
        Px0=-523;
        Pz0=-1136;
        Py0=-220;
end
        Px1=S*(t1/Ty-1/2/pi*sin(2*pi.*t1/Ty))+Px0-S/2;
        Px2=Px0+S/2-S*((t2-Ty)/(T-Ty)-1/2/pi*sin(2*pi*(t2-Ty)/(T-Ty)));
        Py=Py0+zeros(count,1);
        Pz11=2*H*(t11/Ty-1/4/pi*sin(4*pi.*t11/Ty))+Pz0;
        Pz12=2*H*((Ty-t12)/Ty-1/4/pi*sin(4*pi*(Ty-t12)/Ty))+Pz0;
        Pz1=[Pz11,Pz12];
        Pz2=Pz0+zeros(size(t2));
        Pz1=Pz1';
        Pz2=Pz2';
        Px1=Px1';
        Px2=Px2';
switch leg
    case 1
       Px=[Px2(0.5*count+1:dutyfactor*count,1);Px1;Px2(1:0.5*count,1)];
        Pz=[Pz2(0.5*count+1:dutyfactor*count,1);Pz1;Pz2(1:0.5*count,1)];
       figure('Name','trot cycloid trajectory','NumberTitle','on');
       
        subplot(4,4,1);
        plot(Px,Pz);
        title('QY-Px-Pz');
        subplot(4,4,2);
        plot(Px);
        title('QY-Px');
        subplot(4,4,3);
        plot(Pz);
        title('QY-Pz');
        subplot(4,4,4);
        plot(Py);
        title('QY-Py');
      case 2
        
        Px=[Px2;Px1];
        Pz=[Pz2;Pz1];
        
        subplot(4,4,5);
        plot(Px,Pz);
        title('QZ-Px-Pz');
        subplot(4,4,6);
        plot(Px);
        title('QZ-Px');
        subplot(4,4,7);
        plot(Pz);
        title('QZ-Pz');
        subplot(4,4,8);
        plot(Py);
        title('QZ-Py');

    case 3
        
        Px=[Px2;Px1];
        Pz=[Pz2;Pz1];
        
        subplot(4,4,9);
        plot(Px,Pz);
        title('HY-Px-Pz');
        subplot(4,4,10);
        plot(Px);
        title('HY-Px');
        subplot(4,4,11);
        plot(Pz);
        title('HY-Pz');
        subplot(4,4,12);
        plot(Py);
        title('HY-Py')
   
    case 4

       Px=[Px2(0.5*count+1:dutyfactor*count,1);Px1;Px2(1:0.5*count,1)];
        Pz=[Pz2(0.5*count+1:dutyfactor*count,1);Pz1;Pz2(1:0.5*count,1)];
     
        
        subplot(4,4,13);
        plot(Px,Pz);
        title('HZ-Px-Pz');
        subplot(4,4,14);
        plot(Px);
        title('HZ-Px');
        subplot(4,4,15);
        plot(Pz);
        title('HZ-Pz');
        subplot(4,4,16);
        plot(Py);
        title('HZ-Py');
end

     



end


