function re=save_data(Theta,Length,Value,QuantityFlow,count,gait_period,simulation_circle)
[m,n,j]=size(Theta);
if (m~=count)||(n~=3)||(j~=4)
    re=0;
    return ;
end
T=gait_period;
step=T/count;
Time=0:step:T*simulation_circle-step;
time=Time';
ThetaM=[Theta(:,1,1),Theta(:,2,1),Theta(:,3,1),Theta(:,1,2),Theta(:,2,2),Theta(:,3,2),Theta(:,1,3),Theta(:,2,3),Theta(:,3,3),Theta(:,1,4),Theta(:,2,4),Theta(:,3,4)];
LengthM=[Length(:,1,1),Length(:,2,1),Length(:,3,1),Length(:,1,2),Length(:,2,2),Length(:,3,2),Length(:,1,3),Length(:,2,3),Length(:,3,3),Length(:,1,4),Length(:,2,4),Length(:,3,4)];
ValueM=[Value(:,1,1),Value(:,2,1),Value(:,3,1),Value(:,1,2),Value(:,2,2),Value(:,3,2),Value(:,1,3),Value(:,2,3),Value(:,3,3),Value(:,1,4),Value(:,2,4),Value(:,3,4)];
%% ģʽѡ��
%
% switch simulation_mode
%     case 1
%         %% subtract the first lines/row
%         % ������������ʱ�ķ�������
%         initial=ThetaM(1,:);
%         for i=1:count
%             ThetaM(i,:)=ThetaM(i,:)-initial;
%         end
%         disp('Warming !! No produce physical control data');
%     case 2
%% ʵ�����ʱ�ĳ�ʼλ��theta ��
% ʵ�������ĳ�ʼλ�þ��ǰ���ʵ�������ĳ�ʼ�����ռ�λ�ü���õ��ġ�������Ҫ���г�ʼλ��ת����������������ʼλ�õ�ģ�ͽǶȶ�λ��ȡ�
%         initial=ThetaM(1,:);
%         for i=1:count
%             ThetaM(i,:)=ThetaM(i,:)-initial;
%         end
%         initial2=[0,0.115,0.04051,0,-0.09475,-0.007522,0,0.115,0.04053,0,-0.09476,-0.007539];
%         for i=1:count
%             ThetaM(i,:)=ThetaM(i,:)+initial2;
%         end
%% plot the output value
result_plot(ThetaM,'Theta',count);
result_plot(LengthM,'Length',count);
result_plot(ValueM,'Value',count);
result_plot(QuantityFlow,'QuantityFlow',count)

%% Theta -save data to  single joint file
path=[pwd '\data\Adams\ThetaQY1.txt';pwd '\data\Adams\ThetaQY2.txt';pwd '\data\Adams\ThetaQY3.txt';pwd '\data\Adams\ThetaQZ1.txt';pwd '\data\Adams\ThetaQZ2.txt';pwd '\data\Adams\ThetaQZ3.txt';pwd '\data\Adams\ThetaHY1.txt';pwd '\data\Adams\ThetaHY2.txt';pwd '\data\Adams\ThetaHY3.txt';pwd '\data\Adams\ThetaHZ1.txt';pwd '\data\Adams\ThetaHZ2.txt';pwd '\data\Adams\ThetaHZ3.txt'];
path_notime_data=[pwd '\data\Theta_notimedata.txt'];
fd=zeros(12,1);
if simulation_circle==1
    L_ThetaM=ThetaM;
elseif simulation_circle>1
    L_ThetaM=ThetaM;
    for k=1:simulation_circle-1 %simulation cicule
        L_ThetaM=[L_ThetaM; ThetaM];
    end
end
for i=1:12
    TEST=[time(:,1),L_ThetaM(:,i)];
    fd(i)=fopen(path(i,:),'w');
    for j=1:count*simulation_circle
        fprintf(fd(i),'%f\t%f\n',TEST(j,1),TEST(j,2));
    end
    fclose(fd(i));
end
% no time
fd=fopen(path_notime_data,'w');
for j=1:size(L_ThetaM)
    for i=1:12
        fprintf(fd,'%f\t',L_ThetaM(j,i));
    end
    fprintf(fd,'\n');
end
fclose(fd);

