clear all;clc
% (起步阶段没有规划，正常循环的过程)
% syms Px Pz Px0 Pz0 Px1 Pz1 P11 P12 q1 q2  Q10 Q20 Q1 Q11 Q2 Q22 L1 L2 M M1 N J K K1 H S T t t1  t11 t12 t2 Ty;

% h=60;S=550;T=0.4;
h=60;S=50;T=0.5;
L1=357;L2=605;Px0=-240;Pz0=-860;Ty=T/2;
% v=2.0;T=0.001*S/v;
t11=T/200:T/200:Ty/2;t12=Ty/2+T/200:T/200:Ty;t1=[t11,t12];t2=Ty+T/200:T/200:T;
Px=S*(t1/Ty-1/(2*pi)*sin(2*pi*t1/Ty))+Px0;
Pz11=2*h*(t11/Ty-1/(4*pi)*sin(4*pi*t11/Ty))+Pz0;
Pz12=2*h*(1-t12/Ty-1/(4*pi)*sin(4*pi*(Ty-t12)/Ty))+Pz0;
Pz=[Pz11,Pz12];
M=Px.^2+Pz.^2-L1^2-L2^2;
Q2=-acos(M/(2*L1*L2));
K=(L2*Px.*sin(Q2)-Pz.*(L1+L2*cos(Q2)))./(L1^2+L2^2+2*L1*L2*cos(Q2));
Q1=acos(K);
Px1=S+Px0-S*((t2-Ty)/(T-Ty)-1/(2*pi)*sin(2*pi*(t2-Ty)/(T-Ty)));
Pz1=Pz0;
M1=Px1.^2+Pz1.^2-L1^2-L2^2;
Q22=-acos(M1/(2*L1*L2));
K1=(L2*Px1.*sin(Q22)-Pz1.*(L1+L2*cos(Q22)))./(L1^2+L2^2+2*L1*L2*cos(Q22));
Q11=acos(K1);

Q4=acos(M/(2*L1*L2));
K=(L2*Px.*sin(Q4)-Pz.*(L1+L2*cos(Q4)))./(L1^2+L2^2+2*L1*L2*cos(Q4));
Q3=-acos(K);
Px1=S+Px0-S*((t2-Ty)/(T-Ty)-1/(2*pi)*sin(2*pi*(t2-Ty)/(T-Ty)));
Pz1=Pz0;
M1=Px1.^2+Pz1.^2-L1^2-L2^2;
Q44=acos(M1/(2*L1*L2));
K1=(L2*Px1.*sin(Q44)-Pz1.*(L1+L2*cos(Q44)))./(L1^2+L2^2+2*L1*L2*cos(Q44));
Q33=-acos(K1);
t=[t1,t2];q1=[Q1,Q11]*180/pi;q2=[Q2,Q22]*180/pi;q3=[Q3,Q33]*180/pi;q4=[Q4,Q44]*180/pi;
% J=[t;q1;q2]';
% xlswrite('H_angle_modify.xls',J);

Lag=220;Laf=97;
Lbh=110;Lbe=260; %%% 长度赋值 
% Lbh=10;Lbe=205;
Disp1=sqrt(Laf^2+Lag^2-2*Laf*Lag*cos((110.2-abs(q1))*pi/180))-216;
Disp2=sqrt(Lbe^2+Lbh^2-2*Lbe*Lbh*cos((139.41-abs(q2))*pi/180))-268;
% Disp2=sqrt(260^2+110^2-2*260*110*cos((137.41-abs(q2))*pi/180))-268;
Disp3=sqrt(Laf^2+Lag^2-2*Laf*Lag*cos((110.2-abs(q3))*pi/180))-216;
Disp4=sqrt(Lbe^2+Lbh^2-2*Lbe*Lbh*cos((139.41-abs(q4))*pi/180))-268;
% Disp4=sqrt(260^2+110^2-2*260*110*cos((137.41-abs(q4))*pi/180))-268;
Velo1=[diff(Disp1),Disp1(1)-Disp1(end)]/(T/200);
Velo2=[diff(Disp2),Disp2(1)-Disp2(end)]/(T/200);
Velo3=[diff(Disp3),Disp3(1)-Disp3(end)]/(T/200);
Velo4=[diff(Disp4),Disp4(1)-Disp4(end)]/(T/200);
A=Velo1;%后右腿
B=Velo2;%后右脚
C=Velo3;%前左腿
D=Velo4;%前左脚
E=circshift(A,[0,length(t)/2]);%后左腿
F=circshift(B,[0,length(t)/2]);%后左脚
G=circshift(C,[0,length(t)/2]);%前右腿
H=circshift(D,[0,length(t)/2]);%前右脚

