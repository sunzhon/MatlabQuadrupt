function VMN=craks_tansformation(ValueM)
% The author is suntao
% DATA is 2015/8/7
%This function output data to real sensor value
[count,n]=size(ValueM);
VMN=zeros(count,n);
K=zeros(1,n);
B=zeros(1,n);

DATA= xlsread( [pwd '\CalibrateSensor\LPC2129_sensor']);
Y0=DATA(:,1);
Y1=DATA(:,2);
X1=5;
X0=0;
for i=1:12
K(i)=(Y1(i)-Y0(i))/(X1-X0);
B(i)=Y0(i)-K(i)*X0;
end

for i=1:12
    
VMN(:,i)=uint16(K(i).*ValueM(:,i)+B(i));

end
result_plot(VMN,'LPC2129',count);
end