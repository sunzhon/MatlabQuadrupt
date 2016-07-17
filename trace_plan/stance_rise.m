
function [Px,Py,Pz]=stance_rise(LEG,count)
% The author is suntao
% DATA is 2015/7/15
T=2;
step=T/count;
t=0:step:T-step;
t=t';

switch LEG
    case 1
        Px=500+zeros(count,1);
        Py=-200+zeros(count,1);
        Pz=-1140+40*sin(2*pi/T*t-pi/2);
          figure('Name','stance rise  trajectory','NumberTitle','on');
        
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
        
        Px=500+zeros(count,1);
        Py=200+zeros(count,1);
        Pz=-1140+40*sin(2*pi/T*t-pi/2);
        
        
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
        
        Px=-500+zeros(count,1);
        Py=-200+zeros(count,1);
        Pz=-1140+40*sin(2*pi/T*t-pi/2);
        
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
        
        Px=-500+zeros(count,1);
        Py=200+zeros(count,1);
        Pz=-1140+40*sin(2*pi/T*t-pi/2);
        
        
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