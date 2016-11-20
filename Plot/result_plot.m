function result_plot(varargin)

narginchk(3,4);

if nargin==3
    Theta=varargin{1};
    Name=varargin{2};
    count=varargin{3};
    
    [m,n,ll]=size(Theta);

if (m==count)&&(n==12)

    figure('Name',Name,'NumberTitle','off');
    Tit=['QY1';'QY2';'QY3';'QZ1';'QZ2';'QZ3';'HY1';'HY2';'HY3';'HZ1';'HZ2';'HZ3'];
    for i=1:n
        subplot(4,3,i);     
        for j=1:ll
            if(j>1)
                 hold on;
            end
              plot(Theta(:,i,j)); 
        end
        title(Tit(i,:));
        grid on;
    end
elseif n==4
    figure('Name',Name,'NumberTitle','off');
    Tit=['QYLeg';'QZLeg';'HYLeg';'HZLeg'];
    for i=1:n
        subplot(2,2,i);
        plot(Theta(:,i));
        title(Tit(i,:));
        grid on;
    end
end
    
end



if nargin==4
    gait_period=varargin{1};
    Theta=varargin{2};
    Name=varargin{3};
    count=varargin{4};
    

   time=linspace(0,gait_period,size(Theta,1));
[m,n]=size(Theta);

if (m==count)||(n==12)

    figure('Name',Name,'NumberTitle','off');
    Tit=['QY1';'QY2';'QY3';'QZ1';'QZ2';'QZ3';'HY1';'HY2';'HY3';'HZ1';'HZ2';'HZ3'];
    for i=1:n
        subplot(4,3,i);
        plot(time,Theta(:,i));
        title(Tit(i,:));
        set(gca,'xlim',[0 gait_period]);
        set(gca,'XTick',0:0.5:gait_period);
        grid on;
    end
elseif n==4
    figure('Name',Name,'NumberTitle','off');
    Tit=['QYLeg';'QZLeg';'HYLeg';'HZLeg'];
    for i=1:n
        subplot(2,2,i);
        plot(time,Theta(:,i));
        title(Tit(i,:));
        grid on;
    end
end
end




    
    
end
