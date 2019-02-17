%   �ű����ܣ�
%   ����RGV��̬���ȣ���������1%�������ϣ�
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

%   MATLAB��ʼ��
clear
clc

%   ���ݳ�ʼ��
tm1 = 20;                       %   RGV�ƶ�1����λʱ��
tm2 = 33;                       %   RGV�ƶ�2����λʱ��
tm3 = 46;                       %   RGV�ƶ�3����λʱ��
tcnc1 = 400;                    %   CNC��ɵ�һ����������ʱ��
tcnc2 = 378;                    %   CNC��ɵڶ�����������ʱ��
trwo = 28;                      %   RGVΪ����CNC������ʱ��
trwe = 31;                      %   RGVΪż��CNC������ʱ��
tclr = 25;                      %   RGV��ϴ����ʱ��
Twork = 28800;                  %   �ܹ���ʱ��
CNCnum = 8;                     %   CNC������
t = 0;                          %   ʱ���ʼ��
Pos = 1;                        %   λ�ó�ʼ��
CNCw = zeros(1, CNCnum);        %   CNC����״̬��־
Trgvm = zeros(1, CNCnum);      	%   RGV�ƶ�ʱ�����
Trgvw = zeros(1, CNCnum);       %   RGV����ʱ�����
Tcncw = zeros(1, CNCnum);       %   CNC����ʱ�����
Ttotal = zeros(1, CNCnum);      %   ��ʱ�����
pawsecond = 0;                  %   ��Ҫ���еڶ������������
pawclear = 0;                   %   ��Ҫ��ϴ������
Tclear = 100000;                %   ��ϴʣ��ʱ��
count1 = zeros(1, CNCnum);      %   ����ÿ̨������һ������������Ŀ
count2 = zeros(1, CNCnum);      %   ����ÿ̨�����ڶ�������������Ŀ
starttime1 = zeros(100, CNCnum);%   ÿ̨������һ��������������Ӧʱ��
starttime2 = zeros(100, CNCnum);%   ÿ̨�����ڶ���������������Ӧʱ��
endtime1 = zeros(100, CNCnum);  %   ÿ̨������һ��������������Ӧʱ��
endtime2 = zeros(100, CNCnum);  %   ÿ̨�����ڶ���������������Ӧʱ��
sortTtotal = zeros(1, CNCnum);  %   ģ���˻��㷨������������
sortix = zeros(1, CNCnum);      %   ģ���˻��㷨�����λ�þ���
rannum1 = 1;
rannum2 = 1;

