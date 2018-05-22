function output = pre_process_write_bcc(handles)
bcc_file_id = fopen([handles.workpath,'\1.bcc'],'wt');
[row,~] = size(handles.bund_all);
for i = 1:row
    line1 = ['table-name           ''Boundary Section : ',num2str(i),''''];
    line2 = 'contents             ''Uniform    ''';
    line3 = ['location             ''',handles.bund_all{i,1},'              '''];
    line4 = 'time-function        ''non-equidistant''';
    line5 = ['reference-time       ',handles.itdate,'']; %% 此处20180404调用mdf中的参考时间变量Itdate。
    line6 = 'time-unit            ''minutes''';
    line7 = 'interpolation        ''linear''';
    line8 = 'parameter            ''time                ''  unit ''[min]''';
    line9 = 'parameter            ''Sediment1            end A uniform''       unit ''[kg/m3]''';
    line10 = 'parameter            ''Sediment1            end B uniform''       unit ''[kg/m3]''';
    line11 = 'records-in-table     2';
    for lin = 1:11
        fprintf(bcc_file_id,'%s\n',eval(['line',num2str(lin)]));
    end
    data_ = zeros(2,3);
    data_(2,1) = handles.tstop;
    for kk = 1:2
        for kkk = 1:3
            fprintf(bcc_file_id,'%10.7e\t',data_(kk,kkk));
        end
        fprintf(bcc_file_id,'\n');
    end
end
output = fclose(bcc_file_id);
end

