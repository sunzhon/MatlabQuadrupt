clear all;clc
g=9.8;h=0.86;D=0.6;L1=0.357;L2=0.605;
T=1;alpha=0.1;N=1000;beta=0.5;
t00=T*beta;t300=t00/5;t301=t00-t300;t=T/N:T/N:T; %t00-摆动相；t301-四次曲线；t300-三次曲线
t42=T/N:T/N:t301;t43=(t301+T/N):T/N:t00; %t42、t43 分别表示摆动相中四次曲线和三次曲线的过程
t2=t00+T/N:T/N:T; % 表示支撑相过程
xzmp0=0;S=D/2;H=0.2;S1=S;
Zm0=0;Xm0=0;R=0.014;r=0.01;
Xf=3/5*S;Zf=2/5*H;
tc=1/2*t00;Xc=1/5*S;Zc=H;
% Xe=-S/20;Ze=H/10;

set(0,'defaultfigurecolor','w')

% 样条函数可视化
% fnplt(pp_Pxm,'b-')
% hold on
% fnplt(dpp_Pxm,'m:')

% 支撑相线段
xm5=S+Xm0-S*((t2-t00)/(T-t00)-1/(2*pi)*sin(2*pi*(t2-t00)/(T-t00)));
zm5=Zm0;

% 四次曲线段
O2=[     S1,        0,          0,         0,          0,          0,          0,            0,            0,              0;
         0,         0,         0,          0,          0,           H,          0,           0,            0,              0;
         S1,   S1*t301,  S1*t301^2, S1*t301^3,   S1*t301^4,         0,          0,           0,            0,              0;
         0,        0,            0,        0,          0,           H,     H*t301,     H*t301^2,       H*t301^3,        H*t301^4;    
         S1,     S1*tc,      S1*tc^2,   S1*tc^3,   S1*tc^4,         0,          0,           0,            0,              0;
         0,        0,            0,        0,          0,           H,        H*tc,        H*tc^2,     H*tc^3,          H*tc^4; 
         0,         0,          0,         0,          0,           0,          H,      2*H*tc,       3*H*tc^2,        4*H*tc^3;
         0,         0,          0,         0,          0,           0,          H,           0,            0,              0;
         0,        S1,          0,         0,         0,            0,          0,           0,            0,              0;
         0,        S1,    2*S1*t301, 3*S1*t301^2,  4*S1*t301^3,     0,          0,           0,            0,              0 ];
P2=[0,0,Xf+S1,Zf,Xc+S1,Zc,0,0,0,0]';
Q2=inv(O2)*P2;
c10=Q2(1);
c11=Q2(2);
c12=Q2(3);
c13=Q2(4);
c14=Q2(5);
c20=Q2(6);
c21=Q2(7);
c22=Q2(8);
c23=Q2(9);
c24=Q2(10);
xm42=Xm0+S1*(c10+c11*t42+c12*t42.^2+c13*t42.^3+c14*t42.^4);
zm42=Zm0+H*(c20+c21*t42+c22*t42.^2+c23*t42.^3+c24*t42.^4);

% 三次曲线段
O3=[     S1,        0,         0,        0,         0,        0,            0,              0;
         0,         0,         0,        0,         H,         0,            0,              0;
         S1,  S1*t300,  S1*t300^2, S1*t300^3,       0,         0,            0,              0;
         0,        0,            0,      0,          H,    H*t300,     H*t300^2,       H*t300^3;    
         0,       S1,   2*S1*t300, 3*S1*t300^2,      0,        0,            0,              0; 
         0,         0,          0,         0,         0,         H,    2*H*t300,       3*H*t300^2;
          0,        S1,         0,         0,         0,        0,            0,              0;
          0,        0,          0,         0,         0,        H,            0,              0 ];
P3=[Xf+S1,Zf,S1,0,0,0,0,H*(c21+2*c22*t301+3*c23*t301^2+4*c24*t301^3)]';
Q3=inv(O3)*P3;
d10=Q3(1);
d11=Q3(2);
d12=Q3(3);
d13=Q3(4);
d20=Q3(5);
d21=Q3(6);
d22=Q3(7);
d23=Q3(8);
xm43=Xm0+S1*(d10+d11*(t43-t301)+d12*(t43-t301).^2+d13*(t43-t301).^3);
zm43=Zm0+H*(d20+d21*(t43-t301)+d22*(t43-t301).^2+d23*(t43-t301).^3);

% xm43=Xm0+S1-(S1*(b20+b21*(t00-t43)+b22*(t00-t43).^2+b23*(t00-t43).^3));
% zm43=Zm0+H*(b10+b11*(t00-t43)+b12*(t00-t43).^2+b13*(t00-t43).^3);
xm4=[xm42,xm43];zm4=[zm42,zm43];
Xm=[xm4,xm5];Zm=[zm4,zm5*ones(1,length(t2))];

