function bigdog_workspace()
count=2000;
theta2_low=-6/180*pi;
theta2_high=59/180*pi;
theta3_low=38/180*pi;
theta3_high=105/180*pi;
theta=zeros(count,3);
works=zeros(count,3);
%theta(:,2)=theta2_low+(theta2_high-theta2_low)*rand(count,1);
%theta(:,3)=theta3_low+(theta3_high-theta3_low)*rand(count,1);
theta(:,2)=linspace(theta2_low,theta2_high,count);
theta(:,3)=linspace(theta3_low,theta3_high,count);
initial=[.150,-.285,.500];

figure('Name',' foot workspace','NumberTitle','on');

[works(:,1),works(:,2),works(:,3)]=motion_solve(theta(:,1),theta(:,2),theta3_low*ones(count,1));
works=works+ones(count,1)*initial;
     plot(works(:,3),works(:,2),'b*');
    hold on;
    [works(:,1),works(:,2),works(:,3)]=motion_solve(theta(:,1),theta(:,2),theta3_high*ones(count,1));
    works=works+ones(count,1)*initial;
     plot(works(:,3),works(:,2),'b*');
    hold on;
      [works(:,1),works(:,2),works(:,3)]=motion_solve(theta(:,1),theta2_high*ones(count,1),theta(:,3));
      works=works+ones(count,1)*initial;
      plot(works(:,3),works(:,2),'b*');
    hold on;
      [works(:,1),works(:,2),works(:,3)]=motion_solve(theta(:,1),theta2_low*ones(count,1),theta(:,3));
      works=works+ones(count,1)*initial;
      plot(works(:,3),works(:,2),'b*');
    grid on;
    xlabel('Px/unit:m');
    ylabel('Py/unit:m');

end