function output = main_GUI_reconsitution(handles)
global main_handles_old;
%% 初始值设置
handles.comp_base_path = main_handles_old.comp_base_path;
handles.water_path = main_handles_old.water_path;
handles.workpath = main_handles_old.workpath;
handles.year_start = main_handles_old.year_start;
handles.month_start = main_handles_old.month_start;
handles.day_start = main_handles_old.day_start;
handles.hour_start =main_handles_old.hour_start;
handles.min_start = main_handles_old.min_start;
handles.sec_start = main_handles_old.sec_start;
handles.year_end = main_handles_old.year_end;
handles.month_end = main_handles_old.month_end;
handles.day_end = main_handles_old.day_end;
handles.hour_end = main_handles_old.hour_end;
handles.min_end = main_handles_old.min_end;
handles.sec_end = main_handles_old.sec_end;
handles.Dt = main_handles_old.Dt;
handles.G_year = main_handles_old.G_year;
handles.G_month =main_handles_old.G_month;
handles.G_day = main_handles_old.G_day;
handles.G_hour = main_handles_old.G_hour;
handles.G_min = main_handles_old.G_min;
handles.G_sec = main_handles_old.G_sec;
handles.G_delta_t = main_handles_old.G_delta_t;
handles.O_year = main_handles_old.O_year;
handles.O_month = main_handles_old.O_month;
handles.O_day = main_handles_old.O_day;
handles.O_hour = main_handles_old.O_hour;
handles.O_min = main_handles_old.O_min;
handles.O_sec = main_handles_old.O_sec;
handles.O_delta_t = main_handles_old.O_delta_t;
handles.C_year = main_handles_old.C_year;
handles.C_month = main_handles_old.C_month;
handles.C_day = main_handles_old.C_day;
handles.C_hour = main_handles_old.C_hour;
handles.C_min = main_handles_old.C_min;
handles.C_sec = main_handles_old.C_sec;
handles.C_delta_t = main_handles_old.C_delta_t;
handles.obs_num = main_handles_old.obs_num;
handles.opne_bnd_num = main_handles_old.opne_bnd_num;
handles.wave_grid_index = main_handles_old.wave_grid_index;
handles.claculation_content_status = main_handles_old.claculation_content_status;
handles.per_process_state = main_handles_old.per_process_state;
handles.generate_control_file_button_state = main_handles_old.generate_control_file_button_state;
handles.caculation_button_state = main_handles_old.caculation_button_state;
handles.per_process_open = main_handles_old.per_process_open;
handles.wave_open = main_handles_old.wave_open;
handles.configuration_open = main_handles_old.configuration_open;
handles.sediment_open = main_handles_old.sediment_open;
%% 界面设置
state_list = {'year_start','month_start','day_start','hour_start','year_end',...
    'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
   'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour' ,'C_delta_t'};
ms_state_list = {'min_start','sec_start','min_end','sec_end','G_min','G_sec',...
    'O_min','O_sec','C_min','C_sec'};
if(~isequal(handles.claculation_content_status(2),1))
    for i = 1:19
        temp = eval(['handles.',state_list{i}]);
        if(~isnan(temp))
            eval(['set(handles.',state_list{i},'_input',',','''string''',',','num2str(handles.',state_list{i},')',',','''Enable''',',','''on''',',','''Backgroundcolor''',',','''w''',');'])
        else
            eval(['set(handles.',state_list{i},'_input',',','''string''',',','''''',',','''Enable''',',','''on''',',','''Backgroundcolor''',',','''w''',');'])
        end
    end
    if(isequal(handles.claculation_content_status(3),1)||isequal(handles.claculation_content_status(6),1))
        for i = 20:24
            temp = eval(['handles.',state_list{i}]);
            if(~isnan(temp))
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','num2str(handles.',state_list{i},')',',','''Enable''',',','''on''',',','''Backgroundcolor''',',','''w''',');'])
            else
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','''''',',','''Enable''',',','''on''',',','''Backgroundcolor''',',','''w''',');'])
            end
        end
    else
        for i = 20:24
            eval(['set(handles.',state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''off''',',','''Backgroundcolor''',',','''w''',');'])
        end
    end
    for i = 1:8
        temp = eval(['handles.',ms_state_list{i}]);
        if(~isequal(temp,0))
            eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','num2str(handles.',ms_state_list{i},')',',','''Enable''',',','''on''',',','''Backgroundcolor''',',','''w''',');'])
        else
            eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''on''',',','''Backgroundcolor''',',','''w''',');'])
        end
    end
    if(isequal(handles.claculation_content_status(3),1)||isequal(handles.claculation_content_status(6),1))
        for i = 9:10
            temp = eval(['handles.',ms_state_list{i}]);
            if(~isequal(temp,0))
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','num2str(handles.',ms_state_list{i},')',',','''Enable''',',','''on''',',','''Backgroundcolor''',',','''w''',');'])
            else
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''on''',',','''Backgroundcolor''',',','''w''',');'])
            end
        end
    else
        for i = 9:10
            eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''off''',',','''Backgroundcolor''',',','''w''',');'])
        end
    end
    set(handles.generate_control_file_button,'Enable','on');
    if(isequal(handles.caculation_button_state,1))
        set(handles.caculation_button,'Enable','on');
    else
        set(handles.caculation_button,'Enable','off');
    end
else
    for i = 1:19
        eval(['set(handles.',state_list{i},'_input',',','''string''',',','''''',',','''Enable''',',','''off''',');'])
    end
    for i = 20:24
        eval(['set(handles.',state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''off''',');'])
    end
    
    for i = 1:8
        eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''off''',');'])
    end
    for i = 9:10
        eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''off''',');'])
    end
    set(handles.generate_control_file_button,'Enable','off');
    set(handles.caculation_button,'Enable','on');
end
if(isequal(handles.claculation_content_status(1),1))
    set(handles.per_process_radio,'Value',1);
    set(handles.per_process_call_buttom,'Enable','on');
    set(handles.sediment_call_button,'Enable','off');
    set(handles.wave_call_button,'Enable','off');
end
if(isequal(handles.claculation_content_status(2),1))
    set(handles.wave_radio,'Value',1);
    set(handles.per_process_call_buttom,'Enable','off');
    set(handles.sediment_call_button,'Enable','off');
    set(handles.wave_call_button,'Enable','on');
end
if(isequal(handles.claculation_content_status(3),1))
    set(handles.wave_pre_process_radio,'Value',1);
    set(handles.per_process_call_buttom,'Enable','on');
    set(handles.sediment_call_button,'Enable','off');
    set(handles.wave_call_button,'Enable','on');
end
if(isequal(handles.claculation_content_status(4),1))
    set(handles.pre_process_sediment_redio,'Value',1);
    set(handles.per_process_call_buttom,'Enable','on');
    set(handles.sediment_call_button,'Enable','on');
    set(handles.wave_call_button,'Enable','off');
end
if(isequal(handles.claculation_content_status(5),1))
    set(handles.wave_sediment_radio,'Value',1);
    set(handles.per_process_call_buttom,'Enable','on');
    set(handles.sediment_call_button,'Enable','on');
    set(handles.wave_call_button,'Enable','on');
end
if(isequal(handles.claculation_content_status(6),1))
    set(handles.wave_per_sediment_radio,'Value',1);
    set(handles.per_process_call_buttom,'Enable','on');
    set(handles.sediment_call_button,'Enable','on');
    set(handles.wave_call_button,'Enable','on');
end
output = handles;
end
    

