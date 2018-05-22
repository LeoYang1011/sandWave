function output = pre_process_rdMN(M,num)

% 如果前十个数或后十个数中有陆地，则认为都是陆地，以减少边界的数量。
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
    % 要考虑只有一条边界的情况，因为只有一条边界时，无法获取b的值
    if a(1,end)-a(1,1)+1 == m
        if a(1,1)-1 ==0
            c = [a(1,end)+1,cend];
        elseif a(1,end)-cend == 0
            c = [2,a(1,1)-1];
        else
            c = [2,a(1,1)-1,a(1,end)+1,cend];
        end
    else
        %  首先获取为特定数字的索引，>=n 表示如果中间的开边界间距小于n个点，则将其认为闭边界。
        j = 1;
        for i = 1:m-1
            %         if (a(i+1)-a(i)) >= 8
            if (a(i+1)-a(i))~=1     % 控制开边界网格长度
                
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
        % 判断两端是否有特定的数字，没有的话先执行，如果有的话  再判断是在哪一段或是否在两端。
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