pp_Xm=spline(t,Xm);
dpp_Xm=fnder(pp_Xm);
pp_Zm=spline(t,Zm);
dpp_Zm=fnder(pp_Zm);

Velo_zm4=[diff(zm4),zm4(1)-zm4(end)]/(T/N);% 摆动相z方向速度
% plot([t41,t42,t43],Velo_zm4)
% grid on

Velo_Xm=[diff(Xm),Xm(1)-Xm(end)]/(T/N);
Velo_Zm=[diff(Zm),Zm(1)-Zm(end)]/(T/N);

% 计算流量
M=xm4.^2+(zm4-h).^2-L1^2-L2^2;
Q2=-acos(M/(2*L1*L2));
K11=(L2*xm4.*sin(Q2)-(zm4-h).*(L1+L2*cos(Q2)))./(L1^2+L2^2+2*L1*L2*cos(Q2));
Q1=acos(K11);
M1=xm5.^2+(zm5-h)^2-L1^2-L2^2;
Q22=-acos(M1/(2*L1*L2));
K21=(L2*xm5.*sin(Q22)-(zm5-h)*(L1+L2*cos(Q22)))./(L1^2+L2^2+2*L1*L2*cos(Q22));
Q11=acos(K21);

Q4=acos(M/(2*L1*L2));
K12=(L2*xm4.*sin(Q4)-(zm4-h).*(L1+L2*cos(Q4)))./(L1^2+L2^2+2*L1*L2*cos(Q4));
Q3=-acos(K12);
M2=xm5.^2+(zm5-h)^2-L1^2-L2^2;
Q44=acos(M2/(2*L1*L2));
K22=(L2*xm5.*sin(Q44)-(zm5-h)*(L1+L2*cos(Q44)))./(L1^2+L2^2+2*L1*L2*cos(Q44));
Q33=-acos(K22);
q1=[Q1,Q11]*180/pi;q2=[Q2,Q22]*180/pi;q3=[Q3,Q33]*180/pi;q4=[Q4,Q44]*180/pi;

Lag=0.220;Laf=0.97;
Lbh=0.110;Lbe=0.260; %%% 长度赋值 
% Lbh=10;Lbe=205;
Disp1=sqrt(Laf^2+Lag^2-2*Laf*Lag*cos((110.2-abs(q1))*pi/180))-0.216;
Disp2=sqrt(Lbe^2+Lbh^2-2*Lbe*Lbh*cos((139.41-abs(q2))*pi/180))-0.268;
% Disp2=sqrt(260^2+110^2-2*260*110*cos((137.41-abs(q2))*pi/180))-268;
Disp3=sqrt(Laf^2+Lag^2-2*Laf*Lag*cos((110.2-abs(q3))*pi/180))-0.216;
Disp4=sqrt(Lbe^2+Lbh^2-2*Lbe*Lbh*cos((139.41-abs(q4))*pi/180))-0.268;
% Disp4=sqrt(260^2+110^2-2*260*110*cos((137.41-abs(q4))*pi/180))-268;
Velo1=[diff(Disp1),Disp1(1)-Disp1(end)]/(T/N);
Velo2=[diff(Disp2),Disp2(1)-Disp2(end)]/(T/N);
Velo3=[diff(Disp3),Disp3(1)-Disp3(end)]/(T/N);
Velo4=[diff(Disp4),Disp4(1)-Disp4(end)]/(T/N);
A=Velo1;%后右腿
B=Velo2;%后右脚
C=Velo3;%前左腿
D=Velo4;%前左脚
E=circshift(A,[0,length(t)/2]);%后左腿
F=circshift(B,[0,length(t)/2]);%后左脚
G=circshift(C,[0,length(t)/2]);%前右腿
H=circshift(D,[0,length(t)/2]);%前右脚

for i=1:N
    if A(i)>=0
        a1(i)=A(i);
        a2(i)=0;
    else
        a1(i)=0;
        a2(i)=A(i);
    end
end
for i=1:N
    if B(i)>=0
        b1(i)=B(i);
        b2(i)=0;
    else
        b1(i)=0;
        b2(i)=B(i);
    end
end
for i=1:N
    if C(i)>=0
        c1(i)=C(i);
        c2(i)=0;
    else
        c1(i)=0;
        c2(i)=C(i);
    end
end
for i=1:N
    if D(i)>=0
        d1(i)=D(i);
        d2(i)=0;
    else
        d1(i)=0;
        d2(i)=D(i);
    end
end
P1=a1*pi*R^2*1000+abs(a2*pi*(R^2-r^2)*1000);%后右腿
P2=b1*pi*R^2*1000+abs(b2*pi*(R^2-r^2)*1000);%后右脚
P3=c1*pi*R^2*1000+abs(c2*pi*(R^2-r^2)*1000);%前左腿
P4=d1*pi*R^2*1000+abs(d2*pi*(R^2-r^2)*1000);%前左脚
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
% plot(t,Flux*60,'r','Linewidth',2)
% xlabel('time(s)');
% ylabel('总流量 (L/min)');
% grid on

