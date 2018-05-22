function output = post_check_input(handles,variable_name,lim_name,input)
if(isequal(lim_name,'steplim'))
    name = '时间';
elseif(isequal(lim_name,'xlim'))
    name = '经度';
elseif(isequal(lim_name,'ylim'))
    name = '纬度';
elseif(isequal(lim_name,'zlim'))
    name = '高度';
end
eval(['tag_input = handles.',variable_name,'_input;'])
if(isequal(handles.data_id,2))
    eval(['lim = handles.',lim_name,'{1};']);
    eval(['value = handles.',variable_name,'{1};'])
    id = 1;
elseif(isequal(handles.data_id,3))
    eval(['lim = handles.',lim_name,'{2};']);
    eval(['value = handles.',variable_name,'{2};'])
    id = 2;
else
    if(isequal(lim_name,'steplim'))
        eval(['lim = handles.',lim_name,'{3};']);
        eval(['value = handles.',variable_name,'{3};'])
        id = 3;
    else
        eval(['lim = handles.',lim_name,'{2};']);
        eval(['value = handles.',variable_name,'{2};'])
        id = 2;
    end
end
if(isnan(input))
    if (~isempty(get(tag_input,'String')))
        eval(['set(',tag_input,',','''string''',',',num2str(value),')'])
        uicontrol(tag_input);
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
    end
else
    if(input>lim(2)||input<lim(1))
        eval(['set(tag_input,','''string''',',',num2str(value),')'])
        uicontrol(tag_input);
        uiwait(msgbox(['所输入数据:',num2str(input),' 不在',name,'区间:[',num2str(lim(1)),',',num2str(lim(2)),']内!'],'错误','error'));
        return
    else
        eval(['handles.',variable_name,'{',num2str(id),'}=input;']);
    end        
end
output = handles;
end

