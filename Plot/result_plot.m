function result_plot(Theta,Name,count)

[m,n]=size(Theta);
if m==count||n==12
    figure('Name',Name,'NumberTitle','off');
    Tit=['QY1';'QY2';'QY3';'QZ1';'QZ2';'QZ3';'HY1';'HY2';'HY3';'HZ1';'HZ2';'HZ3'];
    for i=1:n
        subplot(4,3,i);
        plot(Theta(:,i));
        title(Tit(i,:));
    end
elseif n==4
    figure('Name',Name,'NumberTitle','off');
    Tit=['QYLeg';'QZLeg';'HYLeg';'HZLeg'];
    for i=1:n
        subplot(2,2,i);
        plot(Theta(:,i));
        title(Tit(i,:));
    end
    
    
end
