function output = pre_process_rdMN(M,num)

% ���ǰʮ�������ʮ��������½�أ�����Ϊ����½�أ��Լ��ٱ߽��������
aa = find(M(1,1:10) == -999);
[~,aaa] = size(aa);
bb = find(M(1,end-10:end) == -999);
[~,bbb] = size(bb);

if aaa ~= 0
    M(1,1:10) = -999;
end

if bbb ~= 0
    M(1,end-10:end) = -999;
end
    

[~,cend] = size(M);
a = find(M == num);
[~,m] = size(a);
if m == 0
    c = [2,cend];
elseif m == cend
    c = [];
else
    % Ҫ����ֻ��һ���߽���������Ϊֻ��һ���߽�ʱ���޷���ȡb��ֵ
    if a(1,end)-a(1,1)+1 == m
        if a(1,1)-1 ==0
            c = [a(1,end)+1,cend];
        elseif a(1,end)-cend == 0
            c = [2,a(1,1)-1];
        else
            c = [2,a(1,1)-1,a(1,end)+1,cend];
        end
    else
        %  ���Ȼ�ȡΪ�ض����ֵ�������>=n ��ʾ����м�Ŀ��߽���С��n���㣬������Ϊ�ձ߽硣
        j = 1;
        for i = 1:m-1
            %         if (a(i+1)-a(i)) >= 8
            if (a(i+1)-a(i))~=1     % ���ƿ��߽����񳤶�
                
                b(j) = a(i)+1;
                b(j+1) = a(i+1)-1;
                j = j+2;
            end
        end
        [~,m1] = size(b);
        ttt = 1;
        for i = 1:m1/2
            if b(ttt+1)-b(ttt) <= 8
                b(ttt:ttt+1) = [];
            else
                ttt = ttt+1;
            end
        end
        % �ж������Ƿ����ض������֣�û�еĻ���ִ�У�����еĻ�  ���ж�������һ�λ��Ƿ������ˡ�
        [~,m1] = size(b);
        if a(1,1) ~= 1 && a(1,end) ~= cend
            c = zeros(1,m1+4);
            c(1,1:2) = [2,a(1,1)-1];
            c(1,end-1:end) = [a(1,end)+1,cend];
            c(1,3:end-2) = b;
        elseif a(1,1) == 1 && a(1,end) ~= cend
            c = zeros(1,m1+2);
            c(1,end-1:end) = [a(1,end)+1,cend];
            c(1,1:end-2) = b;
        elseif a(1,1) ~=1 && a(1,end) == cend
            c = zeros(1,m1+2);
            c(1,1:2) = [2,a(1,1)-1];
            c(1,3:end) = b;
        else
            c = b;
        end
    end
end
output = c;
end
