%   �ű����ܣ�
%   ����RGV��̬���ȣ��������򣬲����ǻ������ϣ�
%
%   ����������
%   RGV��̬���ȵĵڶ���ģ����Ҫ���ڽ�������ǻ�����������µ���������������ҵ
%   �ӹ��������ģ�ͻ���̰������ÿ��RGVҪִ����һ����ʱ��ö�ÿ���豸ִ�е�
%   ʱ�䳤�̲��Դ�������ѡ�����ڲ�ͬ��CNC�ֳ������飬���ͨ��������ʱ�����
%   ĳЩ��Ĵ�С���Դﵽ�Ƚ��е�һ�������ٽ��еڶ��������Ч�������ݵ�һ������
%   �͵ڶ�������ӹ�����ʱ�䳤�̿ɶ�8̨�����������ܷ��飬ѡ�����ŷ��顣����
%   ��Ϻ󣬸��ݶ���ʱ�����ĳЩ���ڲ�ͬ����µ��޸ģ�����RGV�Ƿ���Ҫ�ƶ���
%   �Ƿ���Ҫ�����������Ƿ���Ҫ�ȴ�����ʱ��������ƣ�ֱ��8Сʱ����ʱѭ��������
%   ����ʱ���˹��������ӹ���������Ͻ��д���
%
%   Ƕ�׺�������
%
%   ���ߣ��ޏ���
%
%   �汾��1.1
%
%   �ϴ��޸�ʱ�䣺2018.9.16
%
%   �ϴ��޸���ʷ������ע�ͺ;�������

%   MATLAB��ʼ��
clear
clc

%   ���ڵڶ���ģ�ͼӹ�������Ҫ�������������Ҫ����CNC��ν��з��飬ÿ��
%   ������ٸ�CNC�����⡣�������Ƚ��а��գ�4,4������3,5������5,3���ķ���ṹ
%   ����ѭ�����������֣�4,4�������ĳһ�ַ�ʽ�õ���������࣬��˸�����4,4��
%   ������α������Լ�������Ϻ�������Ž⡣����3,5������ͣ�5,3���������
%   �ڳ���������ע�͸�����

%   ͨ������õ�����һ������CNC���Ϊ1,3,5,7���ڶ�������CNC���Ϊ2,4,6��8
%   �����ŽⲻΨһ��

%   ���ݳ�ʼ��
load('firstgroup4.mat');
all = [1, 2, 3, 4, 5, 6, 7, 8];
groupcount = zeros(70, 1);
secondgroup = zeros(70, 4);

