function output = main_GUI_sediment_check(handles)

sediment_check_result = 1;
sediment_file_state = [exist([handles.workpath,'\1.sed'],'file'),exist([handles.workpath,'\1.mor'],'file')];
no_file_index = find(~sediment_file_state,1,'first');
if(~isempty(no_file_index))
    if(isequal(no_file_index,1))
        uiwait(msgbox('��ɳ��òģ��->δ������ɳ��������ǰ�����ã�','����','error'));
    elseif(isequal(no_file_index,2))
        uiwait(msgbox('��ɳ��òģ��->δ���õ�ò��������ǰ�����ã�','����','error'));
    end
    sediment_check_result = 0;
end

output = sediment_check_result;
end

