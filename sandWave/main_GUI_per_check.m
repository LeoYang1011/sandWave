function output = main_GUI_per_check(handles)

per_check_result = 1;
if(~isequal(handles.claculation_content_status(5),1))
    per_process_file_state = [exist([handles.workpath,'\1.grd'],'file'),exist([handles.workpath,'\1.enc'],'file'),exist([handles.workpath,'\layer'],'file'),...
        exist([handles.workpath,'\1.dep'],'file'),exist([handles.workpath,'\1.bnd'],'file'),exist([handles.workpath,'\1.bct'],'file'),exist([handles.workpath,'\1.bca'],'file')];
    no_file_index = find(~per_process_file_state,1,'first');
    if(~isempty(no_file_index))
        if (isequal(no_file_index,1) || isequal(no_file_index,2) )
            uiwait(msgbox('前处理模块->未设置计算网格，请前往设置！','错误','error'));
        elseif(isequal(no_file_index,3))
            uiwait(msgbox('前处理模块->未设置垂向分层，请前往设置！','错误','error'));
        elseif(isequal(no_file_index,4))
            uiwait(msgbox('前处理模块->未设置水深，请前往设置！','错误','error'));
        elseif(isequal(no_file_index,5))
            uiwait(msgbox('前处理模块->未设置边界，请前往设置！','错误','error'));
        elseif(isequal(no_file_index,6)||isequal(no_file_index,7))
            uiwait(msgbox('前处理模块->未设置分潮，请前往设置！','错误','error'));
        end
        per_check_result = 0;
    else
        if (~isequal(handles.per_process_state(1),handles.per_process_state(2)))
            uiwait(msgbox('前处理模块->水深、边界及分潮未更新，请前往更新！','错误','error'));
            per_check_result = 0;
        end
    end
else
    per_process_file_state = [exist([handles.workpath,'\1.grd'],'file'),exist([handles.workpath,'\1.enc'],'file'),exist([handles.workpath,'\layer'],'file'),...
        exist([handles.workpath,'\1.dep'],'file')];
    no_file_index = find(~per_process_file_state,1,'first');
    if(~isempty(no_file_index))
        if (isequal(no_file_index,1) || isequal(no_file_index,2) )
            uiwait(msgbox('前处理模块->未设置计算网格，请前往设置！','错误','error'));
        elseif(isequal(no_file_index,3))
            uiwait(msgbox('前处理模块->未设置垂向分层，请前往设置！','错误','error'));
        elseif(isequal(no_file_index,4))
            uiwait(msgbox('前处理模块->未设置水深，请前往设置！','错误','error'));
        end
        per_check_result = 0;
    else
        if (~isequal(handles.per_process_state(1),handles.per_process_state(2)))
            uiwait(msgbox('前处理模块->水深、边界及分潮未更新，请前往更新！','错误','error'));
            per_check_result = 0;
        end
    end
end

output = per_check_result;
end