%%  Length -save date to single file
path=[pwd '\data\\Adams\LengthQY1.txt';pwd '\data\\Adams\LengthQY2.txt';pwd '\data\\Adams\LengthQY3.txt';pwd '\data\\Adams\LengthQZ1.txt';pwd '\data\\Adams\LengthQZ2.txt';pwd '\data\\Adams\LengthQZ3.txt';pwd '\data\\Adams\LengthHY1.txt';pwd '\data\\Adams\LengthHY2.txt';pwd '\data\\Adams\LengthHY3.txt';pwd '\data\\Adams\LengthHZ1.txt';pwd '\data\\Adams\LengthHZ2.txt';pwd '\data\\Adams\LengthHZ3.txt'];
path_notime_data=[pwd '\data\Length_notimedata.txt'];
fd=zeros(12,1);
if simulation_circle==1
    L_LengthM=LengthM;
elseif simulation_circle>1;
    L_LengthM=LengthM;
    for k=1:simulation_circle-1 %simulation cicule
        L_LengthM=[L_LengthM; LengthM];
    end
end
for i=1:12
    TEST=[time(:,1),L_LengthM(:,i)];
    
    fd(i)=fopen(path(i,:),'w');
    for j=1:count*simulation_circle
        fprintf(fd(i),'%f\t%f\n',TEST(j,1),TEST(j,2));
    end
    fclose(fd(i));
end
% no time
fd=fopen(path_notime_data,'w');
for j=1:size(L_LengthM)
    for i=1:12
        fprintf(fd,'%f\t',L_LengthM(j,i));
    end
    fprintf(fd,'\n');
end
fclose(fd);

%%  QuantityFlow  -save date to single file
path=[pwd '\data\QuantityFlow\QY.txt';pwd '\data\QuantityFlow\QZ.txt';pwd '\data\QuantityFlow\HY.txt';pwd '\data\QuantityFlow\HZ.txt'];
path_notime_data=[pwd '\data\QuantityFlow\Sum_QuantityFlow_notimedata.txt'];
fd=zeros(4,1);
QuantityFlow=[[0,0,0,0];QuantityFlow];
if simulation_circle==1
    L_QuantityFlow=QuantityFlow;
elseif simulation_circle>1;
    L_QuantityFlow=QuantityFlow;
    for k=1:simulation_circle-1 %simulation cicule
        L_QuantityFlow=[L_QuantityFlow; QuantityFlow];
    end
end
for i=1:4
    TEST=[time(:,1),L_QuantityFlow(:,i)];
    
    fd(i)=fopen(path(i,:),'w');
    for j=1:count*simulation_circle
        fprintf(fd(i),'%f\t%f\n',TEST(j,1),TEST(j,2));
    end
    fclose(fd(i));
end

% Sum quantityFlow
fd=fopen(path_notime_data,'w');
Sum_L_QuantityFlow=L_QuantityFlow(:,1)+L_QuantityFlow(:,2)+L_QuantityFlow(:,3)+L_QuantityFlow(:,4);
TEST=[time,Sum_L_QuantityFlow];

for j=1:size(Sum_L_QuantityFlow)
    fprintf(fd,'%f\t%f\t',TEST(j,1),TEST(j,2));
    fprintf(fd,'\n');
end
fclose(fd);

try
    %% save theta data to excel file
    mode_data=[pwd '\data\Theta_mode_gait_dig.xls'];%pwd acquire current path
    %to decide Excel is open or not��if on��just to do in this Excel documention��
    %if off,open Excel
    fd=fopen(mode_data,'r+');
    if fd>0
        fclose(fd);
        delete(mode_data);
        xlswrite(mode_data,ThetaM);
    else
        xlswrite(mode_data,ThetaM);
    end
catch
    Excel = actxserver(mode_data);
end
%% save 0-5 ȥ Pc104

physi_data=[pwd '\data\PC104\QY.txt';pwd '\data\PC104\QZ.txt';pwd '\data\PC104\HY.txt';pwd '\data\PC104\HZ.txt'];
for i=1:4
    fd=fopen(physi_data(i,:),'w+');
    for j=1:count
        fprintf(fd,'%f\t%f\t%f\n',ValueM(j,3*i-2),ValueM(j,3*i-1),ValueM(j,3*i));
    end
end
%% This function calculate value to LPC2129 contorl board,if you do not want to do this ,This means the value
%%just adapt to semi-physical simulation and virtual simulation.
ADValueM=craks_tansformation(ValueM);% output real value to object

physi_data=[pwd '\data\LPC2129\QY.txt';pwd '\data\LPC2129\QZ.txt';pwd '\data\LPC2129\HY.txt';pwd '\data\LPC2129\HZ.txt'];
for i=1:4
    fd=fopen(physi_data(i,:),'w+');
    for j=1:count
        fprintf(fd,'%f\t%f\t%f\n',ADValueM(j,3*i-2),ADValueM(j,3*i-1),ADValueM(j,3*i));
    end
end
re=1;

end