function output = pre_process_write_bnd( bund_all,dir)
bund_file_id = fopen([dir,'\1.bnd'],'wt');
[row,col] = size(bund_all);
for i = 1:row
    for j = 1:col
        if j == 1
            fprintf(bund_file_id,'%s                   ',bund_all{i,j});
        elseif j >= 4 && j <= 7
            fprintf(bund_file_id,'%d    ',bund_all{i,j});
        else
            fprintf(bund_file_id,'%s    ',bund_all{i,j});
        end
    end
    fprintf(bund_file_id,'\n');
end
bund_file_status = fclose(bund_file_id);
output = bund_file_status;
end