%   �ԣ�4,4�������ÿ��������б���
for divgroup = 1: 70
    %   �õ��ڶ��������CNC���
    secondgroup(divgroup,:) = setdiff(all, firstgroup(divgroup,:));
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
    
    %   ��ʱ�䲻����8Сʱ
    while t < Twork
        %   ����RGV����λ�ü���RGV�ƶ�ʱ�����
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
        %   ����RGVҪ���豸���еĲ�������RGV����ʱ�����
        Trgvw(1) = trwo;
        Trgvw(3) = trwo;
        Trgvw(5) = trwo;
        Trgvw(7) = trwo;
        Trgvw(2) = trwe;
        Trgvw(4) = trwe;
        Trgvw(6) = trwe;
        Trgvw(8) = trwe;
        %   ����ʱû�е�һ������ӹ���ɵİ��Ʒ����ڶ��������Ӧ������ͣ
        if pawsecond == 0
            Trgvw(secondgroup(divgroup, 1)) = ...
                Trgvw(secondgroup(divgroup, 1)) + 100000;
            Trgvw(secondgroup(divgroup, 2)) = ...
                Trgvw(secondgroup(divgroup, 2)) + 100000;
            Trgvw(secondgroup(divgroup, 3)) = ...
                Trgvw(secondgroup(divgroup, 3)) + 100000;
            Trgvw(secondgroup(divgroup, 4)) = ...
                Trgvw(secondgroup(divgroup, 4)) + 100000;
        else
            Trgvw(firstgroup(divgroup, 1)) = ...
                Trgvw(firstgroup(divgroup, 1)) + 100000;
            Trgvw(firstgroup(divgroup, 2)) = ...
                Trgvw(firstgroup(divgroup, 2)) + 100000;
            Trgvw(firstgroup(divgroup, 3)) = ...
                Trgvw(firstgroup(divgroup, 3)) + 100000;
            Trgvw(firstgroup(divgroup, 4)) = ...
                Trgvw(firstgroup(divgroup, 4)) + 100000;
        end
        %   ������ʱ�����
        Ttotal = Trgvm + Trgvw + Tcncw;
        %   ������һ�����ʱ�估·��
        [tmin, minPos] = min(Ttotal);
        %   ����еצ���д���ϴ�����ϣ�������ϴʱ��
        if pawclear > 0
            Tclear = tclr;
        else
            Tclear = 100000;
        end
        %   ����һ�����·������Ӧʱ�������ϴʱ�䣬�Ƚ�����ϴ����
        if tmin > Tclear
            t = t + tclr;
            Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - tclr;
            pawclear = pawclear - 1;
        %   ����һ��Ҫ�����Ķ����ڴ˴������ƶ�RGV
        elseif ceil(minPos/2) ~= Pos
            Pos = ceil(minPos/2);
            t = t + Trgvm(minPos);
            Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvm(minPos);
        %   ����һ��Ҫ�����Ķ����ڴ˴�
        else
            switch minPos
                %   ����������Ϊ��һ������CNC
                case {firstgroup(divgroup, 1), firstgroup(divgroup, 2), ...
                        firstgroup(divgroup, 3), firstgroup(divgroup, 4)}
                    %   ����������δ��ʼ�������������ϴ�������
                    if CNCw(minPos) == 0
                        t = t + Trgvw(minPos);
                        Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
                        Tcncw(Tcncw<0) = 0;
                        Tcncw(minPos) = Tcncw(minPos) + tcnc1;
                        CNCw(minPos) = 1;
                        count1(minPos) = count1(minPos) + 1;
                        starttime1(count1(minPos), minPos) = t;
                    %   ����������Ĺ���״̬���Ϊ1
                    else
                        %   �����������ѹ�����ϣ��������������ϲ�����
                        if Tcncw(minPos) == 0
                            endtime1(count1(minPos), minPos) = t;
                            t = t + Trgvw(minPos);
                            pawsecond = pawsecond + 1;
                            Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
                            Tcncw(Tcncw<0) = 0;
                            Tcncw(minPos) = Tcncw(minPos) + tcnc1;
                            CNCw(minPos) = 1;
                            count1(minPos) = count1(minPos) + 1;
                            starttime1(count1(minPos), minPos) = t;
                        %   ����������δ������ϣ���ȴ�
                        else
                            t = t + 1;
                            Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - 1;
                        end
                    end
                %   ����������Ϊ�ڶ�������CNC
                case {secondgroup(divgroup, 1), secondgroup(divgroup, 2), ...
                        secondgroup(divgroup, 3), secondgroup(divgroup, 4)}
                    %   ����������δ��ʼ���������ϲ�����
                    if CNCw(minPos) == 0
                        t = t + Trgvw(minPos);
                        Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
                        Tcncw(Tcncw<0) = 0;
                        Tcncw(minPos) = Tcncw(minPos) + tcnc2;
                        CNCw(minPos) = 1;
                        count2(minPos) = count2(minPos) + 1;
                        starttime2(count2(minPos), minPos) = t;
                        pawsecond = pawsecond - 1;
                    %   ������������״̬���Ϊ1
                    else
                        %   �����������ѹ�����ϣ��������������ϲ�����
                        if Tcncw(minPos) == 0
                            endtime2(count2(minPos), minPos) = t;
                            t = t + Trgvw(minPos);
                            pawclear = pawclear + 1;
                            Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
                            Tcncw(Tcncw<0) = 0;
                            Tcncw(minPos) = Tcncw(minPos) + tcnc2;
                            CNCw(minPos) = 1;
                            count2(minPos) = count2(minPos) + 1;
                            starttime2(count2(minPos), minPos) = t;
                            pawsecond = pawsecond - 1;
                        %   ����������δ������ϣ���ȴ�
                        else
                            t = t + 1;
                            Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - 1;
                        end
                    end
            end
        end
        Tcncw(Tcncw<0) = 0;
    end
    %   ����ÿ�������������������
    logiccount = endtime2 > 0;
    groupcount(divgroup) = sum(logiccount(:));
end

%   �ҳ���������������ϵ���Ϸ�ʽ
[Totalcount, divgroup] = max(groupcount);
%   ���¼���ÿ�����ϵĵ�һ���͵ڶ�����������Ϻ�����ʱ��
%   �õ��ڶ��������CNC���
secondgroup(divgroup,:) = setdiff(all, firstgroup(divgroup,:));
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

