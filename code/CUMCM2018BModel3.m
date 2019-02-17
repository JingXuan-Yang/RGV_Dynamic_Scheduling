%   �ű����ܣ�
%   ����RGV��̬���ȣ�һ������,1%���ʻ������ϣ�
%
%   ����������
%
%
%   Ƕ�׺�������
%
%   ���ߣ��ޏ���
%
%   �汾��1.0
%
%   �ϴ��޸�ʱ�䣺
%
%   �ϴ��޸���ʷ��

%   ��ʼ��MATLAB
clear
clc

%   ���ݳ�ʼ��
tm1 = 20;                       %   RGV�ƶ�1����λʱ��
tm2 = 33;                       %   RGV�ƶ�2����λʱ��
tm3 = 46;                       %   RGV�ƶ�3����λʱ��
tcnc = 560;                     %   CNC�ӹ����һ������ʱ��
trwo = 28;                      %   RGVΪ����CNC������ʱ��
trwe = 31;                      %   RGVΪż��CNC������ʱ��
tclr = 25;                      %   RGV��ϴ����ʱ��
Twork = 28800;                  %   �ܹ���ʱ��
CNCnum = 8;                     %   CNC������
t = 0;                          %   ʱ���ʼ��
Pos = 1;                        %   λ�ó�ʼ��
CNCw = zeros(1, CNCnum);        %   CNC����״̬��־
Trgvm = zeros(1, CNCnum);       %   RGV�ƶ�ʱ�����
Trgvw = zeros(1, CNCnum);       %   RGV����ʱ�����
Tcncw = zeros(1, CNCnum);       %   CNC����ʱ�����
Ttotal = zeros(1, CNCnum);      %   ��ʱ�����
paw = 0;                        %   ��еצ���Ƿ�������
Tclear = 100000;                %   ��ϴʣ��ʱ��
tmin = 10000;                   %   ѭ����������ʾ��ǰ������е����ʱ��
minPos = -1;                    %   ѭ����������ʾ��ǰ����̨��������
count = zeros(1, CNCnum);       %   ����ÿ̨���������ϵ���Ŀ
starttime = zeros(100, CNCnum); %   ÿ̨������������Ӧ��ʱ��
endtime = zeros(100, CNCnum);   %   ÿ̨�������϶�Ӧʱ��
sortTtotal = zeros(1, CNCnum);  %   ģ���˻��㷨������������
sortix = zeros(1, CNCnum);      %   ģ���˻��㷨�����λ�þ���
rannum1 = 1;
rannum2 = 1;


