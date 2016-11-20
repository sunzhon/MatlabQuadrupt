function re=save_data(Theta,Length,Value,QuantityFlow,count,gait_period,simulation_circle)
[m,n]=size(Theta);
if (m~=count)||(n~=12)
    re=0;
    return ;
end

%% 模式选者
%
% switch simulation_mode
%     case 1
%         %% subtract the first lines/row
%         % 虚拟样机仿真时的仿真数据
%         initial=ThetaM(1,:);
%         for i=1:count
%             ThetaM(i,:)=ThetaM(i,:)-initial;
%         end
%         disp('Warming !! No produce physical control data');
%     case 2
%% 实物控制时的初始位置theta 角
% 实物样机的初始位置就是按照实物样机的初始工作空间位置计算得到的。，不需要进行初始位置转换，虚拟样机将初始位置的模型角度定位零度。
%         initial=ThetaM(1,:);
%         for i=1:count
%             ThetaM(i,:)=ThetaM(i,:)-initial;
%         end
%         initial2=[0,0.115,0.04051,0,-0.09475,-0.007522,0,0.115,0.04053,0,-0.09476,-0.007539];
%         for i=1:count
%             ThetaM(i,:)=ThetaM(i,:)+initial2;
%         end


%% Theta -save data to ADAMS single joint file
path=[pwd '\data\Adams\ThetaQY1.txt';pwd '\data\Adams\ThetaQY2.txt';pwd '\data\Adams\ThetaQY3.txt';pwd '\data\Adams\ThetaQZ1.txt';pwd '\data\Adams\ThetaQZ2.txt';pwd '\data\Adams\ThetaQZ3.txt';pwd '\data\Adams\ThetaHY1.txt';pwd '\data\Adams\ThetaHY2.txt';pwd '\data\Adams\ThetaHY3.txt';pwd '\data\Adams\ThetaHZ1.txt';pwd '\data\Adams\ThetaHZ2.txt';pwd '\data\Adams\ThetaHZ3.txt'];
path_notime_data=[pwd '\data\Theta_notimedata.txt'];
Theta=adams_initial(Theta);

%*-store data
for i=1:size(Theta,2)
    fd=fopen(path(i,:),'w');
    for k=1:simulation_circle
        str=gait_period*(k-1);
        if(k>1)
            time=(linspace(str+gait_period/size(Theta,1),str+gait_period,size(Theta,1)))';
        else
            time=(linspace(str,str+gait_period,size(Theta,1)))';
        end
        TEST=[time(:,1),Theta(:,i)];
        for j=1:size(Theta,1)
            fprintf(fd,'%f\t%f\n',TEST(j,1),TEST(j,2));
        end
    end
    fclose(fd);
end

% no time,have 12 column
fd=fopen(path_notime_data,'w');
for j=1:size(Theta,1)
    for i=1:size(Theta,2)
        fprintf(fd,'%f\t',Theta(j,i));
    end
    fprintf(fd,'\n');
end
fclose(fd);

%%  Length -save date to single file
path=[pwd '\data\Adams\LengthQY1.txt';pwd '\data\Adams\LengthQY2.txt';pwd '\data\Adams\LengthQY3.txt';pwd '\data\Adams\LengthQZ1.txt';pwd '\data\Adams\LengthQZ2.txt';pwd '\data\Adams\LengthQZ3.txt';pwd '\data\Adams\LengthHY1.txt';pwd '\data\Adams\LengthHY2.txt';pwd '\data\Adams\LengthHY3.txt';pwd '\data\Adams\LengthHZ1.txt';pwd '\data\Adams\LengthHZ2.txt';pwd '\data\Adams\LengthHZ3.txt'];
path_notime_data=[pwd '\data\Adams\Length_notimedata.txt'];
Length=1000*Length;% 将长度单位米转化为毫米用于ADAMs 仿真
Length=adams_initial(Length);

%*- store data
for i=1:size(Length,2)
    fd=fopen(path(i,:),'w');
    for k=1:simulation_circle
        str=gait_period*(k-1);
        if(k>1)
            time=(linspace(str+gait_period/size(Theta,1),str+gait_period,size(Theta,1)))';
        else
            time=(linspace(str,str+gait_period,size(Theta,1)))';
        end
        TEST=[time(:,1),Length(:,i)];
        for j=1:size(Length,1)
            fprintf(fd,'%f\t%f\n',TEST(j,1),TEST(j,2));
        end
    end
    fclose(fd);
