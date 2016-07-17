clear all;clc
% 下等运动
%机器人初始位置
H=100;
S=150;
T=1;
Ty=0.4*T;
count=200;
step=T/count;
t1=0:step:Ty-step;%0-1
t2=0:step:Ty/2-step;%0-0.5
t3=Ty/2:step:Ty-step;%0.5-1
t4=Ty:step:T;%1-2
t=[t1,t4]';

x1=S*(t1/Ty-1/2/pi*sin(2*pi.*t1/Ty))-S/2;
z11=2*H*(t2/Ty-1/4/pi*sin(4*pi.*t2/Ty));
z12=2*H*((Ty-t3)/Ty-1/4/pi*sin(4*pi*(Ty-t3)/Ty));
z1=[z11,z12];
vx1=S/Ty*(1-cos(2*pi/Ty.*t1));
vz11=2*H/Ty*(1-cos(4*pi.*t2/Ty));
vz12=-2*H/Ty*(1-cos(4*pi*(Ty-t3)/Ty));
vz1=[vz11,vz12];

% x2=S/2-S*((t4-Ty)/(T-Ty)-1/2/pi*sin(2*pi*(t4-Ty)/(T-Ty)));
x2=S/2-S*((t4-Ty)/(T-Ty)-1/2/pi*sin(2*pi*(t4-Ty)/(T-Ty)));

z2=zeros(1,121);
vx2=-S/(T-Ty)*(1-cos(2*pi*(t4-Ty)/(T-Ty)));
vz2=zeros(1,121);

x=[x1,x2];
z=[z1,z2];
vx=[vx1,vx2];
vz=[vz1,vz2];



clf ;
figure(1);
        plot(x,z);
%r为大腿液压缸相关标记；g为小腿液压缸相关标记。
%         title('Sine trajectory');
        xlie=x';ylie=z';
        xlabel('d(mm) ');
        ylabel('d(mm)');
%subplot(4,2,2);
figure(2);
        plot(t,x,t,z);
        
        xlie=t';ylie=x';
        xlabel('t(s)');
        ylabel('d(mm)');
        legend('x(t)','z(t)');
        title('Displacement of x and z');
% subplot(4,2,3);
figure(3);
         plot(t,vx,t,vz);
         xlie=t';ylie=z';
         xlabel('t(s)');
         ylabel('v(mm/s)');
         legend('vx(t)','vz(t)');
         title('Velocity of x and z');
%subplot(4,2,4);
% figure(4);
%         plot(t,ax,t,az);
%          xlie=t';ylie=z';
%          xlabel('time(s)');
%          ylabel('a(mm/s^2)');
%          legend('ax(t)','az(t)');
%          title('accelerated velocity of x and z');
%  y=zeros(1,201);