for i=1:200
    if A(i)>=0
        a1(i)=A(i);
        a2(i)=0;
    else
        a1(i)=0;
        a2(i)=A(i);
    end
end
for i=1:200
    if B(i)>=0
        b1(i)=B(i);
        b2(i)=0;
    else
        b1(i)=0;
        b2(i)=B(i);
    end
end
for i=1:200
    if C(i)>=0
        c1(i)=C(i);
        c2(i)=0;
    else
        c1(i)=0;
        c2(i)=C(i);
    end
end
for i=1:200
    if D(i)>=0
        d1(i)=D(i);
        d2(i)=0;
    else
        d1(i)=0;
        d2(i)=D(i);
    end
end
P1=a1*pi*14^2/1000000+abs(a2*pi*(14^2-10^2)/1000000);%后右腿
P2=b1*pi*14^2/1000000+abs(b2*pi*(14^2-10^2)/1000000);%后右脚
P3=c1*pi*14^2/1000000+abs(c2*pi*(14^2-10^2)/1000000);%前左腿
P4=d1*pi*14^2/1000000+abs(d2*pi*(14^2-10^2)/1000000);%前左脚
P5=circshift(P1,[0,length(t)/2]);%后左腿
P6=circshift(P2,[0,length(t)/2]);%后左脚
P7=circshift(P3,[0,length(t)/2]);%前右腿
P8=circshift(P4,[0,length(t)/2]);%前右脚
Flux=60*(P1+P2+P3+P4+P5+P6+P7+P8);
Fmax=max(Flux)
Fmean=mean(Flux);

% v
% Fmax*60
set(0,'defaultfigurecolor','w')

%总流量(起步阶段没有规划)
% plot(t,Flux,'r','Linewidth',2)
% xlabel('time(s)');
% ylabel('总流量 (L/min)');
% grid on

%总流量和平均流量(起步阶段没有规划)
% plot(t,Flux,'r','Linewidth',2.5)
% hold on
% plot(t,Fmean*ones(1,length(t)),'--b','Linewidth',2.5)
% xlabel('time (s)','FontSize',12);
% ylabel('总流量(L/min)','FontSize',12);
% grid on
% legend('总流量曲线','平均流量')

%total flux (起步阶段没有规划)
% plot(t,Flux*60,'r','Linewidth',2)
% xlabel('time(s)');
% ylabel('total flux (L/min)');
% grid on

% 后右腿与后左腿的验证
% subplot(2,1,1)
% plot(t,P1*60,'r','Linewidth',2)
% xlabel('time(s)');
% ylabel('后右腿(L/min)');
% grid on
% subplot(2,1,2)
% plot(t,P5*60,'r','Linewidth',2)
% xlabel('time(s)');
% ylabel('后左腿(L/min)');
% grid on

% 各液压缸流量变化
% subplot(4,2,1)
% plot(t,P1*60,'r','Linewidth',2.5)
% xlabel('time(s)','FontSize',12);
% ylabel('后右腿 (L/min)','FontSize',12);
% grid on
% subplot(4,2,2)
% plot(t,P2*60,'r','Linewidth',2.5)
% xlabel('time(s)','FontSize',12);
% ylabel('后右脚 (L/min)','FontSize',12);
% grid on
% subplot(4,2,3)
% plot(t,P3*60,'r','Linewidth',2.5)
% xlabel('time(s)','FontSize',12);
% ylabel('前左腿 (L/min)','FontSize',12);
% grid on
% subplot(4,2,4)
% plot(t,P4*60,'r','Linewidth',2.5)
% xlabel('time(s)','FontSize',12);
% ylabel('前左脚 (L/min)','FontSize',12);
% grid on
% subplot(4,2,5)
% plot(t,P5*60,'r','Linewidth',2.5)
% xlabel('time(s)','FontSize',12);
% ylabel('后左腿 (L/min)','FontSize',12);
% grid on
% subplot(4,2,6)
% plot(t,P6*60,'r','Linewidth',2.5)
% xlabel('time(s)','FontSize',12);
% ylabel('后左脚 (L/min)','FontSize',12);
% grid on
% subplot(4,2,7)
% plot(t,P7*60,'r','Linewidth',2.5)
% xlabel('time(s)','FontSize',12);
% ylabel('前右腿 (L/min)','FontSize',12);
% grid on
% subplot(4,2,8)
% plot(t,P8*60,'r','Linewidth',2.5)
% xlabel('time(s)','FontSize',12);
% ylabel('前右脚 (L/min)','FontSize',12);
% grid on

