
function [v1,v2,v3]=Voltage_Value(L1,Lfg,Leh)
% The author is suntao
% DATA is 2015/7/15
%将液压缸所在杆件的长度转化为液压刚的控制信号，伺服阀控制板的电压值。
%三个刚的最大生产量分别是100，80，100，控制新号的取值范围是0—5；
%这里假设伺服阀的伸长量和电压值成正比，不是增量式控制。

L1_min=200;%这个参数有待验证,髋关节
L1_max=300;%这个参数有待验证，髋关节
Lfg_min=180;%原来185                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
Lfg_max=255;%原来去250
Leh_min=200;
Leh_max=330;
%if (Lfg>Lfg_min)&&(Lfg<Lfg_max)&&(Leh>Leh_min)&&(Leh<Leh_max)&&(L1>=L1_min)&&(L1<=L1_max)
    %液压缸伸长量
    v1=L1*5.0/(L1_max-L1_min)-5*L1_min/(L1_max-L1_min);
    v2=Lfg*5.0/(Lfg_max-Lfg_min)-5*Lfg_min/(Lfg_max-Lfg_min);
    v3=Leh*5.0/(Leh_max-Leh_min)-5*Leh_min/(Leh_max-Leh_min);
%else
%    error('input parameter error,which are out of range');
end