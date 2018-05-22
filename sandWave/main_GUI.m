function varargout = main_GUI(varargin)
% MAIN_GUI MATLAB code for main_GUI.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_GUI

% Last Modified by GUIDE v2.5 18-May-2018 19:41:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @main_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main_GUI is made visible.
function main_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_GUI (see VARARGIN)

% Choose default command line output for main_GUI
warning('off')
handles.output = hObject;
if (exist([pwd,'\sandWave.exe'],'file'))
    env_path = [pwd,'\'];
else
    env_path = main_GUI_get_env();
end
handles.solver_path = [env_path,'solver\bin'];
handles.comp_base_path = [env_path,'database\tidal component'];
handles.water_path = [env_path,'database\water depth\etopo1_bed_c_f4.flt'];

h = handles.main_fig; %返回其句柄
ico = [env_path,'sandWave_resources\icon_32.png'];
newIcon = javax.swing.ImageIcon(ico);
figFrame = get(h,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标
% 设置界面
set(handles.save_file,'Enable','off');
set(handles.save_file_another,'Enable','off');
set(handles.year_start_input,'string','','Enable','off');
set(handles.month_start_input,'string','','Enable','off');
set(handles.day_start_input,'string','','Enable','off');
set(handles.hour_start_input,'string','','Enable','off');
set(handles.min_start_input,'string','00','Enable','off');
set(handles.sec_start_input,'string','00','Enable','off');
set(handles.year_end_input,'string','','Enable','off');
set(handles.month_end_input,'string','','Enable','off');
set(handles.day_end_input,'string','','Enable','off');
set(handles.hour_end_input,'string','','Enable','off');
set(handles.min_end_input,'string','00','Enable','off');
set(handles.sec_end_input,'string','00','Enable','off');
set(handles.Dt_input,'string','','Enable','off');
set(handles.G_year_input,'string','','Enable','off');
set(handles.G_month_input,'string','','Enable','off');
set(handles.G_day_input,'string','','Enable','off');
set(handles.G_hour_input,'string','','Enable','off');
set(handles.G_min_input,'string','00','Enable','off');
set(handles.G_sec_input,'string','00','Enable','off');
set(handles.G_delta_t_input,'string','','Enable','off');
set(handles.O_year_input,'string','','Enable','off');
set(handles.O_month_input,'string','','Enable','off');
set(handles.O_day_input,'string','','Enable','off');
set(handles.O_hour_input,'string','','Enable','off');
set(handles.O_min_input,'string','00','Enable','off');
set(handles.O_sec_input,'string','00','Enable','off');
set(handles.O_delta_t_input,'string','','Enable','off');
set(handles.C_year_input,'string','00','Enable','off');
set(handles.C_month_input,'string','00','Enable','off');
set(handles.C_day_input,'string','00','Enable','off');
set(handles.C_hour_input,'string','00','Enable','off');
set(handles.C_min_input,'string','00','Enable','off');
set(handles.C_sec_input,'string','00','Enable','off');
set(handles.C_delta_t_input,'string','00','Enable','off');
set(handles.per_process_radio,'Value',1);
set(handles.per_process_call_buttom,'Enable','on');
set(handles.sediment_call_button,'Enable','off');
set(handles.wave_call_button,'Enable','off');
set(handles.generate_control_file_button,'Enable','off');
set(handles.caculation_button,'Enable','off')
% 初始值
handles.workpath = 'no_path';
handles.year_start = NaN;
handles.month_start = NaN;
handles.day_start = NaN;
handles.hour_start =NaN;
handles.min_start = 0;
handles.sec_start = 0;
handles.year_end = NaN;
handles.month_end = NaN;
handles.day_end = NaN;
handles.hour_end = NaN;
handles.min_end = 0;
handles.sec_end = 0;
handles.Dt = NaN;
handles.G_year = NaN;
handles.G_month =NaN;
handles.G_day = NaN;
handles.G_hour = NaN;
handles.G_min = 0;
handles.G_sec = 0;
handles.G_delta_t = NaN;
handles.O_year = NaN;
handles.O_month = NaN;
handles.O_day = NaN;
handles.O_hour = NaN;
handles.O_min = 0;
handles.O_sec = 0;
handles.O_delta_t = NaN;
handles.C_year = 0;
handles.C_month = 0;
handles.C_day = 0;
handles.C_hour = 0;
handles.C_min = 0;
handles.C_sec = 0;
handles.C_delta_t = 0;
handles.obs_num = 5;
handles.claculation_content_status = [1,0,0,0,0,0];
handles.per_process_state = zeros(1,2);
handles.generate_control_file_button_state = zeros(1,24);
handles.caculation_button_state = 0;
handles.wave_grid_index = 1;
handles.per_process_open = 0;
handles.wave_open = 0;
handles.configuration_open = 0;
handles.sediment_open = 0;
handles.post_open = 0;
guidata(hObject, handles);
uiwait(handles.main_fig);

% Update handles structureguidata(hObject, handles);

% UIWAIT makes main_GUI wait for user response (see UIRESUME)
% uiwait(handles.main_fig);


% --- Outputs from this function are returned to the command line.
function varargout = main_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
delete(handles.main_fig);


% --- Executes on button press in per_process_call_buttom.
function per_process_call_buttom_Callback(hObject, eventdata, handles)
% hObject    handle to per_process_call_buttom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global per_process_handles_old;
global observation_point_handle_old;
if (~isempty(per_process_handles_old))
    old_per = struct2cell(per_process_handles_old);
    [row,~] = size(old_per);
    if(row>102)
    old_per = old_per(102:end,:);
    end   
else
    old_per = per_process_handles_old;
end
if (~isempty(observation_point_handle_old))
    old_obs = struct2cell(observation_point_handle_old);
    [row,~] = size(old_obs);
    if(row>8)
        old_obs = old_obs(8:end,:);
    end
else
    old_obs = observation_point_handle_old;
end
if(~isequal(handles.workpath,'no_path'))
    state_lis_cn = {'年','月','日','时'};
    state_list = {'year_start','month_start','day_start','hour_start','year_end',...
        'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
        'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour' ,'C_delta_t'};
    
    un_set_index = find(~handles.generate_control_file_button_state(1:9),1,'first');
    if(~isempty(un_set_index))
        if(un_set_index >= 1 && un_set_index <= 4)
            eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
            eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
            msg = ['请先设置计算控制：计算控制->计算开始时间->','“',state_lis_cn{un_set_index},'”','未设置或设置有误'];
            uiwait(msgbox(msg,'错误','error'));
        elseif(un_set_index >= 5 && un_set_index <= 8)
            eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
            eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
            msg = ['请先设置计算控制：计算控制->结束时间->','“',state_lis_cn{un_set_index-4},'”','未设置或设置有误，请先设置计算控制！'];
            uiwait(msgbox(msg,'错误','error'));
        elseif(isequal(un_set_index,9))
            eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
            eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
            uiwait(msgbox('请先设置计算控制：计算控制->“时间步长”未设置或设置有误，请先设置计算控制！','错误','error'));
        end
        return
    else
        begin_time = datetime(handles.year_start,handles.month_start,handles.day_start,handles.hour_start,...
            handles.min_start,handles.sec_start);
        end_time = datetime(handles.year_end,handles.month_end,handles.day_end,handles.hour_end,...
            handles.min_end,handles.sec_end);
        if(begin_time >= end_time)
            uiwait(msgbox('开始计算时间必须小于结束计算的时间！','错误','error'));
            uicontrol(handles.year_start_input);
            return;
        else
            itdate = [num2str(handles.year_start),num2str(handles.month_start,'%02d'),num2str(handles.day_start,'%02d')];
            t1s = [num2str(handles.year_start,'%4d'),'-',num2str(handles.month_start,'%02d'),'-',num2str(handles.day_start,'%02d'),' ',num2str(handles.hour_start,'%02d')...
                ':',num2str(handles.min_start,'%02d'),':',num2str(handles.sec_start,'%02d')];
            t1 = datevec(t1s);
            t2s = [num2str(handles.year_end,'%4d'),'-',num2str(handles.month_end,'%02d'),'-',num2str(handles.day_end,'%02d'),' ',num2str(handles.hour_end,'%02d')...
                ':',num2str(handles.min_end,'%02d'),':',num2str(handles.sec_end,'%02d')];
            t2 = datevec(t2s);
            tstop = fix(etime(t2,t1)/60);
            handles.per_process_open = 1;
            guidata(hObject, handles);
            [handles.per_process_state,handles.obs_num,handles.opne_bnd_num] = pre_process(0,handles.workpath,handles.comp_base_path,handles.water_path,handles.claculation_content_status,itdate,tstop);
            handles.per_process_open = 0;
        end
    end
else
    uiwait(msgbox('请先设置工作路径！','错误','error'));
    return;
end
if (~isempty(per_process_handles_old))
    new_per = struct2cell(per_process_handles_old);
    new_per = new_per(102:end,:);
else
    new_per = per_process_handles_old;
end
if(~isempty(observation_point_handle_old))
    new_obs = struct2cell(observation_point_handle_old);
    new_obs = new_obs(8:end,:);
else
    new_obs = observation_point_handle_old;
end
if (~isequal(old_per,new_per)||~isequal(old_obs,new_obs))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of per_process_call_buttom


% --- Executes on button press in sediment_call_button.
function sediment_call_button_Callback(hObject, eventdata, handles)
% hObject    handle to sediment_call_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sediment_features_handles_old;
if(~isempty(sediment_features_handles_old))
    old_sed = struct2cell(sediment_features_handles_old);
    [row,~] = size(old_sed);
    if(row>26)
        old_sed = old_sed(26:end,:);
    end
else
    old_sed = sediment_features_handles_old;
end
if(~isequal(handles.workpath,'no_path'))
    handles.sediment_open = 1;
    guidata(hObject, handles);
    h = sediment_features(0,handles.workpath);
    handles.sediment_open = 0;
else
    uiwait(msgbox('请先设置工作路径！','错误','error'));
    return;
end
if(~isempty(sediment_features_handles_old))
    new_sed = struct2cell(sediment_features_handles_old);
    new_sed = new_sed(26:end,:);
else
    new_sed = sediment_features_handles_old;
end
if (~isequal(old_sed,new_sed))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of sediment_call_button


% --- Executes on button press in wave_call_button.
function wave_call_button_Callback(hObject, eventdata, handles)
% hObject    handle to wave_call_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wave_handles_old;
if(~isempty(wave_handles_old))
    old_wave = struct2cell(wave_handles_old);
    [row,~] = size(old_wave);
    if(row>71)
        old_wave = old_wave(71:end,:);
    end
else
    old_wave = wave_handles_old;
end
if (~isequal(handles.workpath,'no_path'))
    if(isequal(handles.claculation_content_status(3),1)||isequal(handles.claculation_content_status(5),1)||isequal(handles.claculation_content_status(6),1))
        state_lis_cn = {'年','月','日','时'};
        state_list = {'year_start','month_start','day_start','hour_start','year_end',...
            'month_end','day_end','hour_end','Dt','C_year','C_month' ,'C_day' ,'C_hour' ,'C_delta_t'};
        
        un_set_index = find(~handles.generate_control_file_button_state(1:14),1,'first');
        if(~isempty(un_set_index))
            if(un_set_index >= 1 && un_set_index <= 4)
                eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
                eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
                msg = ['请先设置计算控制：计算控制->计算开始时间->','“',state_lis_cn{un_set_index},'”','未设置或设置有误'];
                uiwait(msgbox(msg,'错误','error'));
            elseif(un_set_index >= 5 && un_set_index <= 8)
                eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
                eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
                msg = ['请先设置计算控制：计算控制->结束时间->','“',state_lis_cn{un_set_index-4},'”','未设置或设置有误，请先设置计算控制！'];
                uiwait(msgbox(msg,'错误','error'));
            elseif(isequal(un_set_index,9))
                eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
                eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
                uiwait(msgbox('请先设置计算控制：计算控制->“时间步长”未设置或设置有误，请先设置计算控制！','错误','error'));
            elseif(un_set_index >= 10 && un_set_index <= 13)
                eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
                eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
                msg = ['请先设置存储控制：通讯文件->开始时间->','“',state_lis_cn{un_set_index-9},'”','未设置或设置有误，请先设置计算控制！'];
                uiwait(msgbox(msg,'错误','error'));
            elseif(isequal(un_set_index,14))
                eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
                eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
                uiwait(msgbox('请先设置储存控制：通讯文件->“时间步长”未设置或设置有误，请先设置计算控制！','错误','error'));
            end
            return
        else
            begin_time = datetime(handles.year_start,handles.month_start,handles.day_start,handles.hour_start,...
                handles.min_start,handles.sec_start);
            end_time = datetime(handles.year_end,handles.month_end,handles.day_end,handles.hour_end,...
                handles.min_end,handles.sec_end);
            if(begin_time >= end_time)
                uiwait(msgbox('开始计算时间必须小于结束计算的时间！','错误','error'));
                uicontrol(handles.year_start_input);
                return;
            else
                itdate = [num2str(handles.year_start),'-',num2str(handles.month_start,'%02d'),'-',num2str(handles.day_start,'%02d')];
                handles.wave_open = 1;
                guidata(hObject, handles);
                handles.wave_grid_index = wave(0,handles.workpath,handles.water_path,handles.claculation_content_status,handles.C_delta_t,itdate);
                handles.wave_open = 0;
            end
        end
    else
        itdate = '';
        handles.wave_open = 1;
        guidata(hObject, handles);
        handles.wave_grid_index = wave(0,handles.workpath,handles.water_path,handles.claculation_content_status,handles.C_delta_t,itdate);
        handles.wave_open = 0;
    end
else
    uiwait(msgbox('请先设置工作路径！','错误','error'));
    return;
end
if(~isempty(wave_handles_old))
    new_wave = struct2cell(wave_handles_old);
    new_wave = new_wave(71:end,:);
else
    new_wave = wave_handles_old;
end
if (~isequal(old_wave,new_wave))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of wave_call_button


% --- Executes on button press in caculation_button.
function caculation_button_Callback(hObject, eventdata, handles)
% hObject    handle to caculation_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of caculation_button
if(isequal(handles.claculation_content_status(2),1))
    [wave_check_result,error_type] = main_GUI_wave_check(handles);
    if (isequal(wave_check_result,0))
        if (isequal(error_type,1))
            uicontrol(handles.per_process_call_buttom);
            per_process_call_buttom_Callback(hObject, eventdata, handles)
            handles=guidata(hObject);
            return;
        elseif (isequal(error_type,2))
            uicontrol(handles.wave_call_button);
            wave_call_button_Callback(hObject, eventdata, handles)
            handles=guidata(hObject);
            return;
        end
    end
end
if(isequal(get(handles.save_file,'Enable'),'on'))
    uiwait(msgbox('请先保存设置','警告','warn'));
    return;
else
    is_run_dat = struct2cell(dir([handles.workpath,'\*.dat']))';
    is_run_def = struct2cell(dir([handles.workpath,'\*.def']))';
    if(~isempty(is_run_dat)||~isempty(is_run_def))
        msg = {'计算结果已存在！';'是否覆盖计算结果：';...
            '是：覆盖之前的计算结果';...
            '否：新建工作路径并计算'};
        button = questdlg(msg,'Info','否','是','是');
        if (button == '是')
            delete([handles.workpath,'\*.dat']) ;
            delete([handles.workpath,'\*.def']);
            main_GUI_run(handles);
        else
            pathname = uigetdir('*.*','请选择另存为路径');
            if(isequal(pathname,0))
                return;
            else
                if(isequal(pathname,handles.workpath))
                    uiwait(msgbox('新路径与原路径相同','警告','warn'));
                    return
                else
                    old_path = handles.workpath;
                    handles.workpath = pathname;
                    global main_handles_old;
                    main_handles_old = handles;
                    global per_process_handles_old;
                    global wave_handles_old;
                    global sediment_features_handles_old;
                    global observation_point_handle_old;
                    temp_main = [fieldnames(main_handles_old),struct2cell(main_handles_old)];
                    temp_main = temp_main(113:end,:);
                    if(~isempty(per_process_handles_old))
                        temp_per = [fieldnames(per_process_handles_old),struct2cell(per_process_handles_old)];
                        temp_per = temp_per(102:end,:);
                    else
                        temp_per = {};
                    end
                    if(~isempty(wave_handles_old))
                        temp_wave = [fieldnames(wave_handles_old),struct2cell(wave_handles_old)];
                        temp_wave = temp_wave(71:end,:);
                    else
                        temp_wave = {};
                    end
                    if(~isempty(sediment_features_handles_old))
                        temp_sediment = [fieldnames(sediment_features_handles_old),struct2cell(sediment_features_handles_old)];
                        temp_sediment = temp_sediment(26:end,:);
                    else
                        temp_sediment = {};
                    end
                    if(~isempty(observation_point_handle_old))
                        temp_obs = [fieldnames(observation_point_handle_old),struct2cell(observation_point_handle_old)];
                        temp_obs = temp_obs(8:end,:);
                    else
                        temp_obs = {};
                    end
                    all_handles = {temp_main,temp_per,temp_wave,temp_sediment,temp_obs};
                    name = strsplit(handles.workpath,'\');
                    name = name{end};
                    save([handles.workpath,'\',name,'.mat'],'all_handles');
                    flow_files = struct2cell(dir([old_path,'\1.*']));
                    wave_files = struct2cell(dir([old_path,'\wave.*']));
                    layer_file = struct2cell(dir([old_path,'\layer']));
                    xml_file = struct2cell(dir([old_path,'\config_d_hydro.xml']));
                    bat_file = struct2cell(dir([old_path,'\run.bat']));
                    if(~isempty(flow_files))
                        file_name = flow_files(1,:);
                        for i = 1:length(file_name)
                            copyfile([old_path,'/',file_name{i}],handles.workpath);
                        end
                    end
                    if(~isempty(wave_files))
                        file_name = wave_files(1,:);
                        for i = 1:length(file_name)
                            copyfile([old_path,'/',file_name{i}],handles.workpath);
                        end
                    end
                    if(~isempty(layer_file))
                        copyfile([old_path,'/',layer_file{1}],handles.workpath);
                    end
                    if(~isempty(xml_file))
                        copyfile([old_path,'/',xml_file{1}],handles.workpath);
                    end
                    if(~isempty(bat_file))
                        copyfile([old_path,'/',bat_file{1}],handles.workpath);
                    end
                    main_GUI_run(handles);
                end
            end
        end
    else
        main_GUI_run(handles);
    end
end
guidata(hObject, handles);



function year_start_input_Callback(hObject, eventdata, handles)
% hObject    handle to year_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of year_start_input as text
%        str2double(get(hObject,'String')) returns contents of year_start_input as a double
old_value = handles.year_start;
handles.year_start = str2double(get(hObject,'String'));
handles = main_GUI_year_check({'year_start','month_start','day_start'},hObject,handles );
if (~isequal(old_value,handles.year_start))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function year_start_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to year_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function month_start_input_Callback(hObject, eventdata, handles)
% hObject    handle to month_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of month_start_input as text
%        str2double(get(hObject,'String')) returns contents of month_start_input as a double
old_value = handles.month_start;
handles.month_start = str2double(get(hObject,'String'));
handles = main_GUI_month_check({'year_start','month_start','day_start'},hObject,handles);
if (~isequal(old_value,handles.month_start))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function month_start_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to month_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function day_start_input_Callback(hObject, eventdata, handles)
% hObject    handle to day_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of day_start_input as text
%        str2double(get(hObject,'String')) returns contents of day_start_input as a double
old_value = handles.day_start;
handles.day_start = str2double(get(hObject,'String'));
handles = main_GUI_day_check({'year_start','month_start','day_start'},hObject,handles);
if (~isequal(old_value,handles.day_start))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function day_start_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to day_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hour_start_input_Callback(hObject, eventdata, handles)
% hObject    handle to hour_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of hour_start_input as text
%        str2double(get(hObject,'String')) returns contents of hour_start_input as a double
old_value = handles.hour_start;
handles.hour_start = str2double(get(hObject,'String'));
handles = main_GUI_hour_check('hour_start',hObject,handles);
if (~isequal(old_value,handles.hour_start))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function hour_start_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hour_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_start_input_Callback(hObject, eventdata, handles)
% hObject    handle to min_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of min_start_input as text
%        str2double(get(hObject,'String')) returns contents of min_start_input as a double
old_value = handles.min_start;
handles.min_start = str2double(get(hObject,'String'));
handles = main_GUI_min_sec_check('min_start',hObject,handles);
if (~isequal(old_value,handles.min_start))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function min_start_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sec_start_input_Callback(hObject, eventdata, handles)
% hObject    handle to sec_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of sec_start_input as text
%        str2double(get(hObject,'String')) returns contents of sec_start_input as a double
old_value = handles.sec_start;
handles.sec_start = str2double(get(hObject,'String'));
handles = main_GUI_min_sec_check('sec_start',hObject,handles);
if (~isequal(old_value,handles.sec_start))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sec_start_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sec_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function year_end_input_Callback(hObject, eventdata, handles)
% hObject    handle to year_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of year_end_input as text
%        str2double(get(hObject,'String')) returns contents of year_end_input as a double
old_value = handles.year_end;
handles.year_end = str2double(get(hObject,'String'));
handles = main_GUI_year_check({'year_end','month_end','day_end'},hObject,handles );
if (~isequal(old_value,handles.year_end))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function year_end_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to year_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function month_end_input_Callback(hObject, eventdata, handles)
% hObject    handle to month_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of month_end_input as text
%        str2double(get(hObject,'String')) returns contents of month_end_input as a double
old_value = handles.month_end;
handles.month_end = str2double(get(hObject,'String'));
handles = main_GUI_month_check({'year_end','month_end','day_end'},hObject,handles );
if (~isequal(old_value,handles.month_end))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function month_end_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to month_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function day_end_input_Callback(hObject, eventdata, handles)
% hObject    handle to day_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of day_end_input as text
%        str2double(get(hObject,'String')) returns contents of day_end_input as a double
old_value = handles.day_end;
handles.day_end = str2double(get(hObject,'String'));
handles = main_GUI_day_check({'year_end','month_end','day_end'},hObject,handles );
if (~isequal(old_value,handles.day_end))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function day_end_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to day_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hour_end_input_Callback(hObject, eventdata, handles)
% hObject    handle to hour_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of hour_end_input as text
%        str2double(get(hObject,'String')) returns contents of hour_end_input as a double
old_value = handles.hour_end;
handles.hour_end = str2double(get(hObject,'String'));
handles = main_GUI_hour_check('hour_end',hObject,handles );
if (~isequal(old_value,handles.hour_end))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function hour_end_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hour_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_end_input_Callback(hObject, eventdata, handles)
% hObject    handle to min_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of min_end_input as text
%        str2double(get(hObject,'String')) returns contents of min_end_input as a double
old_value = handles.min_end;
handles.min_end = str2double(get(hObject,'String'));
handles = main_GUI_min_sec_check('min_end',hObject,handles );
if (~isequal(old_value,handles.min_end))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function min_end_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sec_end_input_Callback(hObject, eventdata, handles)
% hObject    handle to sec_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of sec_end_input as text
%        str2double(get(hObject,'String')) returns contents of sec_end_input as a double
old_value = handles.sec_end;
handles.sec_end = str2double(get(hObject,'String'));
handles = main_GUI_min_sec_check('sec_end',hObject,handles );
if (~isequal(old_value,handles.sec_end))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sec_end_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sec_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dt_input_Callback(hObject, eventdata, handles)
% hObject    handle to Dt_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Dt_input as text
%        str2double(get(hObject,'String')) returns contents of Dt_input as a double
old_value = handles.Dt;
handles.Dt = str2double(get(hObject,'String'));
if(isnan(handles.Dt))
    handles.Dt = NaN;
    handles.generate_control_file_button_state(9) = 0;
    if(~isempty(get(hObject,'String')))
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        uicontrol(handles.Dt_input);
    end
elseif(handles.Dt <= 0)
    set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
    handles.Dt = NaN;
    handles.generate_control_file_button_state(9) = 0;
    uiwait(msgbox('计算的时间步长必须大于0','错误','error'));
    uicontrol(handles.Dt_input);
else
    set(hObject,'Backgroundcolor','w');
    handles.generate_control_file_button_state(9) = 1;
end
if (~isequal(old_value,handles.Dt))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Dt_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dt_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function G_year_input_Callback(hObject, eventdata, handles)
% hObject    handle to G_year_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of G_year_input as text
%        str2double(get(hObject,'String')) returns contents of G_year_input as a double
old_value = handles.G_year;
handles.G_year = str2double(get(hObject,'String'));
handles = main_GUI_year_check({'G_year','G_month','G_day'},hObject,handles );
if (~isequal(old_value,handles.G_year))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function G_year_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to G_year_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function G_month_input_Callback(hObject, eventdata, handles)
% hObject    handle to G_month_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of G_month_input as text
%        str2double(get(hObject,'String')) returns contents of G_month_input as a double
old_value = handles.G_month;
handles.G_month = str2double(get(hObject,'String'));
handles = main_GUI_month_check({'G_year','G_month','G_day'},hObject,handles );
if (~isequal(old_value,handles.G_month))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function G_month_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to G_month_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function G_day_input_Callback(hObject, eventdata, handles)
% hObject    handle to G_day_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of G_day_input as text
%        str2double(get(hObject,'String')) returns contents of G_day_input as a double
old_value = handles.G_day;
handles.G_day = str2double(get(hObject,'String'));
handles = main_GUI_day_check({'G_year','G_month','G_day'},hObject,handles );
if (~isequal(old_value,handles.G_day))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function G_day_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to G_day_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function G_hour_input_Callback(hObject, eventdata, handles)
% hObject    handle to G_hour_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of G_hour_input as text
%        str2double(get(hObject,'String')) returns contents of G_hour_input as a double
old_value = handles.G_hour;
handles.G_hour = str2double(get(hObject,'String'));
handles = main_GUI_hour_check('G_hour',hObject,handles );
if (~isequal(old_value,handles.G_hour))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function G_hour_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to G_hour_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function G_min_input_Callback(hObject, eventdata, handles)
% hObject    handle to G_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of G_min_input as text
%        str2double(get(hObject,'String')) returns contents of G_min_input as a double
old_value = handles.G_min;
handles.G_min = str2double(get(hObject,'String'));
handles = main_GUI_min_sec_check('G_min',hObject,handles );
if (~isequal(old_value,handles.G_min))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function G_min_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to G_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function G_sec_input_Callback(hObject, eventdata, handles)
% hObject    handle to G_sec_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of G_sec_input as text
%        str2double(get(hObject,'String')) returns contents of G_sec_input as a double
old_value = handles.G_sec;
handles.G_sec = str2double(get(hObject,'String'));
handles = main_GUI_min_sec_check('G_sec',hObject,handles );
if (~isequal(old_value,handles.G_sec))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function G_sec_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to G_sec_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function G_delta_t_input_Callback(hObject, eventdata, handles)
% hObject    handle to G_delta_t_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of G_delta_t_input as text
%        str2double(get(hObject,'String')) returns contents of G_delta_t_input as a double
old_value = handles.G_delta_t;
handles.G_delta_t = str2double(get(hObject,'String'));
if(isnan(handles.G_delta_t))
    handles.G_delta_t = NaN;
    handles.generate_control_file_button_state(14) = 0;
    if(~isempty(get(hObject,'String')))
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        uicontrol(handles.G_delta_t_input);
    end
elseif(handles.G_delta_t <= 0)
    handles.G_delta_t = NaN;
    handles.generate_control_file_button_state(14) = 0;
    set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
    uiwait(msgbox('储存的时间步长必须大于0','错误','error'));
    uicontrol(handles.G_delta_t_input);
else
    set(hObject,'Backgroundcolor','w');
    handles.generate_control_file_button_state(14) = 1;
end
if (~isequal(old_value,handles.G_delta_t))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function G_delta_t_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to G_delta_t_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function O_year_input_Callback(hObject, eventdata, handles)
% hObject    handle to O_year_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of O_year_input as text
%        str2double(get(hObject,'String')) returns contents of O_year_input as a double
old_value = handles.O_year;
handles.O_year = str2double(get(hObject,'String'));
handles = main_GUI_year_check({'O_year','O_month','O_day'},hObject,handles );
if (~isequal(old_value,handles.O_year))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function O_year_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to O_year_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function O_month_input_Callback(hObject, eventdata, handles)
% hObject    handle to O_month_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of O_month_input as text
%        str2double(get(hObject,'String')) returns contents of O_month_input as a double
old_value = handles.O_month;
handles.O_month = str2double(get(hObject,'String'));
handles = main_GUI_month_check({'O_year','O_month','O_day'},hObject,handles );
if (~isequal(old_value,handles.O_month))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function O_month_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to O_month_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function O_day_input_Callback(hObject, eventdata, handles)
% hObject    handle to O_day_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of O_day_input as text
%        str2double(get(hObject,'String')) returns contents of O_day_input as a double
old_value = handles.O_day;
handles.O_day = str2double(get(hObject,'String'));
handles = main_GUI_day_check({'O_year','O_month','O_day'},hObject,handles );
if (~isequal(old_value,handles.O_day))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function O_day_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to O_day_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function O_hour_input_Callback(hObject, eventdata, handles)
% hObject    handle to O_hour_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of O_hour_input as text
%        str2double(get(hObject,'String')) returns contents of O_hour_input as a double
old_value = handles.O_hour;
handles.O_hour = str2double(get(hObject,'String'));
handles = main_GUI_hour_check('O_hour',hObject,handles );
if (~isequal(old_value,handles.O_hour))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function O_hour_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to O_hour_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function O_min_input_Callback(hObject, eventdata, handles)
% hObject    handle to O_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of O_min_input as text
%        str2double(get(hObject,'String')) returns contents of O_min_input as a double
old_value = handles.O_min;
handles.O_min = str2double(get(hObject,'String'));
handles = main_GUI_min_sec_check('O_min',hObject,handles );
if (~isequal(old_value,handles.O_min))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function O_min_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to O_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function O_sec_input_Callback(hObject, eventdata, handles)
% hObject    handle to O_sec_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of O_sec_input as text
%        str2double(get(hObject,'String')) returns contents of O_sec_input as a double
old_value = handles.O_sec;
handles.O_sec = str2double(get(hObject,'String'));
handles = main_GUI_min_sec_check('O_sec',hObject,handles );
if (~isequal(old_value,handles.O_sec))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function O_sec_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to O_sec_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function O_delta_t_input_Callback(hObject, eventdata, handles)
% hObject    handle to O_delta_t_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of O_delta_t_input as text
%        str2double(get(hObject,'String')) returns contents of O_delta_t_input as a double
old_value = handles.O_delta_t;
handles.O_delta_t = str2double(get(hObject,'String'));
if(isnan(handles.O_delta_t))
    handles.O_delta_t = NaN;
    handles.generate_control_file_button_state(19) = 0;
    if(~isempty(get(hObject,'String')))
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        uicontrol(handles.O_delta_t_input);
    end
elseif(handles.O_delta_t <= 0)
    handles.O_delta_t = NaN;
    handles.generate_control_file_button_state(19) = 0;
    set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
    uiwait(msgbox('计算的时间步长必须大于0','错误','error'));
    uicontrol(handles.O_delta_t_input);
else
    set(hObject,'Backgroundcolor','w');
    handles.generate_control_file_button_state(19) = 1;
end
if (~isequal(old_value,handles.O_delta_t))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function O_delta_t_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to O_delta_t_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_year_input_Callback(hObject, eventdata, handles)
% hObject    handle to C_year_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of C_year_input as text
%        str2double(get(hObject,'String')) returns contents of C_year_input as a double
old_value = handles.C_year;
handles.C_year = str2double(get(hObject,'String'));
handles = main_GUI_year_check({'C_year','C_month','C_day'},hObject,handles );
if (~isequal(old_value,handles.C_year))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function C_year_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_year_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_month_input_Callback(hObject, eventdata, handles)
% hObject    handle to C_month_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of C_month_input as text
%        str2double(get(hObject,'String')) returns contents of C_month_input as a double
old_value = handles.C_month;
handles.C_month = str2double(get(hObject,'String'));
handles = main_GUI_month_check({'C_year','C_month','C_day'},hObject,handles );
if (~isequal(old_value,handles.C_month))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function C_month_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_month_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_day_input_Callback(hObject, eventdata, handles)
% hObject    handle to C_day_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of C_day_input as text
%        str2double(get(hObject,'String')) returns contents of C_day_input as a double
old_value = handles.C_day;
handles.C_day = str2double(get(hObject,'String'));
handles = main_GUI_day_check({'C_year','C_month','C_day'},hObject,handles );
if (~isequal(old_value,handles.C_day))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function C_day_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_day_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_hour_input_Callback(hObject, eventdata, handles)
% hObject    handle to C_hour_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of C_hour_input as text
%        str2double(get(hObject,'String')) returns contents of C_hour_input as a double
old_value = handles.C_hour;
handles.C_hour = str2double(get(hObject,'String'));
handles = main_GUI_hour_check('C_hour',hObject,handles );
if (~isequal(old_value,handles.C_hour))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function C_hour_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_hour_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_min_input_Callback(hObject, eventdata, handles)
% hObject    handle to C_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of C_min_input as text
%        str2double(get(hObject,'String')) returns contents of C_min_input as a double
old_value = handles.C_min;
handles.C_min = str2double(get(hObject,'String'));
handles = main_GUI_min_sec_check('C_min',hObject,handles );
if (~isequal(old_value,handles.C_min))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function C_min_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_sec_input_Callback(hObject, eventdata, handles)
% hObject    handle to C_sec_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of C_sec_input as text
%        str2double(get(hObject,'String')) returns contents of C_sec_input as a double
old_value = handles.C_sec;
handles.C_sec = str2double(get(hObject,'String'));
handles = main_GUI_min_sec_check('C_sec',hObject,handles );
if (~isequal(old_value,handles.C_sec))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function C_sec_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_sec_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_delta_t_input_Callback(hObject, eventdata, handles)
% hObject    handle to C_delta_t_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of C_delta_t_input as text
%        str2double(get(hObject,'String')) returns contents of C_delta_t_input as a double
old_value = handles.C_delta_t;
handles.C_delta_t = str2double(get(hObject,'String'));
if(isnan(handles.C_delta_t))
    handles.C_delta_t = NaN;
    handles.generate_control_file_button_state(24) = 0;
    if(~isempty(get(hObject,'String')))
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        uicontrol(handles.C_delta_t_input);
    end
elseif(handles.C_delta_t <= 0)
    handles.C_delta_t = NaN;
    handles.generate_control_file_button_state(24) = 0;
    set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
    uiwait(msgbox('计算的时间步长必须大于0','错误','error'));
    uicontrol(handles.C_delta_t_input);
else
    set(hObject,'Backgroundcolor','w');
    handles.generate_control_file_button_state(24) = 1;
end
if (~isequal(old_value,handles.C_delta_t))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function C_delta_t_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_delta_t_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in generate_control_file_button.
function generate_control_file_button_Callback(hObject, eventdata, handles)
% hObject    handle to generate_control_file_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of generate_control_file_button
state_lis_cn = {'年','月','日','时'};
state_list = {'year_start','month_start','day_start','hour_start','year_end',...
    'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
    'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour' ,'C_delta_t'};

un_set_index = find(~handles.generate_control_file_button_state(1:14),1,'first');
if(~isempty(un_set_index))
    if(un_set_index >= 1 && un_set_index <= 4)
        eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
        eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
        msg = ['计算控制->计算开始时间->','“',state_lis_cn{un_set_index},'”','未设置或设置有误，请前往设置！'];
        uiwait(msgbox(msg,'错误','error'));
    elseif(un_set_index >= 5 && un_set_index <= 8)
        eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
        eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
        msg = ['计算控制->结束时间->','“',state_lis_cn{un_set_index-4},'”','未设置或设置有误，请前往设置！'];
        uiwait(msgbox(msg,'错误','error'));
    elseif(isequal(un_set_index,9))
        eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
        eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
        uiwait(msgbox('计算控制->“时间步长”未设置或设置有误，请前往设置！','错误','error'));
    elseif(un_set_index >= 10 && un_set_index <= 13)
        eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
        eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
        msg = ['存储控制->全局->开始记录时间->','“',state_lis_cn{un_set_index-9},'”','未设置或设置有误，请前往设置！'];
        uiwait(msgbox(msg,'错误','error'));
    elseif(isequal(un_set_index,14))
        eval(['set(handles.',state_list{un_set_index},'_input,','''Backgroundcolor''',',','[0.8,0.2,0.2]);']);
        eval(['uicontrol(handles.',state_list{un_set_index},'_input)']);
        uiwait(msgbox('存储控制->全局->“时间步长”未设置或设置有误，请前往设置！','错误','error'));
    end
    return;
end
if (isequal(handles.claculation_content_status(1),1))
    per_check_result =  main_GUI_per_check(handles);
    if (isequal(per_check_result,0))
        uicontrol(handles.per_process_call_buttom);
        per_process_call_buttom_Callback(hObject, eventdata, handles)
        handles=guidata(hObject);
        return;
    end
    obs_check_result = main_GUI_obs_check(handles);
    if (isequal(obs_check_result,0))
        return;
    end
end
if(isequal(handles.claculation_content_status(3),1))
    per_check_result =  main_GUI_per_check(handles);
    if (isequal(per_check_result,0))
        uicontrol(handles.per_process_call_buttom);
        per_process_call_buttom_Callback(hObject, eventdata, handles)
        handles=guidata(hObject);
        return;
    end
    [wave_check_result,error_type] = main_GUI_wave_check(handles);
    if (isequal(wave_check_result,0))
        if (isequal(error_type,1))
            uicontrol(handles.per_process_call_buttom);
            per_process_call_buttom_Callback(hObject, eventdata, handles)
            handles=guidata(hObject);
            return;
        elseif (isequal(error_type,2))
            uicontrol(handles.wave_call_button);
            wave_call_button_Callback(hObject, eventdata, handles)
            handles=guidata(hObject);
            return;
        end
    end
    obs_check_result = main_GUI_obs_check(handles);
    if (isequal(obs_check_result,0))
        return;
    end
    connect_check_result = main_GUI_connect_check(handles);
    if (isequal(connect_check_result,0))
        return;
    end
end
if(isequal(handles.claculation_content_status(4),1))
    per_check_result =  main_GUI_per_check(handles);
    if (isequal(per_check_result,0))
        uicontrol(handles.per_process_call_buttom);
        per_process_call_buttom_Callback(hObject, eventdata, handles)
        handles=guidata(hObject);
        return;
    end
    sediment_check_result = main_GUI_sediment_check(handles);
    if(isequal(sediment_check_result,0))
        uicontrol(handles.sediment_call_button);
        sediment_call_button_Callback(hObject, eventdata, handles)
        handles=guidata(hObject);
        return;
    end
    obs_check_result = main_GUI_obs_check(handles);
    if (isequal(obs_check_result,0))
        return;
    end
end
if(isequal(handles.claculation_content_status(5),1))
    per_check_result =  main_GUI_per_check(handles);
    if (isequal(per_check_result,0))
        uicontrol(handles.per_process_call_buttom);
        per_process_call_buttom_Callback(hObject, eventdata, handles)
        handles=guidata(hObject);
        return;
    end
    sediment_check_result = main_GUI_sediment_check(handles);
    if(isequal(sediment_check_result,0))
        uicontrol(handles.sediment_call_button);
        sediment_call_button_Callback(hObject, eventdata, handles)
        handles=guidata(hObject);
        return;
    end
    [wave_check_result,error_type] = main_GUI_wave_check(handles);
    if (isequal(wave_check_result,0))
        if (isequal(error_type,1))
            uicontrol(handles.per_process_call_buttom);
            per_process_call_buttom_Callback(hObject, eventdata, handles)
            handles=guidata(hObject);
            return;
        elseif (isequal(error_type,2))
            uicontrol(handles.wave_call_button);
            wave_call_button_Callback(hObject, eventdata, handles)
            handles=guidata(hObject);
            return;
        end
    end
end
if(isequal(handles.claculation_content_status(6),1))
    per_check_result =  main_GUI_per_check(handles);
    if (isequal(per_check_result,0))
        uicontrol(handles.per_process_call_buttom);
        per_process_call_buttom_Callback(hObject, eventdata, handles)
        handles=guidata(hObject);
        return;
    end
    sediment_check_result = main_GUI_sediment_check(handles);
    if(isequal(sediment_check_result,0))
        uicontrol(handles.sediment_call_button);
        sediment_call_button_Callback(hObject, eventdata, handles)
        handles=guidata(hObject);
        return;
    end
    [wave_check_result,error_type] = main_GUI_wave_check(handles);
    if (isequal(wave_check_result,0))
        if (isequal(error_type,1))
            uicontrol(handles.per_process_call_buttom);
            per_process_call_buttom_Callback(hObject, eventdata, handles)
            handles=guidata(hObject);
            return;
        elseif (isequal(error_type,2))
            uicontrol(handles.wave_call_button);
            wave_call_button_Callback(hObject, eventdata, handles)
            handles=guidata(hObject);
            return;
        end
    end
    obs_check_result = main_GUI_obs_check(handles);
    if (isequal(obs_check_result,0))
        return;
    end
    connect_check_result = main_GUI_connect_check(handles);
    if (isequal(connect_check_result,0))
        return;
    end
end

begin_time = datetime(handles.year_start,handles.month_start,handles.day_start,handles.hour_start,...
    handles.min_start,handles.sec_start);
end_time = datetime(handles.year_end,handles.month_end,handles.day_end,handles.hour_end,...
    handles.min_end,handles.sec_end);
G_begin_time = datetime(handles.G_year,handles.G_month,handles.G_day,handles.G_hour,...
    handles.G_min,handles.G_sec);
O_begin_time = datetime(handles.O_year,handles.O_month,handles.O_day,handles.O_hour,...
    handles.O_min,handles.O_sec);
if(begin_time >= end_time)
    uiwait(msgbox('开始计算时间必须小于结束计算的时间！','错误','error'));
    uicontrol(handles.year_start_input);
    return;
elseif(G_begin_time < begin_time || G_begin_time >= end_time)
    uiwait(msgbox('全局开始记录时间必须介于开始计算时间和结束计算时间之间，且不能等于结束计算时间！','错误','error'));
    uicontrol(handles.G_year_input);
    return;
elseif(O_begin_time < begin_time || O_begin_time >= end_time)
    uiwait(msgbox('监控点开始记录时间必须介于开始计算时间和结束计算时间之间，且不能等于结束计算时间！','错误','error'));
    uicontrol(handles.O_year_input);
    return;
end
mdf_file_status = main_GUI_generate_mdf(handles);
if (isequal(mdf_file_status,0))
    set(handles.caculation_button,'Enable','on');
    handles.caculation_button_state = 1;
    uiwait(msgbox('主控制文件生成成功','提示','help'));
else
    set(handles.caculation_button,'Enable','off');
    handles.caculation_button_state = 0;
    uiwait(msgbox('主控制文件生成失败！','错误','error'));
end
guidata(hObject, handles);



% --- Executes when user attempts to close main_fig.
function main_fig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to main_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
open_index = [handles.configuration_open,handles.per_process_open,handles.wave_open,handles.sediment_open,handles.post_open];
if(ismember(1,open_index))
    uiwait(msgbox('请先关闭所有子窗口！','错误','error'));
    return;
end
if(isequal(get(handles.save_file,'Enable'),'on'))
    msg = {'设置已更新，是否保存'};
    button = questdlg(msg,'Info','否','是','是');
    if (button == '是')
        save_file_Callback(hObject, eventdata, handles);
        handles = guidata(hObject);
    end
end
clear global;
uiresume(handles.main_fig);




% --- Executes on button press in per_process_radio.
function per_process_radio_Callback(hObject, eventdata, handles)
% hObject    handle to per_process_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of per_process_radio
old_value = handles.claculation_content_status;
handles.claculation_content_status = zeros(size(handles.claculation_content_status));
handles.claculation_content_status(1) = get(hObject,'Value');
if(isequal(handles.claculation_content_status(1),1))
    set(handles.per_process_call_buttom,'Enable','on');
    set(handles.sediment_call_button,'Enable','off');
    set(handles.wave_call_button,'Enable','off');
    state_list = {'year_start','month_start','day_start','hour_start','year_end',...
        'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
        'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour' ,'C_delta_t'};
    ms_state_list = {'min_start','sec_start','min_end','sec_end','G_min','G_sec',...
        'O_min','O_sec','C_min','C_sec'};
    if(~isequal(handles.workpath,'no_path'))
        set(handles.generate_control_file_button,'Enable','on');
        set(handles.caculation_button,'Enable','off');
        for i = 1:19
            temp = eval(['handles.',state_list{i}]);
            if(~isnan(temp))
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','num2str(handles.',state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','''''',',','''Enable''',',','''on''',');'])
            end
        end
        for i = 20:24
            eval(['set(handles.',state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''off''',');'])
        end
        for i = 1:8
            temp = eval(['handles.',ms_state_list{i}]);
            if(~isequal(temp,0))
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','num2str(handles.',ms_state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''on''',');'])
            end
        end
        for i = 9:10
            eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''off''',');'])
        end
    else
        set(handles.generate_control_file_button,'Enable','off');
        set(handles.caculation_button,'Enable','off');
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
    end
    handles.C_year = 0;
    handles.C_month = 0;
    handles.C_day = 0;
    handles.C_hour = 0;
    handles.C_min = 0;
    handles.C_sec = 0;
    handles.C_delta_t = 0;
end
if (~isequal(old_value,handles.claculation_content_status))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes on button press in wave_radio.
function wave_radio_Callback(hObject, eventdata, handles)
% hObject    handle to wave_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of wave_radio
old_value = handles.claculation_content_status;
handles.claculation_content_status = zeros(size(handles.claculation_content_status));
handles.claculation_content_status(2) = get(hObject,'Value');
if(isequal(handles.claculation_content_status(2),1))
    set(handles.per_process_call_buttom,'Enable','off');
    set(handles.sediment_call_button,'Enable','off');
    set(handles.wave_call_button,'Enable','on');
    state_list = {'year_start','month_start','day_start','hour_start','year_end',...
        'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
        'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour' ,'C_delta_t'};
    ms_state_list = {'min_start','sec_start','min_end','sec_end','G_min','G_sec',...
        'O_min','O_sec','C_min','C_sec'};
    if(~isequal(handles.workpath,'no_path'))
        set(handles.generate_control_file_button,'Enable','off');
        set(handles.caculation_button,'Enable','on');
    else
        set(handles.generate_control_file_button,'Enable','off');
        set(handles.caculation_button,'Enable','off');
    end
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
    handles.wave_grid_index = 0;
    handles.C_year = 0;
    handles.C_month = 0;
    handles.C_day = 0;
    handles.C_hour = 0;
    handles.C_min = 0;
    handles.C_sec = 0;
    handles.C_delta_t = 0;
end
if (~isequal(old_value,handles.claculation_content_status))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes on button press in wave_pre_process_radio.
function wave_pre_process_radio_Callback(hObject, eventdata, handles)
% hObject    handle to wave_pre_process_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of wave_pre_process_radio
old_value = handles.claculation_content_status;
handles.claculation_content_status = zeros(size(handles.claculation_content_status));
handles.claculation_content_status(3) = get(hObject,'Value');
if(isequal(handles.claculation_content_status(3),1))
    set(handles.per_process_call_buttom,'Enable','on');
    set(handles.sediment_call_button,'Enable','off');
    set(handles.wave_call_button,'Enable','on');
    state_list = {'year_start','month_start','day_start','hour_start','year_end',...
        'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
        'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour' ,'C_delta_t'};
    ms_state_list = {'min_start','sec_start','min_end','sec_end','G_min','G_sec',...
        'O_min','O_sec','C_min','C_sec'};
    if (~isequal(handles.workpath,'no_path'))
        set(handles.generate_control_file_button,'Enable','on');
        set(handles.caculation_button,'Enable','off');
        for i = 1:19
            temp = eval(['handles.',state_list{i}]);
            if(~isnan(temp))
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','num2str(handles.',state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','''''',',','''Enable''',',','''on''',');'])
            end
        end
        for i = 20:24
            temp = eval(['handles.',state_list{i}]);
            if(~isequal(temp,0)&&~isequal(temp,0))
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','num2str(handles.',state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','''''',',','''Enable''',',','''on''',');'])
            end
        end 
        for i = 1:10
            temp = eval(['handles.',ms_state_list{i}]);
            if(~isequal(temp,0))
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','num2str(handles.',ms_state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''on''',');'])
            end
        end
    else
        set(handles.generate_control_file_button,'Enable','off');
        set(handles.caculation_button,'Enable','off');
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
    end
    handles.C_year = NaN;
    handles.C_month = NaN;
    handles.C_day = NaN;
    handles.C_hour = NaN;
    handles.C_min = 0;
    handles.C_sec = 0;
    handles.C_delta_t = NaN;
end
if (~isequal(old_value,handles.claculation_content_status))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes on button press in pre_process_sediment_redio.
function pre_process_sediment_redio_Callback(hObject, eventdata, handles)
% hObject    handle to pre_process_sediment_redio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of pre_process_sediment_redio
old_value = handles.claculation_content_status;
handles.claculation_content_status = zeros(size(handles.claculation_content_status));
handles.claculation_content_status(4) = get(hObject,'Value');
if(isequal(handles.claculation_content_status(4),1))
    set(handles.per_process_call_buttom,'Enable','on');
    set(handles.sediment_call_button,'Enable','on');
    set(handles.wave_call_button,'Enable','off');
    state_list = {'year_start','month_start','day_start','hour_start','year_end',...
        'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
        'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour' ,'C_delta_t'};
    ms_state_list = {'min_start','sec_start','min_end','sec_end','G_min','G_sec',...
        'O_min','O_sec','C_min','C_sec'};
    if(~isequal(handles.workpath,'no_path'))
        set(handles.generate_control_file_button,'Enable','on');
        set(handles.caculation_button,'Enable','off');
        for i = 1:19
            temp = eval(['handles.',state_list{i}]);
            if(~isnan(temp))
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','num2str(handles.',state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','''''',',','''Enable''',',','''on''',');'])
            end
        end
        for i = 20:24
            eval(['set(handles.',state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''off''',');'])
        end
        for i = 1:8
            temp = eval(['handles.',ms_state_list{i}]);
            if(~isequal(temp,0))
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','num2str(handles.',ms_state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''on''',');'])
            end
        end
        for i = 9:10
            eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''off''',');'])
        end
    else
        set(handles.generate_control_file_button,'Enable','off');
        set(handles.caculation_button,'Enable','off');
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
    end
    handles.C_year = 0;
    handles.C_month = 0;
    handles.C_day = 0;
    handles.C_hour = 0;
    handles.C_min = 0;
    handles.C_sec = 0;
    handles.C_delta_t = 0;
end
if (~isequal(old_value,handles.claculation_content_status))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes on button press in wave_sediment_radio.
function wave_sediment_radio_Callback(hObject, eventdata, handles)
% hObject    handle to wave_sediment_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of wave_sediment_radio
old_value = handles.claculation_content_status;
handles.claculation_content_status = zeros(size(handles.claculation_content_status));
handles.claculation_content_status(5) = get(hObject,'Value');
if(isequal(handles.claculation_content_status(5),1))
    set(handles.per_process_call_buttom,'Enable','on');
    set(handles.sediment_call_button,'Enable','on');
    set(handles.wave_call_button,'Enable','on');
    state_list = {'year_start','month_start','day_start','hour_start','year_end',...
        'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
        'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour' ,'C_delta_t'};
    ms_state_list = {'min_start','sec_start','min_end','sec_end','G_min','G_sec',...
        'O_min','O_sec','C_min','C_sec'};
    if(~isequal(handles.workpath,'no_path'))
        set(handles.generate_control_file_button,'Enable','on');
        set(handles.caculation_button,'Enable','off');
        for i = 1:19
            temp = eval(['handles.',state_list{i}]);
            if(~isnan(temp))
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','num2str(handles.',state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','''''',',','''Enable''',',','''on''',');'])
            end
        end
        for i = 20:24
            temp = eval(['handles.',state_list{i}]);
            if(~isnan(temp)&&~isequal(temp,0))
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','num2str(handles.',state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','''''',',','''Enable''',',','''on''',');'])
            end
        end 
        for i = 1:10
            temp = eval(['handles.',ms_state_list{i}]);
            if(~isequal(temp,0)&&~isequal(temp,0))
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','num2str(handles.',ms_state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''on''',');'])
            end
        end
    else
        set(handles.generate_control_file_button,'Enable','off');
        set(handles.caculation_button,'Enable','off');
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
    end
    handles.C_year = NaN;
    handles.C_month = NaN;
    handles.C_day = NaN;
    handles.C_hour = NaN;
    handles.C_min = 0;
    handles.C_sec = 0;
    handles.C_delta_t = NaN;
