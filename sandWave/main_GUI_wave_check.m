function [wave_check_result,error_type] = main_GUI_wave_check(handles)

wave_check_result = 1;
error_type = 0;
if (isequal(handles.wave_grid_index,1))
    wave_state = [exist([handles.workpath,'\1.grd'],'file'),exist([handles.workpath,'\1.enc'],'file'),exist([handles.workpath,'\layer'],'file'),...
        exist([handles.workpath,'\1.dep'],'file'),exist([handles.workpath,'\1.mdw'],'file')];
    no_file_index = find(~wave_state,1,'first');
    if(~isempty(no_file_index))
        if (isequal(no_file_index,1) || isequal(no_file_index,2) )
            uiwait(msgbox('ǰ����ģ��->δ���ü���������ǰ�����ã�','����','error'));
            error_type = 1;
        elseif(isequal(no_file_index,3))
            uiwait(msgbox('ǰ����ģ��->δ���ô���ֲ㣬��ǰ�����ã�','����','error'));
            error_type = 1;
        elseif(isequal(no_file_index,4))
            uiwait(msgbox('ǰ����ģ��->δ����ˮ���ǰ�����ã�','����','error'));
            error_type = 1;
        elseif(isequal(no_file_index,5))
            uiwait(msgbox('����ģ��->δ���ò����ļ�����ǰ�����ã�','����','error'));
            error_type = 2;
        end
        wave_check_result = 0;
    else
        wave_check_result = 1;
        error_type = 0;
    end
else
    wave_state = [exist([handles.workpath,'\wave.grd'],'file'),exist([handles.workpath,'\wave.dep'],'file'),exist([handles.workpath,'\1.mdw'],'file')];
    no_file_index = find(~wave_state,1,'first');
    if(~isempty(no_file_index))
        if (isequal(no_file_index,1) || isequal(no_file_index,2) )
            uiwait(msgbox('����ģ��->δ���ü�������ˮ���ǰ�����ã�','����','error'));
            error_type = 2;
        elseif(isequal(no_file_index,3))
            uiwait(msgbox('����ģ��->δ���ò����ļ�����ǰ�����ã�','����','error'));
            error_type = 2;
        end
        wave_check_result = 0;
    else
        wave_check_result = 1;
        error_type = 0;
    end
end

end

