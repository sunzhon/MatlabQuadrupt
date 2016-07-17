function [L1,Lfg,Leh]=Cylinder_Elongation(theta1,theta2,theta3)
%% The author is suntao
% DATA is 2015/7/15
%theta取值范围
%% 已下参数的含义参考李志论文第18页，以下注释的变量没有使用。
    
    Laf=97;
    %Lab=357;
    %Lae=154;
    Lbe=260;
    Lbh=110;
    %Lfm=37;
    %Lbc=540;
    %Lnh=30;
    Lag=220;
    %Lbg=137;
    L1ao=100;
    L1oc=286;
    
    gamma1=22.35/180*pi;
    gamma2=2.16/180*pi;
    gamma3=22.64/180*pi;
    gamma4=17.95/180*pi;
    gamma=70.71/180*pi+theta1;
    alpha=abs(gamma1+pi/2-gamma2-theta2);
    beta=abs(pi-gamma3-gamma4-theta3);
    % we should have the constrained of 158<temp1<250; 198<temp2<299
    temp1=sqrt(L1ao^2+L1oc^2-cos(gamma)*(2*L1ao*L1oc));%%temp1 is the length of Lac.
    temp2=sqrt(Laf^2+Lag^2-cos(alpha)*(2*Laf*Lag));
    temp3=sqrt(Lbe^2+Lbh^2-cos(beta)*(2*Lbe*Lbh));
    
    if (max(temp1)<=300)&&(min(temp1)>=235)&&(min(temp2)>=180)&&(max(temp2)<=255)&&(min(temp3)>=198)&&(max(temp3)<=330)
        L1=temp1;
        Lfg=temp2;
        Leh=temp3;
    else
       error('input parameter error');
    end
end
    