end

% no time,and 12 colunm
fd=fopen(path_notime_data,'w');
for j=1:size(Length,1)
    for i=1:size(Length,2)
        fprintf(fd,'%f\t',Length(j,i));
    end
    fprintf(fd,'\n');
end
fclose(fd);

%%  QuantityFlow  -save date to single file
path=[pwd '\data\Hydraumatic\HydraQY1.txt';pwd '\data\Hydraumatic\HydraQY2.txt';pwd '\data\Hydraumatic\HydraQY3.txt';pwd '\data\Hydraumatic\HydraQZ1.txt';pwd '\data\Hydraumatic\HydraQZ2.txt';pwd '\data\Hydraumatic\HydraQZ3.txt';pwd '\data\Hydraumatic\HydraHY1.txt';pwd '\data\Hydraumatic\HydraHY2.txt';pwd '\data\Hydraumatic\HydraHY3.txt';pwd '\data\Hydraumatic\HydraHZ1.txt';pwd '\data\Hydraumatic\HydraHZ2.txt';pwd '\data\Hydraumatic\HydraHZ3.txt'];
path_notime_data=[pwd '\data\Hydraumatic\Sum_QuantityFlow_notimedata.txt'];

for i=1:size(QuantityFlow,2)
    TEST=[time(1:size(time,1)-1,1),QuantityFlow(:,i)];
    fd=fopen(path(i,:),'w');
    for j=1:size(QuantityFlow,2)
        fprintf(fd,'%f\t%f\n',TEST(j,1),TEST(j,2));
    end
    fclose(fd);
end
% no time,have 12 column
fd=fopen(path_notime_data,'w');
for j=1:size(QuantityFlow,1)
    for i=1:size(QuantityFlow,2)
        fprintf(fd,'%f\t',QuantityFlow(j,i));
    end
    fprintf(fd,'\n');
end
fclose(fd);

try
    %% save theta data to excel file
    mode_data=[pwd '\data\Theta_mode_gait_dig.xls'];%pwd acquire current path
    %to decide Excel is open or not，if on，just to do in this Excel documention，
    %if off,open Excel
    fd=fopen(mode_data,'r+');
    if fd>0
        fclose(fd);
        delete(mode_data);
        xlswrite(mode_data,Theta);
    else
        xlswrite(mode_data,Theta);
    end
catch
    Excel = actxserver(mode_data);
end
%% save 0-5 去 Pc104

physi_data=[pwd '\data\PC104\5Value_QY.txt';pwd '\data\PC104\5Value_QZ.txt';pwd '\data\PC104\5Value_HY.txt';pwd '\data\PC104\5Value_HZ.txt'];
%{
Value(:,1)=2.2*ones(count,1);%initial phsical prototype the first joints
Value(:,4)=2.2*ones(count,1);
Value(:,7)=2.2*ones(count,1);
Value(:,10)=2.1*ones(count,1);
%}

for i=1:size(Value,2)/3
    fd=fopen(physi_data(i,:),'w+');
    for j=1:size(Value,1)
        fprintf(fd,'%f\t%f\t%f\n',Value(j,3*i-2),Value(j,3*i-1),Value(j,3*i));
    end
    fclose(fd);
end
%% This function calculate value to LPC2129 contorl board,if you do not want to do this ,This means the value
%%just adapt to semi-physical simulation and virtual simulation.
ADValueM=craks_tansformation(Value);% output real value to object

physi_data=[pwd '\data\LPC2129\QY.txt';pwd '\data\LPC2129\QZ.txt';pwd '\data\LPC2129\HY.txt';pwd '\data\LPC2129\HZ.txt'];
for i=1:size(ADValueM,2)/3
    fd=fopen(physi_data(i,:),'w+');
    for j=1:size(ADValueM,1)
        fprintf(fd,'%f\t%f\t%f\n',ADValueM(j,3*i-2),ADValueM(j,3*i-1),ADValueM(j,3*i));
    end
    fclose(fd);
end
re=1;

end