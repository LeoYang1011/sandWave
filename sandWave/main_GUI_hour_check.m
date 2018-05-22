function output = main_GUI_hour_check(out_name,hObject,handles)
state_list = {'year_start','month_start','day_start','hour_start','year_end',...
    'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
   'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour','C_delta_t'};

hour = 0;
eval(['hour','=','handles.',out_name,';']);
eval(['hour_input','=', 'handles.',out_name,'_input',';']);
hour_id = find(ismember(state_list,out_name));

if(isnan(hour))
    handles.generate_control_file_button_state(hour_id) = 0;
    if (~isempty(get(hObject,'String')))
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(hour_input);
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
    end
elseif(hour < 0)
    eval(['handles.',out_name,'=','NaN',';'])
    set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
    uiwait(msgbox('小时数不得小于0，请输入正确的小时数！','错误','error'));
    uicontrol(hour_input);
    handles.generate_control_file_button_state(hour_id) = 0;
elseif(hour >= 24)
    eval(['handles.',out_name,'=','NaN',';'])
    set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
    uiwait(msgbox('小时数必须小于24，请输入正确的小时数！','错误','error'));
    uicontrol(hour_input);
    handles.generate_control_file_button_state(hour_id) = 0;
else
    handles.generate_control_file_button_state(hour_id) = 1;
    set(hObject,'Backgroundcolor','w');
end
output = handles;
end

