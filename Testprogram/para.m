clc
clear
X= xlsread('E:\bigdog2014\xtao_7.8\sensor');
X0=X(:,1);
X1=X(:,2);
y1=5;
y0=0;
for i=1:12
k(i)=(y1-y0)/(X1(i)-X0(i));
b(i)=y0-k(i)*X0(i);
K(i)=k(i);
B(i)=b(i);
end