%   ��ʱ�䲻����8Сʱ
while t < Twork
    %   ����RGV����λ�ü���RGV�ƶ�ʱ�����
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
    %   ����RGVҪ���豸���еĲ�������RGV����ʱ�����
    Trgvw(1) = trwo;
    Trgvw(3) = trwo;
    Trgvw(5) = trwo;
    Trgvw(7) = trwo;
    Trgvw(2) = trwe;
    Trgvw(4) = trwe;
    Trgvw(6) = trwe;
    Trgvw(8) = trwe;
    %   ����ʱû�е�һ������ӹ���ɵİ��Ʒ����ڶ��������Ӧ������ͣ
    if pawsecond == 0
        Trgvw(secondgroup(divgroup, 1)) = Trgvw(secondgroup(divgroup, 1)) + 100000;
        Trgvw(secondgroup(divgroup, 2)) = Trgvw(secondgroup(divgroup, 2)) + 100000;
        Trgvw(secondgroup(divgroup, 3)) = Trgvw(secondgroup(divgroup, 3)) + 100000;
        Trgvw(secondgroup(divgroup, 4)) = Trgvw(secondgroup(divgroup, 4)) + 100000;
    else
        Trgvw(firstgroup(divgroup, 1)) = Trgvw(firstgroup(divgroup, 1)) + 100000;
        Trgvw(firstgroup(divgroup, 2)) = Trgvw(firstgroup(divgroup, 2)) + 100000;
        Trgvw(firstgroup(divgroup, 3)) = Trgvw(firstgroup(divgroup, 3)) + 100000;
        Trgvw(firstgroup(divgroup, 4)) = Trgvw(firstgroup(divgroup, 4)) + 100000;
    end
    %   ������ʱ�����
    Ttotal = Trgvm + Trgvw + Tcncw;
    %   ������һ�����ʱ�估·��
    [tmin, minPos] = min(Ttotal);
    %   ����еצ���д���ϴ�����ϣ�������ϴʱ��
    if pawclear > 0
        Tclear = tclr;
    else
        Tclear = 100000;
    end
    %   ����һ�����·������Ӧʱ�������ϴʱ�䣬�Ƚ�����ϴ����
    if tmin > Tclear
        t = t + tclr;
        Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - tclr;
        pawclear = pawclear - 1;
    %   ����һ��Ҫ�����Ķ����ڴ˴������ƶ�RGV
    elseif ceil(minPos/2) ~= Pos
        Pos = ceil(minPos/2);
        t = t + Trgvm(minPos);
        Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvm(minPos);
    %   ����һ��Ҫ�����Ķ����ڴ˴�
    else
        switch minPos
            %   ����������Ϊ��һ������CNC
            case {firstgroup(divgroup, 1), firstgroup(divgroup, 2), ...
                    firstgroup(divgroup, 3), firstgroup(divgroup, 4)}
                %   ����������δ��ʼ�������������ϴ�������
                if CNCw(minPos) == 0
                    t = t + Trgvw(minPos);
                    Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
                    Tcncw(Tcncw<0) = 0;
                    Tcncw(minPos) = Tcncw(minPos) + tcnc1;
                    CNCw(minPos) = 1;
                    count1(minPos) = count1(minPos) + 1;
                    starttime1(count1(minPos), minPos) = t;
                %   ����������Ĺ���״̬���Ϊ1
                else
                    %   �����������ѹ�����ϣ��������������ϲ�����
                    if Tcncw(minPos) == 0
                        endtime1(count1(minPos), minPos) = t;
                        t = t + Trgvw(minPos);
                        pawsecond = pawsecond + 1;
                        Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
                        Tcncw(Tcncw<0) = 0;
                        Tcncw(minPos) = Tcncw(minPos) + tcnc1;
                        CNCw(minPos) = 1;
                        count1(minPos) = count1(minPos) + 1;
                        starttime1(count1(minPos), minPos) = t;
                    %   ����������δ������ϣ���ȴ�
                    else
                        t = t + 1;
                        Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - 1;
                    end
                end
            %   ����������Ϊ�ڶ�������CNC
            case {secondgroup(divgroup, 1), secondgroup(divgroup, 2), ...
                    secondgroup(divgroup, 3), secondgroup(divgroup, 4)}
                %   ����������δ��ʼ���������ϲ�����
                if CNCw(minPos) == 0
                    t = t + Trgvw(minPos);
                    Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
                    Tcncw(Tcncw<0) = 0;
                    Tcncw(minPos) = Tcncw(minPos) + tcnc2;
                    CNCw(minPos) = 1;
                    count2(minPos) = count2(minPos) + 1;
                    starttime2(count2(minPos), minPos) = t;
                    pawsecond = pawsecond - 1;
                %   ������������״̬���Ϊ1
                else
                    %   �����������ѹ�����ϣ��������������ϲ�����
                    if Tcncw(minPos) == 0
                        endtime2(count2(minPos), minPos) = t;
                        t = t + Trgvw(minPos);
                        pawclear = pawclear + 1;
                        Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
                        Tcncw(Tcncw<0) = 0;
                        Tcncw(minPos) = Tcncw(minPos) + tcnc2;
                        CNCw(minPos) = 1;
                        count2(minPos) = count2(minPos) + 1;
                        starttime2(count2(minPos), minPos) = t;
                        pawsecond = pawsecond - 1;
                    %   ����������δ������ϣ���ȴ�
                    else
                        t = t + 1;
                        Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - 1;
                    end
                end
        end
    end
    Tcncw(Tcncw<0) = 0;