% 液压缸长度变化
% subplot(2,1,1);
% plot(t,Disp1,'b');
% xlabel('t/s');ylabel('腿液压缸长度(mm)');
% grid on;
% subplot(2,1,2);
% plot(t,Disp2,'r.-');
% xlabel('t/s');ylabel('脚液压缸长度(mm)');
% grid on ;

% 液压缸速度变化
% subplot(4,2,1);
% plot(t,A,'b','Linewidth',2.5);
% xlabel('t(s)','FontSize',12);ylabel('后右腿(mm/s)','FontSize',12);
% grid on;
% subplot(4,2,2);
% plot(t,B,'r','Linewidth',2.5);
% xlabel('t(s)','FontSize',12);ylabel('后右脚(mm/s)','FontSize',12);
% grid on ;
% subplot(4,2,3);
% plot(t,C,'b','Linewidth',2.5);
% xlabel('t(s)','FontSize',12);ylabel('前左腿(mm/s)','FontSize',12);
% grid on;
% subplot(4,2,4);
% plot(t,D,'r','Linewidth',2.5);
% xlabel('t(s)','FontSize',12);ylabel('前左脚(mm/s)','FontSize',12);
% grid on ;
% subplot(4,2,5);
% plot(t,E,'b','Linewidth',2.5);
% xlabel('t(s)','FontSize',12);ylabel('后左腿(mm/s)','FontSize',12);
% grid on;
% subplot(4,2,6);
% plot(t,F,'r','Linewidth',2.5);
% xlabel('t(s)','FontSize',12);ylabel('后左脚(mm/s)','FontSize',12);
% grid on ;
% subplot(4,2,7);
% plot(t,G,'b','Linewidth',2.5);
% xlabel('t(s)','FontSize',12);ylabel('前右腿(mm/s)','FontSize',12);
% grid on;
% subplot(4,2,8);
% plot(t,H,'r','Linewidth',2.5);
% xlabel('t(s)','FontSize',12);ylabel('前右脚(mm/s)','FontSize',12);
% grid on ;

% 角度
% subplot(2,2,1);
% plot(t,q1,'b');
% xlabel('t/s');ylabel('后右腿关节角度/°');
% grid on;
% subplot(2,2,2);
% plot(t,q2,'r.-');
% xlabel('t/s');ylabel('后右脚关节角度/°');
% grid on ;
% subplot(2,2,3);
% plot(t,q3,'b');
% xlabel('t/s');ylabel('后左腿关节角度/°');
% grid on;
% subplot(2,2,4);
% plot(t,q4,'r.-');
% xlabel('t/s');ylabel('后左脚关节角度/°');
% grid on ;

%轨迹曲线
% subplot(2,2,[1 3]);
% plot([Px,Px1],[Pz,Pz1*ones(1,length(t2))],'r-');
% xlabel('水平方向位移/mm');ylabel('竖直方向位移/mm');
% grid on;
% subplot(2,2,2);
% plot(t,[Px,Px1],'r-');
% xlabel('t/s');ylabel('水平方向位移/mm');
% grid on;
% subplot(2,2,4);
% plot(t,[Pz,Pz1*ones(1,length(t2))],'r-');
% xlabel('t/s');ylabel('竖直方向位移/mm');
% grid on; 

%轨迹曲线
% plot([Px,Px1]/1000,[Pz,Pz1*ones(1,length(t2))]/1000+0.86,'r-','Linewidth',2.5);
% xlabel('水平方向位移/m');ylabel('竖直方向位移/m');
% grid on;
% axis([-0.3,0.1,-0.05,0.25])
% % axis equal

%角度代入验证轨迹
% plot(L1*sin(q1*pi/180)+L2*sin((q1+q2)*pi/180),-L1*cos(q1*pi/180)-L2*cos((q1+q2)*pi/180),'r-')