%总流量和平均流量(起步阶段没有规划)
plot(t,Flux,'r','Linewidth',2.5)
hold on
plot(t,Fmean*ones(1,length(t)),'--b','Linewidth',2.5)
xlabel('time (s)','FontSize',12);
ylabel('总流量(L/min)','FontSize',12);
grid on
legend('总流量曲线','平均流量')

% plot(t,Velo_Xm)
% hold on
% plot(t,Velo_Zm)


% 样条函数可视化
% fnplt(pp_Xm,'b-')
% hold on
% fnplt(dpp_Xm,'m:')
% fnplt(pp_Zm,'r-')
% fnplt(dpp_Zm,'r:')
% hold off 
% legend('Xm','X''_m','Zm','Z''_m')

% 合轨迹水平、竖直方向轨迹
% plot(t,Xm,'r','LineWidth',2.5)
% hold on
% plot(t,Zm,'b','LineWidth',2.5)
% hold off
% grid on

% 合轨迹水平、竖直方向轨迹
% subplot(2,1,1)
% plot([t,T+t(1:length(t)/2)],[Xm,Xm(1:length(t)/2)],'r','LineWidth',2.5)
% grid on
% % axis([0,3/2*T,-0.05,0.4])
% set(gca,'Xtick',[0,1/2*T,T,3/2*T])
% set(gca,'XtickLabel',{'0';'1/2*T';'T';'3/2*T'})
% xlabel('\fontname{arial}\fontsize{14}t')
% ylabel('\fontname{arial}\fontsize{14}水平位移(m)')
% subplot(2,1,2)
% plot([t,T+t(1:length(t)/2)],[Zm,Zm(1:length(t)/2)],'b','LineWidth',2.5)
% grid on
% % axis([0,3/2*T,-0.01,0.09])
% set(gca,'Xtick',[0,1/2*T,T,3/2*T])
% set(gca,'XtickLabel',{'0';'1/2*T';'T';'3/2*T'})
% xlabel('\fontsize{14}t')
% ylabel('\fontsize{14}竖直位移(m)')

% 合轨迹水平、竖直方向速度
% subplot(2,1,1)
% plot([t,T+t(1:length(t)/2)],[Velo_Xm,Velo_Xm(1:length(t)/2)],'r','LineWidth',2.5)
% grid on
% % axis([0,3/2*T,-1.0,2.5])
% set(gca,'Xtick',[0,1/2*T,T,3/2*T])
% set(gca,'XtickLabel',{'0';'1/2*T';'T';'3/2*T'})
% xlabel('\fontname{arial}\fontsize{14}t')
% ylabel('\fontname{arial}\fontsize{14}水平速度(m/s)')
% subplot(2,1,2)
% plot([t,T+t(1:length(t)/2)],[Velo_Zm,Velo_Zm(1:length(t)/2)],'b','LineWidth',2.5)
% grid on
% % axis([0,3/2*T,-0.7,0.7])
% set(gca,'Xtick',[0,1/2*T,T,3/2*T])
% set(gca,'XtickLabel',{'0';'1/2*T';'T';'3/2*T'})
% xlabel('\fontsize{14}t')
% ylabel('\fontsize{14}竖直速度(m/s)')

% 合轨迹
% plot(Xm,Zm,'-r','LineWidth',2.5)
% axis([-0.1,0.6,-0.05,0.25])
% % axis equal
% % grid on
% xlabel('\fontsize{14}水平位移(m)')
% ylabel('\fontsize{14}竖直位移(m)')

% 摆动相水平、竖直方向轨迹
% plot([t31,t32,t33],zm4,'r','LineWidth',2)
% hold on
% plot([t31,t32,t33],xm4,'b','LineWidth',2)

% 摆动相轨迹_四次曲线
% plot(xm42,zm42,'-r','LineWidth',2.5)
% % axis([-0.05,0.7,-0.05,0.15])
% axis equal
% grid on
% xlabel('\fontsize{14}水平位移(m)')
% ylabel('\fontsize{14}竖直位移(m)')

% 摆动相水平、竖直轨迹_四次曲线
% subplot(2,1,1)
% plot(t42,xm42,'-r','LineWidth',2.5)
% xlabel('\fontsize{14}t(s)')
% ylabel('\fontsize{14}水平位移(m)')
% grid on
% subplot(2,1,2)
% plot(t42,zm42,'-r','LineWidth',2.5)
% xlabel('\fontsize{14}t(s)')
% ylabel('\fontsize{14}竖直位移(m)')
% grid on

% Xm
% plot(t,Xm,'-r')
% hold on