end    

%   �������

%   ��������ӽ���Сʱ��ʱ����ҪֹͣĳЩ������RGV�������ϲ����Ա�֤���ڰ�Сʱ
%   �ڽ����豸ֹͣ���ص���ʼλ�ã���˳���������辭��һ���˹�������ܵõ�
%   ������ֵ�����Գ������ɵ����ݺ͵���Excel����е����ݻ���΢С���

%   �ж�ÿ�����������Ƿ���Ч
logiccount = endtime2 > 0;
%   ���ÿ����������ʱ�䣬���о������Ϊ��ͬ�����ϣ���Ϊ���ĸ�CNC������
%   �ֵ�һ������͵ڶ�������
starttime1
starttime2
%   ���ÿ����������ʱ�䣬���о������Ϊ��ͬ�����ϡ���Ϊ���ĸ�������
%   �ֵ�һ������͵ڶ�������
endtime1
endtime2
%   ����ܲ���
TotalProduct = sum(logiccount(:))





% %   ��Ϊ��3,5�����飬��������
% %   MATLAB��ʼ��
% clear
% clc
% 
% %   ���ݳ�ʼ��
% load('firstgroup3.mat');
% all = [1, 2, 3, 4, 5, 6, 7, 8];
% groupcount = zeros(70, 1);
% secondgroup = zeros(70, 5);
% 
% 
% for divgroup = 1: 56
%     secondgroup(divgroup,:) = setdiff(all, firstgroup3(divgroup,:));
%     tm1 = 20;                       %   RGV�ƶ�1����λʱ��
%     tm2 = 33;                       %   RGV�ƶ�2����λʱ��
%     tm3 = 46;                       %   RGV�ƶ�3����λʱ��
%     tcnc1 = 400;                    %   CNC��ɵ�һ����������ʱ��
%     tcnc2 = 378;                    %   CNC��ɵڶ�����������ʱ��
%     trwo = 28;                      %   RGVΪ����CNC������ʱ��
%     trwe = 31;                      %   RGVΪż��CNC������ʱ��
%     tclr = 25;                      %   RGV��ϴ����ʱ��
%     Twork = 28800;                  %   �ܹ���ʱ��
%     CNCnum = 8;                     %   CNC������
%     t = 0;                          %   ʱ���ʼ��
%     Pos = 1;                        %   λ�ó�ʼ��
%     CNCw = zeros(1, CNCnum);        %   CNC����״̬��־
%     Trgvm = zeros(1, CNCnum);      	%   RGV�ƶ�ʱ�����
%     Trgvw = zeros(1, CNCnum);       %   RGV����ʱ�����
%     Tcncw = zeros(1, CNCnum);       %   CNC����ʱ�����
%     Ttotal = zeros(1, CNCnum);      %   ��ʱ�����
%     pawsecond = 0;                  %   ��Ҫ���еڶ������������
%     pawclear = 0;                   %   ��Ҫ��ϴ������
%     Tclear = 100000;                %   ��ϴʣ��ʱ��
%     count1 = zeros(1, CNCnum);      %   ����ÿ̨������һ������������Ŀ
%     count2 = zeros(1, CNCnum);      %   ����ÿ̨�����ڶ�������������Ŀ
%     starttime1 = zeros(100, CNCnum);%   ÿ̨������һ��������������Ӧʱ��
%     starttime2 = zeros(100, CNCnum);%   ÿ̨�����ڶ���������������Ӧʱ��
%     endtime1 = zeros(100, CNCnum);  %   ÿ̨������һ��������������Ӧʱ��
%     endtime2 = zeros(100, CNCnum);  %   ÿ̨�����ڶ���������������Ӧʱ��
%     %   ��ʱ�䲻����8Сʱ
%     while t < Twork
%         %   ����RGV����λ�ü���RGV�ƶ�ʱ�����
%         switch Pos
%             case 1
%                 Trgvm(1) = 0;
%                 Trgvm(2) = 0;
%                 Trgvm(3) = tm1;
%                 Trgvm(4) = tm1;
%                 Trgvm(5) = tm2;
%                 Trgvm(6) = tm2;
%                 Trgvm(7) = tm3;
%                 Trgvm(8) = tm3;
%             case 2
%                 Trgvm(1) = tm1;
%                 Trgvm(2) = tm1;
%                 Trgvm(3) = 0;
%                 Trgvm(4) = 0;
%                 Trgvm(5) = tm1;
%                 Trgvm(6) = tm1;
%                 Trgvm(7) = tm2;
%                 Trgvm(8) = tm2;               
%             case 3
%                 Trgvm(1) = tm2;
%                 Trgvm(2) = tm2;
%                 Trgvm(3) = tm1;
%                 Trgvm(4) = tm1;
%                 Trgvm(5) = 0;
%                 Trgvm(6) = 0;
%                 Trgvm(7) = tm1;
%                 Trgvm(8) = tm1;
%             case 4
%                 Trgvm(1) = tm3;
%                 Trgvm(2) = tm3;
%                 Trgvm(3) = tm2;
%                 Trgvm(4) = tm2;
%                 Trgvm(5) = tm1;
%                 Trgvm(6) = tm1;
%                 Trgvm(7) = 0;
%                 Trgvm(8) = 0;        
%         end
%         %   ����RGVҪ���豸���еĲ�������RGV����ʱ�����
%         Trgvw(1) = trwo;
%         Trgvw(3) = trwo;
%         Trgvw(5) = trwo;
%         Trgvw(7) = trwo;
%         Trgvw(2) = trwe;
%         Trgvw(4) = trwe;
%         Trgvw(6) = trwe;
%         Trgvw(8) = trwe;
%         %   ����ʱû�е�һ������ӹ���ɵİ��Ʒ����ڶ��������Ӧ������ͣ
%         if pawsecond == 0
%             Trgvw(secondgroup(divgroup, 1)) = Trgvw(secondgroup(divgroup, 1)) + 100000;
%             Trgvw(secondgroup(divgroup, 2)) = Trgvw(secondgroup(divgroup, 2)) + 100000;
%             Trgvw(secondgroup(divgroup, 3)) = Trgvw(secondgroup(divgroup, 3)) + 100000;
%             Trgvw(secondgroup(divgroup, 4)) = Trgvw(secondgroup(divgroup, 4)) + 100000;
%             Trgvw(secondgroup(divgroup, 5)) = Trgvw(secondgroup(divgroup, 5)) + 100000;
%         else
%             Trgvw(firstgroup3(divgroup, 1)) = Trgvw(firstgroup3(divgroup, 1)) + 100000;
%             Trgvw(firstgroup3(divgroup, 2)) = Trgvw(firstgroup3(divgroup, 2)) + 100000;
%             Trgvw(firstgroup3(divgroup, 3)) = Trgvw(firstgroup3(divgroup, 3)) + 100000;
%         end
%         %   ������ʱ�����
%         Ttotal = Trgvm + Trgvw + Tcncw;
%         %   ������һ�����ʱ�估·��
%         rannum1 = rand(1);
%         if rannum1 > 0
%             [tmin, minPos] = min(Ttotal);
%         else
%             [sortTtotal, sortix] = sort(Ttotal);
%             tmin = Ttotal(sortix(2));
%             minPos = sortix(2);
%         end
%         %   ����еצ���д���ϴ�����ϣ�������ϴʱ��
%         if pawclear > 0
%             Tclear = tclr;
%         else
%             Tclear = 100000;
%         end
%         %   ����һ�����·������Ӧʱ�������ϴʱ�䣬�Ƚ�����ϴ����
%         if tmin > Tclear
%             t = t + tclr;
%             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - tclr;
%             pawclear = pawclear - 1;
%         %   ����һ��Ҫ�����Ķ����ڴ˴������ƶ�RGV
%         elseif ceil(minPos/2) ~= Pos
%             Pos = ceil(minPos/2);
%             t = t + Trgvm(minPos);
%             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvm(minPos);
%         %   ����һ��Ҫ�����Ķ����ڴ˴�
%         else
%             switch minPos
%                 %   ����������Ϊ��һ������CNC
%                 case {firstgroup3(divgroup, 1), firstgroup3(divgroup, 2), ...
%                         firstgroup3(divgroup, 3)}
%                     %   ����������δ��ʼ�������������ϴ�������
%                     if CNCw(minPos) == 0
%                         t = t + Trgvw(minPos);
%                         Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
%                         Tcncw(Tcncw<0) = 0;
%                         Tcncw(minPos) = Tcncw(minPos) + tcnc1;
%                         CNCw(minPos) = 1;
%                         count1(minPos) = count1(minPos) + 1;
%                         starttime1(count1(minPos), minPos) = t;
%                     %   ����������Ĺ���״̬���Ϊ1
%                     else
%                         %   �����������ѹ�����ϣ��������������ϲ�����
%                         if Tcncw(minPos) == 0
%                             endtime1(count1(minPos), minPos) = t;
%                             t = t + Trgvw(minPos);
%                             pawsecond = pawsecond + 1;
%                             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
%                             Tcncw(Tcncw<0) = 0;
%                             Tcncw(minPos) = Tcncw(minPos) + tcnc1;
%                             CNCw(minPos) = 1;
%                             count1(minPos) = count1(minPos) + 1;
%                             starttime1(count1(minPos), minPos) = t;
%                         %   ����������δ������ϣ���ȴ�
%                         else
%                             t = t + 1;
%                             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - 1;
%                         end
%                     end
%                 %   ����������Ϊ�ڶ�������CNC
%                 case {secondgroup(divgroup, 1), secondgroup(divgroup, 2), ...
%                         secondgroup(divgroup, 3), secondgroup(divgroup, 4), ...
%                         secondgroup(divgroup, 5)}
%                     %   ����������δ��ʼ���������ϲ�����
%                     if CNCw(minPos) == 0
%                         t = t + Trgvw(minPos);
%                         Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
%                         Tcncw(Tcncw<0) = 0;
%                         Tcncw(minPos) = Tcncw(minPos) + tcnc2;
%                         CNCw(minPos) = 1;
%                         count2(minPos) = count2(minPos) + 1;
%                         starttime2(count2(minPos), minPos) = t;
%                         pawsecond = pawsecond - 1;
%                     %   ������������״̬���Ϊ1
%                     else
%                         %   �����������ѹ�����ϣ��������������ϲ�����
%                         if Tcncw(minPos) == 0
%                             endtime2(count2(minPos), minPos) = t;
%                             t = t + Trgvw(minPos);
%                             pawclear = pawclear + 1;
%                             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
%                             Tcncw(Tcncw<0) = 0;
%                             Tcncw(minPos) = Tcncw(minPos) + tcnc2;
%                             CNCw(minPos) = 1;
%                             count2(minPos) = count2(minPos) + 1;
%                             starttime2(count2(minPos), minPos) = t;
%                             pawsecond = pawsecond - 1;
%                         %   ����������δ������ϣ���ȴ�
%                         else
%                             t = t + 1;
%                             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - 1;
%                         end
%                     end
%             end
%         end
%         Tcncw(Tcncw<0) = 0;
%     end
%     logiccount = endtime2 > 0;
%     groupcount(divgroup) = sum(logiccount(:));
% end
% %   �ҳ���������������ϵ���Ϸ�ʽ
% [Totalcount, divgroup] = max(groupcount);
% 
% 
% 
% 
% %   ��Ϊ��5,3�����飬������������
% %   MATLAB��ʼ��
% clear
% clc
% 
% %   ���ݳ�ʼ��
% load('firstgroup3.mat');
% all = [1, 2, 3, 4, 5, 6, 7, 8];
% groupcount = zeros(70, 1);
% secondgroup = firstgroup3;
% firstgroup = zeros(70,5);
% 
% 
% for divgroup = 1: 56
%     firstgroup(divgroup,:) = setdiff(all, firstgroup3(divgroup,:));
%     tm1 = 20;                       %   RGV�ƶ�1����λʱ��
%     tm2 = 33;                       %   RGV�ƶ�2����λʱ��
%     tm3 = 46;                       %   RGV�ƶ�3����λʱ��
%     tcnc1 = 400;                    %   CNC��ɵ�һ����������ʱ��
%     tcnc2 = 378;                    %   CNC��ɵڶ�����������ʱ��
%     trwo = 28;                      %   RGVΪ����CNC������ʱ��
%     trwe = 31;                      %   RGVΪż��CNC������ʱ��
%     tclr = 25;                      %   RGV��ϴ����ʱ��
%     Twork = 28800;                  %   �ܹ���ʱ��
%     CNCnum = 8;                     %   CNC������
%     t = 0;                          %   ʱ���ʼ��
%     Pos = 1;                        %   λ�ó�ʼ��
%     CNCw = zeros(1, CNCnum);        %   CNC����״̬��־
%     Trgvm = zeros(1, CNCnum);      	%   RGV�ƶ�ʱ�����
%     Trgvw = zeros(1, CNCnum);       %   RGV����ʱ�����
%     Tcncw = zeros(1, CNCnum);       %   CNC����ʱ�����
%     Ttotal = zeros(1, CNCnum);      %   ��ʱ�����
%     pawsecond = 0;                  %   ��Ҫ���еڶ������������
%     pawclear = 0;                   %   ��Ҫ��ϴ������
%     Tclear = 100000;                %   ��ϴʣ��ʱ��
%     count1 = zeros(1, CNCnum);      %   ����ÿ̨������һ������������Ŀ
%     count2 = zeros(1, CNCnum);      %   ����ÿ̨�����ڶ�������������Ŀ
%     starttime1 = zeros(100, CNCnum);%   ÿ̨������һ��������������Ӧʱ��
%     starttime2 = zeros(100, CNCnum);%   ÿ̨�����ڶ���������������Ӧʱ��
%     endtime1 = zeros(100, CNCnum);  %   ÿ̨������һ��������������Ӧʱ��
%     endtime2 = zeros(100, CNCnum);  %   ÿ̨�����ڶ���������������Ӧʱ��
%     %   ��ʱ�䲻����8Сʱ
%     while t < Twork
%         %   ����RGV����λ�ü���RGV�ƶ�ʱ�����
%         switch Pos
%             case 1
%                 Trgvm(1) = 0;
%                 Trgvm(2) = 0;
%                 Trgvm(3) = tm1;
%                 Trgvm(4) = tm1;
%                 Trgvm(5) = tm2;
%                 Trgvm(6) = tm2;
%                 Trgvm(7) = tm3;
%                 Trgvm(8) = tm3;
%             case 2
%                 Trgvm(1) = tm1;
%                 Trgvm(2) = tm1;
%                 Trgvm(3) = 0;
%                 Trgvm(4) = 0;
%                 Trgvm(5) = tm1;
%                 Trgvm(6) = tm1;
%                 Trgvm(7) = tm2;
%                 Trgvm(8) = tm2;               
%             case 3
%                 Trgvm(1) = tm2;
%                 Trgvm(2) = tm2;
%                 Trgvm(3) = tm1;
%                 Trgvm(4) = tm1;
%                 Trgvm(5) = 0;
%                 Trgvm(6) = 0;
%                 Trgvm(7) = tm1;
%                 Trgvm(8) = tm1;
%             case 4
%                 Trgvm(1) = tm3;
%                 Trgvm(2) = tm3;
%                 Trgvm(3) = tm2;
%                 Trgvm(4) = tm2;
%                 Trgvm(5) = tm1;
%                 Trgvm(6) = tm1;
%                 Trgvm(7) = 0;
%                 Trgvm(8) = 0;        
%         end
%         %   ����RGVҪ���豸���еĲ�������RGV����ʱ�����
%         Trgvw(1) = trwo;
%         Trgvw(3) = trwo;
%         Trgvw(5) = trwo;
%         Trgvw(7) = trwo;
%         Trgvw(2) = trwe;
%         Trgvw(4) = trwe;
%         Trgvw(6) = trwe;
%         Trgvw(8) = trwe;
%         %   ����ʱû�е�һ������ӹ���ɵİ��Ʒ����ڶ��������Ӧ������ͣ
%         if pawsecond == 0
%             Trgvw(secondgroup(divgroup, 1)) = Trgvw(secondgroup(divgroup, 1)) + 100000;
%             Trgvw(secondgroup(divgroup, 2)) = Trgvw(secondgroup(divgroup, 2)) + 100000;
%             Trgvw(secondgroup(divgroup, 3)) = Trgvw(secondgroup(divgroup, 3)) + 100000;
%         else
%             Trgvw(firstgroup(divgroup, 1)) = Trgvw(firstgroup(divgroup, 1)) + 100000;
%             Trgvw(firstgroup(divgroup, 2)) = Trgvw(firstgroup(divgroup, 2)) + 100000;
%             Trgvw(firstgroup(divgroup, 3)) = Trgvw(firstgroup(divgroup, 3)) + 100000;
%             Trgvw(firstgroup(divgroup, 4)) = Trgvw(firstgroup(divgroup, 1)) + 100000;
%             Trgvw(firstgroup(divgroup, 5)) = Trgvw(firstgroup(divgroup, 2)) + 100000;
%         end
%         %   ������ʱ�����
%         Ttotal = Trgvm + Trgvw + Tcncw;
%         %   ������һ�����ʱ�估·��
%         rannum1 = rand(1);
%         if rannum1 > 0
%             [tmin, minPos] = min(Ttotal);
%         else
%             [sortTtotal, sortix] = sort(Ttotal);
%             tmin = Ttotal(sortix(2));
%             minPos = sortix(2);
%         end
%         %   ����еצ���д���ϴ�����ϣ�������ϴʱ��
%         if pawclear > 0
%             Tclear = tclr;
%         else
%             Tclear = 100000;
%         end
%         %   ����һ�����·������Ӧʱ�������ϴʱ�䣬�Ƚ�����ϴ����
%         if tmin > Tclear
%             t = t + tclr;
%             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - tclr;
%             pawclear = pawclear - 1;
%         %   ����һ��Ҫ�����Ķ����ڴ˴������ƶ�RGV
%         elseif ceil(minPos/2) ~= Pos
%             Pos = ceil(minPos/2);
%             t = t + Trgvm(minPos);
%             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvm(minPos);
%         %   ����һ��Ҫ�����Ķ����ڴ˴�
%         else
%             switch minPos
%                 %   ����������Ϊ��һ������CNC
%                 case {firstgroup(divgroup, 1), firstgroup(divgroup, 2), ...
%                         firstgroup(divgroup, 3), firstgroup(divgroup, 4), ...
%                         firstgroup(divgroup, 5)}
%                     %   ����������δ��ʼ�������������ϴ�������
%                     if CNCw(minPos) == 0
%                         t = t + Trgvw(minPos);
%                         Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
%                         Tcncw(Tcncw<0) = 0;
%                         Tcncw(minPos) = Tcncw(minPos) + tcnc1;
%                         CNCw(minPos) = 1;
%                         count1(minPos) = count1(minPos) + 1;
%                         starttime1(count1(minPos), minPos) = t;
%                     %   ����������Ĺ���״̬���Ϊ1
%                     else
%                         %   �����������ѹ�����ϣ��������������ϲ�����
%                         if Tcncw(minPos) == 0
%                             endtime1(count1(minPos), minPos) = t;
%                             t = t + Trgvw(minPos);
%                             pawsecond = pawsecond + 1;
%                             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
%                             Tcncw(Tcncw<0) = 0;
%                             Tcncw(minPos) = Tcncw(minPos) + tcnc1;
%                             CNCw(minPos) = 1;
%                             count1(minPos) = count1(minPos) + 1;
%                             starttime1(count1(minPos), minPos) = t;
%                         %   ����������δ������ϣ���ȴ�
%                         else
%                             t = t + 1;
%                             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - 1;
%                         end
%                     end
%                 %   ����������Ϊ�ڶ�������CNC
%                 case {secondgroup(divgroup, 1), secondgroup(divgroup, 2), ...
%                         secondgroup(divgroup, 3)}
%                     %   ����������δ��ʼ���������ϲ�����
%                     if CNCw(minPos) == 0
%                         t = t + Trgvw(minPos);
%                         Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
%                         Tcncw(Tcncw<0) = 0;
%                         Tcncw(minPos) = Tcncw(minPos) + tcnc2;
%                         CNCw(minPos) = 1;
%                         count2(minPos) = count2(minPos) + 1;
%                         starttime2(count2(minPos), minPos) = t;
%                         pawsecond = pawsecond - 1;
%                     %   ������������״̬���Ϊ1
%                     else
%                         %   �����������ѹ�����ϣ��������������ϲ�����
%                         if Tcncw(minPos) == 0
%                             endtime2(count2(minPos), minPos) = t;
%                             t = t + Trgvw(minPos);
%                             pawclear = pawclear + 1;
%                             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - Trgvw(minPos);
%                             Tcncw(Tcncw<0) = 0;
%                             Tcncw(minPos) = Tcncw(minPos) + tcnc2;
%                             CNCw(minPos) = 1;
%                             count2(minPos) = count2(minPos) + 1;
%                             starttime2(count2(minPos), minPos) = t;
%                             pawsecond = pawsecond - 1;
%                         %   ����������δ������ϣ���ȴ�
%                         else
%                             t = t + 1;
%                             Tcncw(CNCw == 1) = Tcncw(CNCw == 1) - 1;
%                         end
%                     end
%             end
%         end
%         Tcncw(Tcncw<0) = 0;
%     end
%     logiccount = endtime2 > 0;
%     groupcount(divgroup) = sum(logiccount(:));
% end
% %   �ҳ���������������ϵ���Ϸ�ʽ
% [Totalcount, divgroup] = max(groupcount);