function output = main_GUI_connect_check(handles)

connect_check_result = 1;
state_lis_cn = {'��','��','��','ʱ'};
state_list = {'year_start','month_start','day_start','hour_start','year_end',...
    'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
   'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour' ,'C_delta_t'};

un_set_index = find(~handles.generate_control_file_button_state(20:24),1,'first');
if(~isempty(un_set_index))
    if(un_set_index >= 1 && un_set_index <= 4)
        eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
        eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
        msg = ['�洢����->��ص�->��ʼ��¼ʱ��->','��',state_lis_cn{un_set_index},'��','δ���û�����������ǰ�����ã�'];
        uiwait(msgbox(msg,'����','error'));
    elseif(isequal(un_set_index,5))
        eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
        eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
        uiwait(msgbox('�洢����->��ص�->��ʱ�䲽����δ���û�����������ǰ�����ã�','����','error'));
    end
    connect_check_result = 0;
else
    connect_check_result = 1;
end

output = connect_check_result;
end