while t < Twork
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
    Trgvw(1) = trwo;
	Trgvw(3) = trwo;
    Trgvw(5) = trwo;
	Trgvw(7) = trwo;
	Trgvw(2) = trwe;
	Trgvw(4) = trwe;
	Trgvw(6) = trwe;
	Trgvw(8) = trwe;
    if pawsecond == 0
        Trgvw(2) = Trgvw(2) + 100000;
        Trgvw(4) = Trgvw(4) + 100000;
        Trgvw(6) = Trgvw(6) + 100000;
        Trgvw(8) = Trgvw(8) + 100000;
    else
        Trgvw(1) = Trgvw(1) + 100000;
        Trgvw(3) = Trgvw(3) + 100000;
        Trgvw(5) = Trgvw(5) + 100000;
        Trgvw(7) = Trgvw(7) + 100000;
    end
    Ttotal = Trgvm + Trgvw + Tcncw;
    rannum1 = rand(1);
    if rannum1 > 0
        [tmin, minPos] = min(Ttotal);
    else
        [sortTtotal, sortix] = sort(Ttotal);
        tmin = Ttotal(sortix(2));
        minPos = sortix(2);
    end
    if pawclear > 0
        Tclear = tclr;
    else
        Tclear = 100000;
    end
    if tmin > Tclear
        t = t + tclr;
        Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - tclr;
        pawclear = pawclear - 1;
    elseif ceil(minPos/2) ~= Pos
        Pos = ceil(minPos/2);
        t = t + Trgvm(minPos);
        Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - Trgvm(minPos);
    else
        switch minPos
            case {1, 3, 5, 7}
                if CNCw(minPos) == 0
                    t = t + Trgvw(minPos);
                    Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - Trgvw(minPos);
                    Tcncw(Tcncw<0) = 0;

                    rannum2 = rand(1);
                    if rannum2 > 0.01
                        Tcncw(minPos) = Tcncw(minPos) + tcnc1;
                        CNCw(minPos) = 1;
                    else
                        CNCw(minPos) = 2;
                        Tcncw(minPos) = ceil(rand(1)*560+(10+1000*rannum2)*60);
                    end
                    count1(minPos) = count1(minPos) + 1;
                    starttime1(count1(minPos), minPos) = t;
                else
                    if Tcncw(minPos) == 0
                        if CNCw(minPos) == 1
                            endtime1(count1(minPos), minPos) = t;
                            t = t + Trgvw(minPos);
                            pawsecond = pawsecond + 1;
                            Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - Trgvw(minPos);
                            Tcncw(Tcncw<0) = 0;

                            rannum2 = rand(1);
                            if rannum2 > 0.01
                                Tcncw(minPos) = Tcncw(minPos) + tcnc1;
                                CNCw(minPos) = 1;
                            else
                                CNCw(minPos) = 2;
                                Tcncw(minPos) = ceil(rand(1)*560+(10+1000*rannum2)*60);
                            end
                            count1(minPos) = count1(minPos) + 1;
                            starttime1(count1(minPos), minPos) = t;
                        else
                            t = t + Trgvw(minPos);
                            Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - Trgvw(minPos);
                            Tcncw(Tcncw<0) = 0;

                            rannum2 = rand(1);
                            if rannum2 > 0.01
                                Tcncw(minPos) = Tcncw(minPos) + tcnc1;
                                CNCw(minPos) = 1;
                            else
                                CNCw(minPos) = 2;
                                Tcncw(minPos) = ceil(rand(1)*560+(10+1000*rannum2)*60);
                            end
                            count1(minPos) = count1(minPos) + 1;
                            starttime1(count1(minPos), minPos) = t;
                        end

                    else
                        t = t + 1;
                        Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - 1;
                    end
                end
            case {2, 4, 6, 8}
                if CNCw(minPos) == 0
                    t = t + Trgvw(minPos);
                    Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - Trgvw(minPos);
                    Tcncw(Tcncw<0) = 0;

                    rannum2 = rand(1);
                    if rannum2 > 0.01
                        Tcncw(minPos) = Tcncw(minPos) + tcnc2;
                        CNCw(minPos) = 1;
                    else
                        CNCw(minPos) = 2;
                        Tcncw(minPos) = ceil(rand(1)*560+(10+1000*rannum2)*60);
                    end
                    count2(minPos) = count2(minPos) + 1;
                    starttime2(count2(minPos), minPos) = t;
                    pawsecond = pawsecond - 1;
                else
                    if Tcncw(minPos) == 0
                        if CNCw(minPos) == 1
                            endtime2(count2(minPos), minPos) = t;
                            t = t + Trgvw(minPos);
                            pawclear = pawclear + 1;
                            Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - Trgvw(minPos);
                            Tcncw(Tcncw<0) = 0;

                            rannum2 = rand(1);
                            if rannum2 > 0.01
                                Tcncw(minPos) = Tcncw(minPos) + tcnc2;
                                CNCw(minPos) = 1;
                            else
                                CNCw(minPos) = 2;
                                Tcncw(minPos) = ceil(rand(1)*560+(10+1000*rannum2)*60);
                            end
                            count2(minPos) = count2(minPos) + 1;
                            starttime2(count2(minPos), minPos) = t;
                            pawsecond = pawsecond - 1;
                        else
                            t = t + Trgvw(minPos);
                            Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - Trgvw(minPos);
                            Tcncw(Tcncw<0) = 0;

                            rannum2 = rand(1);
                            if rannum2 > 0.01
                                Tcncw(minPos) = Tcncw(minPos) + tcnc2;
                                CNCw(minPos) = 1;
                            else
                                CNCw(minPos) = 2;
                                Tcncw(minPos) = ceil(rand(1)*560+(10+1000*rannum2)*60);
                            end
                            count2(minPos) = count2(minPos) + 1;
                            starttime2(count2(minPos), minPos) = t;
                            pawsecond = pawsecond - 1;
                        end
                    else
                        t = t + 1;
                        Tcncw(CNCw >= 1) = Tcncw(CNCw >= 1) - 1;
                    end
                end
        end
    end
    Tcncw(Tcncw<0) = 0;
end




