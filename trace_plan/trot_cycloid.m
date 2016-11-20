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


%% zuduan chushi weizhi 
[Px0,Py0,Pz0]=foot_initial(leg);

%% guiji 

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
       figure('Name','trot cycloid trajectory','NumberTitle','off');
       
         subplot(4,7,1+(leg-1)*7);
        plot(Px,Pz);
        title('QY-Px-Pz');
        grid on;
        subplot(4,7,2+(leg-1)*7);
        plot(Px);
        title('QY-Px');
        grid on;
        subplot(4,7,3+(leg-1)*7);
        plot(Pz);
        title('QY-Pz');
        grid on;
        subplot(4,7,4+(leg-1)*7);
        plot(Py);
        title('QY-Py');
        grid on;
         subplot(4,7,5+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Px)/step);
        title('QY-PxV');
        grid on;
        subplot(4,7,6+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Pz)/step);
        title('QY-PzV');
        grid on;
        subplot(4,7,7+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Py)/step);
        title('QY-PyV');
        grid on;
      case 2
        
        Px=[Px2;Px1];
        Pz=[Pz2;Pz1];
        
           
      subplot(4,7,1+(leg-1)*7);
        plot(Px,Pz);
        title('QZ-Px-Pz');
         grid on;
        subplot(4,7,2+(leg-1)*7);
        plot(Px);
        title('QY-Px');
        grid on;
        subplot(4,7,3+(leg-1)*7);
        plot(Pz);
        title('QY-Pz');
        grid on;
        subplot(4,7,4+(leg-1)*7);
        plot(Py);
        title('QY-Py');
        grid on;
         subplot(4,7,5+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Px)/step);
        title('QY-PxV');
        grid on;
        subplot(4,7,6+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Pz)/step);
        title('QY-PzV');
        grid on;
        subplot(4,7,7+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Py)/step);
        title('QY-PyV');
        grid on;

    case 3
        
        Px=[Px2;Px1];
        Pz=[Pz2;Pz1];
        
           subplot(4,7,1+(leg-1)*7);
        plot(Px,Pz);
        title('HY-Px-Pz');
        grid on;
        subplot(4,7,2+(leg-1)*7);
        plot(Px);
        title('QY-Px');
        grid on;
        subplot(4,7,3+(leg-1)*7);
        plot(Pz);
        title('QY-Pz');
        grid on;
        subplot(4,7,4+(leg-1)*7);
        plot(Py);
        title('QY-Py');
        grid on;
         subplot(4,7,5+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Px)/step);
        title('QY-PxV');
        grid on;
        subplot(4,7,6+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Pz)/step);
        title('QY-PzV');
        grid on;
        subplot(4,7,7+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Py)/step);
        title('QY-PyV');
        grid on;
   
    case 4

       Px=[Px2(0.5*count+1:dutyfactor*count,1);Px1;Px2(1:0.5*count,1)];
        Pz=[Pz2(0.5*count+1:dutyfactor*count,1);Pz1;Pz2(1:0.5*count,1)];
     
         subplot(4,7,1+(leg-1)*7);
        plot(Px,Pz);
        title('HZ-Px-Pz');
         grid on;
        subplot(4,7,2+(leg-1)*7);
        plot(Px);
        title('QY-Px');
        grid on;
        subplot(4,7,3+(leg-1)*7);
        plot(Pz);
        title('QY-Pz');
        grid on;
        subplot(4,7,4+(leg-1)*7);
        plot(Py);
        title('QY-Py');
        grid on;
         subplot(4,7,5+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Px)/step);
        title('QY-PxV');
        grid on;
        subplot(4,7,6+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Pz)/step);
        title('QY-PzV');
        grid on;
        subplot(4,7,7+(leg-1)*7);
        plot(linspace(0,T,count-1),diff(Py)/step);
        title('QY-PyV');
        grid on;

end

     



end


