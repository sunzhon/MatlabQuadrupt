
function [v1,v2,v3]=Voltage_Value(L1,Lfg,Leh)
% The author is suntao
% DATA is 2015/7/15
%��Һѹ�����ڸ˼��ĳ���ת��ΪҺѹ�յĿ����źţ��ŷ������ư�ĵ�ѹֵ��
%�����յ�����������ֱ���100��80��100�������ºŵ�ȡֵ��Χ��0��5��
%��������ŷ������쳤���͵�ѹֵ�����ȣ���������ʽ���ơ�

L1_min=200;%��������д���֤,�Źؽ�
L1_max=300;%��������д���֤���Źؽ�
Lfg_min=180;%ԭ��185                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
Lfg_max=255;%ԭ��ȥ250
Leh_min=200;
Leh_max=330;
%if (Lfg>Lfg_min)&&(Lfg<Lfg_max)&&(Leh>Leh_min)&&(Leh<Leh_max)&&(L1>=L1_min)&&(L1<=L1_max)
    %Һѹ���쳤��
    v1=L1*5.0/(L1_max-L1_min)-5*L1_min/(L1_max-L1_min);
    v2=Lfg*5.0/(Lfg_max-Lfg_min)-5*Lfg_min/(Lfg_max-Lfg_min);
    v3=Leh*5.0/(Leh_max-Leh_min)-5*Leh_min/(Leh_max-Leh_min);
%else
%    error('input parameter error,which are out of range');
end