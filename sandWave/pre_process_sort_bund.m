function output = pre_process_sort_bund( bund_old )
[row,~] = size(bund_old);
if (row <= 1)
    output = bund_old;
    return;
else
    for i = 1:row
        for j = 1:row-i
            if (bund_old{j,3} > bund_old{j+1,3})
                temp = bund_old(j,:);
                bund_old(j,:) = bund_old(j+1,:);
                bund_old(j+1,:) = temp;
            end
        end
    end
end
output = bund_old;
end


