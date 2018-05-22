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
        uiwait(msgbox('��������ַ��Ƿ������������֣�','����','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(month_input);
    end
elseif (month <= 0)
    eval(['handles.',out_name{2},'=','NaN',';']);
    set(month_input,'string','');
    handles.generate_control_file_button_state(month_id) = 0;
    set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
    uicontrol(month_input);
    uiwait(msgbox('�·ݱ������0����������ȷ���·ݣ�','����','error'));
elseif(month > 12)
    eval(['handles.',out_name{2},'=','NaN',';']);
    handles.generate_control_file_button_state(month_id) = 0;
    set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
    uicontrol(month_input);
    uiwait(msgbox('�·�������Ϊ12����������ȷ���·�����','����','error'));
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
                    msg = [num2str(year),'Ϊ���꣬2������29�죬��������ȷ��������'];
                    uiwait(msgbox(msg,'����','error'));
                else
                    msg = [num2str(year),'Ϊƽ�꣬2������28�죬��������ȷ��������'];
                    uiwait(msgbox(msg,'����','error'));
                end
            else
                uiwait(msgbox('����Ϊ���껹��ƽ�꣬2������29�죬��������ȷ��������','����','error'));
            end
        else
            if (isequal(check_result(1),31))
                msg = [num2str(month),'������',num2str(check_result(1)),'�죬��������ȷ��������'];
                uiwait(msgbox(msg,'����','error'));
            else
                msg = [num2str(month),'������',num2str(check_result(1)),'�죬��������ȷ��������'];
                uiwait(msgbox(msg,'����','error'));
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