while t < Twork
    %   ����RGV��ǰλ�ü����Ӧ��RGV�ƶ�ʱ�����
    switch Pos
        case 1
            Trgvm(1) = 0;
          	Trgvm(2) = 0;
            Trgvm(3) = tm1;
           	Trgvm(4) = tm1;
         	Trgvm(5) = tm2;
           	Trgvm(6) = tm2;
          	Trgvm(7) = tm3;
           	Trgvm(8) = tm3;
       	case 2
           	Trgvm(1) = tm1;
           	Trgvm(2) = tm1;
         	Trgvm(3) = 0;
          	Trgvm(4) = 0;
           	Trgvm(5) = tm1;
          	Trgvm(6) = tm1;
           	Trgvm(7) = tm2;
           	Trgvm(8) = tm2;
        case 3
           	Trgvm(1) = tm2;
          	Trgvm(2) = tm2;
          	Trgvm(3) = tm1;
         	Trgvm(4) = tm1;
          	Trgvm(5) = 0;
           	Trgvm(6) = 0;
          	Trgvm(7) = tm1;
           	Trgvm(8) = tm1;
     	case 4
         	Trgvm(1) = tm3;
          	Trgvm(2) = tm3;
           	Trgvm(3) = tm2;
          	Trgvm(4) = tm2;
           	Trgvm(5) = tm1;
          	Trgvm(6) = tm1;
        	Trgvm(7) = 0;
           	Trgvm(8) = 0;
    end
    %   ����RGV����ʱ�����
	Trgvw(1) = trwo;
	Trgvw(3) = trwo;
    Trgvw(5) = trwo;
	Trgvw(7) = trwo;
	Trgvw(2) = trwe;
	Trgvw(4) = trwe;
	Trgvw(6) = trwe;
	Trgvw(8) = trwe;
    %   ������ʱ��
    Ttotal = Trgvm + Trgvw + Tcncw;
    %   �ҳ����·��
    %   ����ģ���˻��㷨�������·��λ��
    rannum1 = rand(1);
    if rannum1 > 0
        [tmin, minPos] = min(Ttotal);
    else
        [sortTtotal, sortix] = sort(Ttotal);
        tmin = Ttotal(sortix(2));
        minPos = sortix(2);
    end
    %   ����еצ�������ϣ��������·����Ƚ�
    if paw == 1
        Tclear = tclr;
    else
        Tclear = 100000;
    end
    %   �����ʱ�������ϴʱ�䣬���Ƚ�����ϴ
    if tmin > Tclear
        t = t + tclr;
        Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - tclr;
        paw = paw - 1;
    %   ����Ҫ�������豸���ڵ�ǰλ�ã����ƶ�
    elseif ceil(minPos/2) ~= Pos
        Pos = ceil(minPos/2);
        t = t + Trgvm(minPos);
        Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - Trgvm(minPos);
    %   ����Ҫ������λ���ڵ�ǰ�豸
    else
        %   ����ǰ�豸δ�������������ϲ���������
        if CNCw(minPos) == 0
            t = t + Trgvw(minPos);
            Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - Trgvw(minPos);
            Tcncw(Tcncw<0) = 0;

            rannum2 = rand(1);
            if rannum2 > 0.01
                Tcncw(minPos) = Tcncw(minPos) + tcnc;
                CNCw(minPos) = 1;
            else
                CNCw(minPos) = 2;
                Tcncw(minPos) = ceil(rand(1)*560+(10+1000*rannum2)*60);
            end
            count(minPos) = count(minPos) + 1;
            starttime(count(minPos), minPos) = t;
        %   ����ǰ�豸���ڹ���
        else
            %   ���豸�ѹ�����ϣ��������ϲ���������
            if Tcncw(minPos) == 0
                if CNCw(minPos) == 1
                    endtime(count(minPos), minPos) = t;
                    t = t + Trgvw(minPos);
                    paw = paw + 1;
                    Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - Trgvw(minPos);
                    Tcncw(Tcncw<0) = 0;

                    rannum2 = rand(1);
                    if rannum2 > 0.01
                        Tcncw(minPos) = Tcncw(minPos) + tcnc;
                        CNCw(minPos) = 1;
                    else
                        CNCw(minPos) = 2;
                        Tcncw(minPos) = ceil(rand(1)*560+(10+1000*rannum2)*60);
                    end
                    count(minPos) = count(minPos) + 1;
                    starttime(count(minPos), minPos) = t;
                else
                    t = t + Trgvw(minPos);
                    Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - Trgvw(minPos);
                    Tcncw(Tcncw<0) = 0;

                    rannum2 = rand(1);
                    if rannum2 > 0.01
                        Tcncw(minPos) = Tcncw(minPos) + tcnc;
                        CNCw(minPos) = 1;
                    else
                        CNCw(minPos) = 2;
                        Tcncw(minPos) = ceil(rand(1)*560+(10+1000*rannum2)*60);
                    end
                    count(minPos) = count(minPos) + 1;
                    starttime(count(minPos), minPos) = t;
                end
            %   ���豸���ڹ������ȴ�
            else
                t = t + 1;
                Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - 1;
            end
        end
    end
    %   ȥ��С��0����
    Tcncw(Tcncw<0) = 0;
end