end
if (~isequal(old_value,handles.claculation_content_status))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes on button press in wave_per_sediment_radio.
function wave_per_sediment_radio_Callback(hObject, eventdata, handles)
% hObject    handle to wave_per_sediment_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of wave_per_sediment_radio
old_value = handles.claculation_content_status;
handles.claculation_content_status = zeros(size(handles.claculation_content_status));
handles.claculation_content_status(6) = get(hObject,'Value');
if(isequal(handles.claculation_content_status(6),1))
    set(handles.per_process_call_buttom,'Enable','on');
    set(handles.sediment_call_button,'Enable','on');
    set(handles.wave_call_button,'Enable','on');
    set(handles.generate_control_file_button,'Enable','on');
    set(handles.caculation_button,'Enable','off');
    state_list = {'year_start','month_start','day_start','hour_start','year_end',...
        'month_end','day_end','hour_end','Dt','G_year','G_month','G_day','G_hour','G_delta_t',...
        'O_year','O_month','O_day','O_hour','O_delta_t','C_year','C_month' ,'C_day' ,'C_hour' ,'C_delta_t'};
    ms_state_list = {'min_start','sec_start','min_end','sec_end','G_min','G_sec',...
        'O_min','O_sec','C_min','C_sec'};
    if(~isequal(handles.workpath,'no_path'))
        set(handles.generate_control_file_button,'Enable','on');
        set(handles.caculation_button,'Enable','off');
        for i = 1:19
            temp = eval(['handles.',state_list{i}]);
            if(~isnan(temp))
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','num2str(handles.',state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','''''',',','''Enable''',',','''on''',');'])
            end
        end
        for i = 20:24
            temp = eval(['handles.',state_list{i}]);
            if(~isnan(temp)&&~isequal(temp,0))
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','num2str(handles.',state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',state_list{i},'_input',',','''string''',',','''''',',','''Enable''',',','''on''',');'])
            end
        end 
        for i = 1:10
            temp = eval(['handles.',ms_state_list{i}]);
            if(~isequal(temp,0))
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','num2str(handles.',ms_state_list{i},')',',','''Enable''',',','''on''',');'])
            else
                eval(['set(handles.',ms_state_list{i},'_input',',','''string''',',','''00''',',','''Enable''',',','''on''',');'])
            end
        end
    else
        set(handles.generate_control_file_button,'Enable','off');
        set(handles.caculation_button,'Enable','off');
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
    end
    handles.C_year = NaN;
    handles.C_month = NaN;
    handles.C_day = NaN;
    handles.C_hour = NaN;
    handles.C_min = 0;
    handles.C_sec = 0;
    handles.C_delta_t = NaN;
end
if (~isequal(old_value,handles.claculation_content_status))
    if(~isequal(get(handles.save_file,'Enable'),'on'))
        set(handles.save_file,'Enable','on');
    end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function file_set_Callback(hObject, eventdata, handles)
% hObject    handle to file_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function configuration_Callback(hObject, eventdata, handles)
% hObject    handle to configuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.configuration_open = 1;
guidata(hObject, handles);
[handles.water_path,handles.comp_base_path] = configuration(0,handles.water_path,handles.comp_base_path);
handles.configuration_open = 0;
guidata(hObject, handles);

% --------------------------------------------------------------------
function new_set_Callback(hObject, eventdata, handles)
% hObject    handle to new_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname = uigetdir('*.*','请设置工作目录');
if (isequal(pathname,0))
    msgbox('您没有设置任何工作目录, 请重新设置!','Error','error');
    handles.workpath = 'no_path';
    return
else
    handles.workpath = pathname;
    clear global;
    set(handles.save_file,'Enable','on');
    set(handles.save_file_another,'Enable','on');
    set(handles.year_start_input,'string','','Enable','on');
    set(handles.month_start_input,'string','','Enable','on');
    set(handles.day_start_input,'string','','Enable','on');
    set(handles.hour_start_input,'string','','Enable','on');
    set(handles.min_start_input,'string','00','Enable','on');
    set(handles.sec_start_input,'string','00','Enable','on');
    set(handles.year_end_input,'string','','Enable','on');
    set(handles.month_end_input,'string','','Enable','on');
    set(handles.day_end_input,'string','','Enable','on');
    set(handles.hour_end_input,'string','','Enable','on');
    set(handles.min_end_input,'string','00','Enable','on');
    set(handles.sec_end_input,'string','00','Enable','on');
    set(handles.Dt_input,'string','','Enable','on');
    set(handles.G_year_input,'string','','Enable','on');
    set(handles.G_month_input,'string','','Enable','on');
    set(handles.G_day_input,'string','','Enable','on');
    set(handles.G_hour_input,'string','','Enable','on');
    set(handles.G_min_input,'string','00','Enable','on');
    set(handles.G_sec_input,'string','00','Enable','on');
    set(handles.G_delta_t_input,'string','','Enable','on');
    set(handles.O_year_input,'string','','Enable','on');
    set(handles.O_month_input,'string','','Enable','on');
    set(handles.O_day_input,'string','','Enable','on');
    set(handles.O_hour_input,'string','','Enable','on');
    set(handles.O_min_input,'string','00','Enable','on');
    set(handles.O_sec_input,'string','00','Enable','on');
    set(handles.O_delta_t_input,'string','','Enable','on');
    set(handles.C_year_input,'string','00','Enable','off');
    set(handles.C_month_input,'string','00','Enable','off');
    set(handles.C_day_input,'string','00','Enable','off');
    set(handles.C_hour_input,'string','00','Enable','off');
    set(handles.C_min_input,'string','00','Enable','off');
    set(handles.C_sec_input,'string','00','Enable','off');
    set(handles.C_delta_t_input,'string','00','Enable','off');
    set(handles.per_process_radio,'Value',1);
    set(handles.per_process_call_buttom,'Enable','on');
    set(handles.sediment_call_button,'Enable','off');
    set(handles.wave_call_button,'Enable','off');
    set(handles.generate_control_file_button,'Enable','on');
    set(handles.caculation_button,'Enable','off');
    % 初始值
    handles.year_start = NaN;
    handles.month_start = NaN;
    handles.day_start = NaN;
    handles.hour_start =NaN;
    handles.min_start = 0;
    handles.sec_start = 0;
    handles.year_end = NaN;
    handles.month_end = NaN;
    handles.day_end = NaN;
    handles.hour_end = NaN;
    handles.min_end = 0;
    handles.sec_end = 0;
    handles.Dt = NaN;
    handles.G_year = NaN;
    handles.G_month =NaN;
    handles.G_day = NaN;
    handles.G_hour = NaN;
    handles.G_min = 0;
    handles.G_sec = 0;
    handles.G_delta_t = NaN;
    handles.O_year = NaN;
    handles.O_month = NaN;
    handles.O_day = NaN;
    handles.O_hour = NaN;
    handles.O_min = 0;
    handles.O_sec = 0;
    handles.O_delta_t = NaN;
    handles.C_year = 0;
    handles.C_month = 0;
    handles.C_day = 0;
    handles.C_hour = 0;
    handles.C_min = 0;
    handles.C_sec = 0;
    handles.C_delta_t = 0;
    handles.obs_num = 5;
    handles.opne_bnd_num = 0;
    handles.claculation_content_status = [1,0,0,0,0,0];
    handles.per_process_state = zeros(1,2);
    handles.generate_control_file_button_state = zeros(1,24);
    handles.caculation_button_state = 0;
    handles.wave_gird_index = 1;
    handles.save_status = 1;
end
% 清除之前设置

guidata(hObject, handles);


% --------------------------------------------------------------------
function open_set_Callback(hObject, eventdata, handles)
% hObject    handle to open_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global main_handles_old;
global per_process_handles_old;
global wave_handles_old;
global sediment_features_handles_old;
global observation_point_handle_old;
[filename,pathname]=uigetfile({'*.mat;','初始化文件(*.mat)';},'请选择需要打开的文件');
if (isequal(filename,0)  && isequal(pathname,0))
    uiwait(msgbox('您没有打开任何初始化文件, 请重新选择!','Error','error'));
    return;
else
    file_path = [pathname filename];
end
all_old_handles = load(file_path);
if(~isempty(all_old_handles.all_handles{1,1}))
    [row,~] = size(all_old_handles.all_handles{1,1});
    for i = 1:row
        eval(['main_handles_old.',all_old_handles.all_handles{1,1}{i,1},'=','all_old_handles.all_handles{1,1}{i,2}',';']);
    end
else
    main_handles_old = {};
    
end
if(~isempty(all_old_handles.all_handles{1,2}))
    [row,~] = size(all_old_handles.all_handles{1,2});
    for i = 1:row
        eval(['per_process_handles_old.',all_old_handles.all_handles{1,2}{i,1},'=','all_old_handles.all_handles{1,2}{i,2}',';']);
    end
else
    per_process_handles_old = {};
end
if(~isempty(all_old_handles.all_handles{1,3}))
    [row,~] = size(all_old_handles.all_handles{1,3});
    for i = 1:row
        eval(['wave_handles_old.',all_old_handles.all_handles{1,3}{i,1},'=','all_old_handles.all_handles{1,3}{i,2}',';']);
    end
else
    wave_handles_old = {};
end
if(~isempty(all_old_handles.all_handles{1,4}))
    [row,~] = size(all_old_handles.all_handles{1,4});
    for i = 1:row
        eval(['sediment_features_handles_old.',all_old_handles.all_handles{1,4}{i,1},'=','all_old_handles.all_handles{1,4}{i,2}',';']);
    end
else
    sediment_features_handles_old = {};
end
if(~isempty(all_old_handles.all_handles{1,5}))
    [row,~] = size(all_old_handles.all_handles{1,5});
    for i = 1:row
        eval(['observation_point_handle_old.',all_old_handles.all_handles{1,5}{i,1},'=','all_old_handles.all_handles{1,5}{i,2}',';']);
    end
else
    observation_point_handle_old = {};
end
if(~isempty(main_handles_old))
    handles = main_GUI_reconsitution(handles);
    set(handles.save_file,'Enable','off');
    set(handles.save_file_another,'Enable','on');
end
handles.workpath = pathname(1:end-1);
guidata(hObject, handles);


% --------------------------------------------------------------------
function save_file_Callback(hObject, eventdata, handles)
% hObject    handle to save_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global main_handles_old;
main_handles_old = handles;
global per_process_handles_old;
global wave_handles_old;
global sediment_features_handles_old;
global observation_point_handle_old;
temp_main = [fieldnames(main_handles_old),struct2cell(main_handles_old)];
temp_main = temp_main(115:end,:);
if(~isempty(per_process_handles_old))
    temp_per = [fieldnames(per_process_handles_old),struct2cell(per_process_handles_old)];
    temp_per = temp_per(102:end,:);
else
    temp_per = {};
end
if(~isempty(wave_handles_old))
    temp_wave = [fieldnames(wave_handles_old),struct2cell(wave_handles_old)];
    temp_wave = temp_wave(71:end,:);
else
    temp_wave = {};
end
if(~isempty(sediment_features_handles_old))
   temp_sediment = [fieldnames(sediment_features_handles_old),struct2cell(sediment_features_handles_old)];
   temp_sediment = temp_sediment(26:end,:);
else
    temp_sediment = {};
end    
if(~isempty(observation_point_handle_old))
    temp_obs = [fieldnames(observation_point_handle_old),struct2cell(observation_point_handle_old)];
    temp_obs = temp_obs(8:end,:);
else
    temp_obs = {};
end 
all_handles = {temp_main,temp_per,temp_wave,temp_sediment,temp_obs};
name = strsplit(handles.workpath,'\');
name = name{end};
save([handles.workpath,'\',name,'.mat'],'all_handles');
set(handles.save_file,'Enable','off');
guidata(hObject, handles);


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = about;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function wave_call_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wave_call_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when main_fig is resized.
function main_fig_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to main_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_file_another_Callback(hObject, eventdata, handles)
% hObject    handle to save_file_another (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname = uigetdir('*.*','请选择另存为路径');
if (~isequal(pathname,0))
    if(~isequal(handles.workpath,pathname))
        global main_handles_old;
        main_handles_old = handles;
        global per_process_handles_old;
        global wave_handles_old;
        global sediment_features_handles_old;
        global observation_point_handle_old;
        temp_main = [fieldnames(main_handles_old),struct2cell(main_handles_old)];
        temp_main = temp_main(115:end,:);
        if(~isempty(per_process_handles_old))
            temp_per = [fieldnames(per_process_handles_old),struct2cell(per_process_handles_old)];
            temp_per = temp_per(102:end,:);
        else
            temp_per = {};
        end
        if(~isempty(wave_handles_old))
            temp_wave = [fieldnames(wave_handles_old),struct2cell(wave_handles_old)];
            temp_wave = temp_wave(71:end,:);
        else
            temp_wave = {};
        end
        if(~isempty(sediment_features_handles_old))
            temp_sediment = [fieldnames(sediment_features_handles_old),struct2cell(sediment_features_handles_old)];
            temp_sediment = temp_sediment(26:end,:);
        else
            temp_sediment = {};
        end
        if(~isempty(observation_point_handle_old))
            temp_obs = [fieldnames(observation_point_handle_old),struct2cell(observation_point_handle_old)];
            temp_obs = temp_obs(8:end,:);
        else
            temp_obs = {};
        end
        all_handles = {temp_main,temp_per,temp_wave,temp_sediment,temp_obs};
        name = strsplit(pathname,'\');
        name = name{end};
        save([pathname,'\',name,'.mat'],'all_handles');
        flow_files = struct2cell(dir([handles.workpath,'\1.*']));
        wave_files = struct2cell(dir([handles.workpath,'\wave.*']));
        layer_file = struct2cell(dir([handles.workpath,'\layer']));
        xml_file = struct2cell(dir([handles.workpath,'\config_d_hydro.xml']));
        bat_file = struct2cell(dir([handles.workpath,'\run.bat']));
        if(~isempty(flow_files))
            file_name = flow_files(1,:);
            for i = 1:length(file_name)
                copyfile([handles.workpath,'/',file_name{i}],pathname);
            end
        end
        if(~isempty(wave_files))
            file_name = wave_files(1,:);
            for i = 1:length(file_name)
                copyfile([handles.workpath,'/',file_name{i}],pathname);
            end
        end
        if(~isempty(layer_file))
            copyfile([handles.workpath,'/',layer_file{1}],pathname);
        end
        if(~isempty(xml_file))
            copyfile([handles.workpath,'/',xml_file{1}],pathname);
        end
        if(~isempty(bat_file))
            copyfile([handles.workpath,'/',bat_file{1}],pathname);
        end
        set(handles.save_file,'Enable','off');
    else
        return;
    end
else
    return;
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function close_fig_Callback(hObject, eventdata, handles)
% hObject    handle to close_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
main_fig_CloseRequestFcn(hObject, eventdata, handles)
handles = guidata(hObject);


% --------------------------------------------------------------------
function select_Callback(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help_first_button_Callback(hObject, eventdata, handles)
% hObject    handle to help_first_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help_button_Callback(hObject, eventdata, handles)
% hObject    handle to help_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('help.pdf');


% --- Executes on button press in post_call_button.
function post_call_button_Callback(hObject, eventdata, handles)
% hObject    handle to post_call_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~isequal(handles.workpath,'no_path'))
    handles.per_process_open = 1;
    guidata(hObject, handles);
    h = post(0,handles.workpath);
    handles.per_process_open = 0;
else
    uiwait(msgbox('请先设置工作路径！','错误','error'));
    return;
end
guidata(hObject, handles);
    
