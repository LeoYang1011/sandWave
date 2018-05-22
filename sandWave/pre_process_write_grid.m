function output = pre_process_write_grid(x_grid,y_grid,handles)
%% 将网格写入.grd及.enc文件中;
% write the file header;
grid_file_id=fopen([handles.workpath,'\1.grd'],'wt');

s1=['Coordinate System = ',handles.coordinate];
fprintf(grid_file_id,'%s\n',s1);

[~,row]=size(y_grid);
[~,column]=size(x_grid);
r_c=[column row];
fprintf(grid_file_id,'%d\t',r_c);
fprintf(grid_file_id,'\n');

zero_3=zeros(1,3);
fprintf(grid_file_id,'%d\t',zero_3);
fprintf(grid_file_id,'\n');

%将经纬度网格写入文件中
[~,j]=size(x_grid);
x_grid_row_num=floor((j)/5);
rem_x_num=rem(j,5);

x_grid_1=x_grid(:,1:j-rem_x_num);
x_grid_1=x_grid_1';
x_grid_1=reshape(x_grid_1,5,x_grid_row_num);
x_grid_1=x_grid_1';
[row_x1,column_x1]=size(x_grid_1);

x_grid_2=x_grid(1,j-rem_x_num+1:j);

for m=1:1:row
    s2='ETA=    ';
    s3=num2str(m);
    s2=[s2,s3];
    fprintf(grid_file_id,'%s\t',s2);
    
    for i1=1:row_x1
        for i2=1:column_x1
            fprintf(grid_file_id,'%f\t',x_grid_1(i1,i2));
        end
        fprintf(grid_file_id,'\n');
    end
    
    fprintf(grid_file_id,'%f\t',x_grid_2);
    fprintf(grid_file_id,'\n');
end
%
y_grid_xx=ones(i1,i2);
y_grid_rem=ones(1,rem_x_num);
for i=1:row
    y_grid_1=y_grid(1,i)*y_grid_xx;
    y_grid_2=y_grid(1,i)*y_grid_rem;
    
    sy1='ETA=  ';
    sy2=num2str(i);
    sy=[sy1,sy2];
    fprintf(grid_file_id,'%s\t',sy);
    for i3=1:row_x1
        for i4=1:column_x1
            fprintf(grid_file_id,'%f\t',y_grid_1(i1,i2));
        end
        fprintf(grid_file_id,'\n');
    end
    
    fprintf(grid_file_id,'%f\t',y_grid_2);
    fprintf(grid_file_id,'\n');
end

grid_file_status = -1;
grid_file_status = fclose(grid_file_id);

%% 生成.enc文件;
enc_file_id=fopen([handles.workpath,'\1.enc'],'wt');
enc_1='     1     1   *** begin external enclosure ';
fprintf(enc_file_id,'%s\n',enc_1);
% fprintf(fid2,'\n');

enc_2=[column+1,1];
enc_2=num2str(enc_2);
fprintf(enc_file_id,'%s\n',enc_2);
% fprintf(fid2,'\n');

enc_3=[column+1,row+1];
enc_3=num2str(enc_3);
fprintf(enc_file_id,'%s\n',enc_3);
% fprintf(fid2,'\n');

enc_4=[1,row+1];
enc_4=num2str(enc_4);
fprintf(enc_file_id,'%s\n',enc_4);
% fprintf(fid2,'\n');

enc_5='     1     1   *** end external grid enclosure';
fprintf(enc_file_id,'%s\n',enc_5);

enc_file_status = -1;
enc_file_status = fclose(enc_file_id);


output = [column,row,grid_file_status,enc_file_status];
end

