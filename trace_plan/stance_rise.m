
function [Px,Py,Pz]=stance_rise(LEG,count)
% The author is suntao
% DATA is 2015/7/15
T=2;
step=T/count;
t=0:step:T-step;
t=t';
    [Px0,Py0,Pz0]=foot_initial(LEG);

switch LEG
    case 1
        Px=Px0+zeros(count,1);
        Py=Py0+zeros(count,1);
        Pz=Pz0+0.040*sin(2*pi/T*t-pi/2);
          figure('Name','stance rise  trajectory','NumberTitle','on');
        
        subplot(4,4,1);
        plot(Px,Pz);
        title('QY-Px-Pz');
        subplot(4,4,2);
        plot(Px);
        title('QY-Px');
        axis([1 100 -2 2]);
        subplot(4,4,3);
        plot(Pz);
        title('QY-Pz');
        axis([1 100 -2 2]);
        subplot(4,4,4);
        plot(Py);
        title('QY-Py');
        axis([1 100 -2 2]);
      
    case 2
        
        Px=Px0+zeros(count,1);
        Py=Py0+zeros(count,1);
        Pz=Pz0+0.040*sin(2*pi/T*t-pi/2);
        
        
        subplot(4,4,5);
        plot(Px,Pz);
        title('QZ-Px-Pz');
        subplot(4,4,6);
        plot(Px);
        title('QZ-Px');
        axis([1 100 -2 2]);
        subplot(4,4,7);
        plot(Pz);
        title('QZ-Pz');
        axis([1 100 -2 2]);
        subplot(4,4,8);
        plot(Py);
        title('QZ-Py');
        axis([1 100 -2 2]);

        
    case 3
        
        Px=Px0+zeros(count,1);
        Py=Py0+zeros(count,1);
        Pz=Pz0+0.040*sin(2*pi/T*t-pi/2);
        
        subplot(4,4,9);
        plot(Px,Pz);
        title('HY-Px-Pz');
        subplot(4,4,10);
        plot(Px);
        title('HY-Px');
        axis([1 100 -2 2]);
        subplot(4,4,11);
        plot(Pz);
        title('HY-Pz');
        axis([1 100 -2 2]);
        subplot(4,4,12);
        plot(Py);
        title('HY-Py')
        axis([1 100 -2 2]);

        
    case 4
        
        Px=Px0+zeros(count,1);
        Py=Py0+zeros(count,1);
        Pz=Pz0+.040*sin(2*pi/T*t-pi/2);
        
        
        subplot(4,4,13);
        plot(Px,Pz);
        title('HZ-Px-Pz');
        subplot(4,4,14);
        plot(Px);
        title('HZ-Px');
        axis([1 100 -2 2]);
        subplot(4,4,15);
        plot(Pz);
        title('HZ-Pz');
        axis([1 100 -2 2]);
        subplot(4,4,16);
        plot(Py);
        title('HZ-Py');
        axis([1 100 -2 2]);
        
 
        
end
end