function output = main_GUI_month_check(out_name,hObject,handles)
state_list = {'year_start','month_start','day_start','hour_start','year_end',...
    'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
   'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour','C_delta_t'};

year = NaN;
month = NaN;
day = NaN;

eval(['year','=','handles.',out_name{1},';']);
eval(['year_input','=','handles.',out_name{1},'_input',';']);
year_id = find(ismember(state_list,out_name{1}));
eval(['month','=','handles.',out_name{2},';']);
eval(['month_input','=','handles.',out_name{2},'_input',';']);
month_id = find(ismember(state_list,out_name{2}));
eval(['day','=','handles.',out_name{3},';']);
eval(['day_input','=','handles.',out_name{3},'_input',';']);
day_id = find(ismember(state_list,out_name{3}));

if(isnan(month))
    handles.generate_control_file_button_state(month_id) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(month_input);
    end
elseif (month <= 0)
    eval(['handles.',out_name{2},'=','NaN',';']);
    set(month_input,'string','');
    handles.generate_control_file_button_state(month_id) = 0;
    set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
    uicontrol(month_input);
    uiwait(msgbox('月份必须大于0，请输入正确的月份！','错误','error'));
elseif(month > 12)
    eval(['handles.',out_name{2},'=','NaN',';']);
    handles.generate_control_file_button_state(month_id) = 0;
    set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
    uicontrol(month_input);
    uiwait(msgbox('月份数至多为12，请输入正确的月份数！','错误','error'));
else
    handles.generate_control_file_button_state(month_id) = 1;
    set(hObject,'Backgroundcolor','w');
    %     if (isequal(handles.generate_control_file_button_state(day_id),1))
    check_result = main_GUI_date_rationality_check(day,month,year);
    if (~check_result(2))
        handles.generate_control_file_button_state(day_id) = 0;
%         eval(['handles.',out_name{3},'=','NaN',';']);
        set(day_input,'Backgroundcolor',[0.8,0.2,0.2]);
        uicontrol(day_input);
        if(isequal(month,2))
            if(~isnan(year))
                if (check_result(1))
                    msg = [num2str(year),'为闰年，2月至多29天，请输入正确的天数！'];
                    uiwait(msgbox(msg,'错误','error'));
                else
                    msg = [num2str(year),'为平年，2月至多28天，请输入正确的天数！'];
                    uiwait(msgbox(msg,'错误','error'));
                end
            else
                uiwait(msgbox('无论为闰年还是平年，2月至多29天，请输入正确的天数！','错误','error'));
            end
        else
            if (isequal(check_result(1),31))
                msg = [num2str(month),'月至多',num2str(check_result(1)),'天，请输入正确的天数！'];
                uiwait(msgbox(msg,'错误','error'));
            else
                msg = [num2str(month),'月至多',num2str(check_result(1)),'天，请输入正确的天数！'];
                uiwait(msgbox(msg,'错误','error'));
            end
        end
    else
        if (~isnan(day))
            handles.generate_control_file_button_state(day_id) = 1;
        end
        set(day_input,'Backgroundcolor','w');
    end
    %     end
end
output = handles;
end

