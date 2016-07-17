clc
clear
clc
clear
DATA= xlsread('E:\bigdog2014\xtao_7.8\sensor');
Y0=DATA(:,1);
Y1=DATA(:,2);
X1=5;
X0=0;
for i=1:12
K(i)=(Y1(i)-Y0(i))/(X1-X0);
B(i)=Y0(i)-K(i)*X0;
end