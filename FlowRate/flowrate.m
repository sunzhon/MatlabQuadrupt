function [Q1,Q2,Q3]=flowrate(L1,L2,L3,T)
%% ���������ȵ�����
[m,n]=size(L1);
D=0.028;%% ���ȵ�λ m
d=0.020;
step=T/m;%% ʱ�䵥λ s
V1=diff(L1)/step;
V3=diff(L3)/step;
V2=diff(L2)/step;
Q1=zeros(size(V1));
Q2=zeros(size(V2));
Q3=zeros(size(V3));

for i=1:size(V1)
    if(V1(i,1)>0)
        Q1(i,1)=V1(i,1)*pi*D^2/4;
    else
        Q1(i,1)=abs(V1(i,1))*pi*(D^2-d^2)/4;
    end
    
    if(V2(i,1)>0)
        Q2(i,1)=V2(i,1)*pi*D^2/4;
    else
        Q2(i,1)=abs(V2(i,1))*pi*(D^2-d^2)/4;
    end
    
    if(V3(i,1)>0)
        Q3(i,1)=V3(i,1)*pi*D^2/4;
    else
        Q3(i,1)=abs(V3(i,1))*pi*(D^2-d^2)/4;
    end
end
Q1=60000*Q1;%%����λת��Ϊ L/min
Q2=60000*Q2;
Q3=60000*Q3;
end