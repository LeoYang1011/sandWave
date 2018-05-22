function varargout = pre_process(varargin)
%PRE_PROCESS_FIG M-file for pre_process_fig.fig
%      PRE_PROCESS_FIG, by itself, creates a new PRE_PROCESS_FIG or raises the existing
%      singleton*.
%
%      H = PRE_PROCESS_FIG returns the handle to a new PRE_PROCESS_FIG or the handle to
%      the existing singleton*.
%
%      PRE_PROCESS_FIG('Property','Value',...) creates a new PRE_PROCESS_FIG using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to pre_process_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PRE_PROCESS_FIG('CALLBACK') and PRE_PROCESS_FIG('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PRE_PROCESS_FIG.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pre_process_fig

% Last Modified by GUIDE v2.5 10-May-2018 12:32:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pre_process_OpeningFcn, ...
                   'gui_OutputFcn',  @pre_process_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before pre_process_fig is made visible.
function pre_process_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for pre_process_fig
% handles.output = hObject;
warning('off')
env_path = getenv('sandWave');
h = handles.pre_process_fig; %返回其句柄
ico = [env_path,'sandWave_resources\icon_32.png'];
newIcon = javax.swing.ImageIcon(ico);
figFrame = get(h,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标

if (~isempty(varargin{2}))
    handles.workpath = varargin{2};
else
    handles.workpath = 'no_path';
end
if (~isempty(varargin{3}))
    handles.comp_base_path = varargin{3};
else
    handles.comp_base_path = '';
end
if (~isempty(varargin{4}))
    handles.water_path = varargin{4};
else
    handles.water_path = '';
end
if (~isempty(varargin{5}))
    handles.claculation_content_status = varargin{5};
else
    handles.claculation_content_status = [];
end
if (~isempty(varargin{6}))
    handles.itdate = varargin{6};
else
    handles.itdate = '';
end
if (~isempty(varargin{7}))
    handles.tstop = varargin{7};
else
    handles.tstop = 0;
end
global per_process_handles_old ;
if(isempty(per_process_handles_old))
    clean_all_button_Callback(hObject, eventdata, handles);
    handles=guidata(hObject);
    handles.per_process_state = zeros(1,2);
else
    handles = per_process_reconsitution(handles);
    handles.per_process_state = per_process_handles_old.per_process_state;
end
% Update handles structure
guidata(hObject, handles);
uiwait(hObject); 

% UIWAIT makes pre_process_fig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pre_process_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = handles.per_process_state;
varargout{2} = handles.obs_num;
varargout{3} = handles.opne_bnd_num;
guidata(hObject, handles)
global per_process_handles_old ;
per_process_handles_old = handles;
delete(hObject);  



function y_dis_input_Callback(hObject, eventdata, handles)
% hObject    handle to y_dis_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.y_dis;
handles.y_dis = str2double((get(hObject,'String')));
if (isnan(handles.y_dis))
    handles.creat_grid_button_switch(1) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.y_dis_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.creat_grid_button_switch(1) = 1;
end
if (isequal(handles.creat_grid_button_switch,ones(1,6)))
    set(handles.creat_grid_button,'Enable','on')
else
    set(handles.creat_grid_button,'Enable','off')
end
handles.grid_input_info = per_process_update_info(old_value,handles.y_dis,handles.grid_input_info);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of y_dis_input as text
%        str2double(get(hObject,'String')) returns contents of y_dis_input as a double


% --- Executes during object creation, after setting all properties.
function y_dis_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_dis_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in y_more_switch.
function y_more_switch_Callback(hObject, eventdata, handles)
% hObject    handle to y_more_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ( get(hObject,'Value') ==0 )
    set(handles.y_more_input,'Enable','off','string','1')
    set(handles.lat_more_min_input,'Enable','off','string','')
    set(handles.lat_more_max_input,'Enable','off','string','')
    handles.y_more = 1;
    handles.y_more_switch_index = 0;
else
    set(handles.y_more_input,'Enable','on','string','1')
    set(handles.lat_more_min_input,'Enable','on')
    set(handles.lat_more_max_input,'Enable','on')
    handles.y_more = 1;
    handles.y_more_switch_index = 1;
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of y_more_switch



function y_more_input_Callback(hObject, eventdata, handles)
% hObject    handle to y_more_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.y_more;
handles.y_more = str2double((get(hObject,'String')));
if (isnan(handles.y_more)||handles.y_more < 1)
    msg = {'            纬度方向上的加密等级必须大于等于1';'忽略此警告则纬度方向上的加密等级将被设置为默认值：1'};
    msgbox(msg,'Warning','warn');
    set(hObject,'String','1')
    handles.y_more = 1;
end
handles.grid_input_info = per_process_update_info(old_value,handles.y_more,handles.grid_input_info);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of y_more_input as text
%        str2double(get(hObject,'String')) returns contents of y_more_input as a double


% --- Executes during object creation, after setting all properties.
function y_more_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_more_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lat_more_max_input_Callback(hObject, eventdata, handles)
% hObject    handle to lat_more_max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.lat_more_max;
handles.lat_more_max = str2double((get(hObject,'String')));
if (isnan(handles.lat_more_max))
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lat_more_max_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
end
handles.grid_input_info = per_process_update_info(old_value,handles.lat_more_max,handles.grid_input_info);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of lat_more_max_input as text
%        str2double(get(hObject,'String')) returns contents of lat_more_max_input as a double


% --- Executes during object creation, after setting all properties.
function lat_more_max_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lat_more_max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lat_max_input_Callback(hObject, eventdata, handles)
% hObject    handle to lat_max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.lat_max;
handles.lat_max = str2double((get(hObject,'String')));
if (isnan(handles.lat_max))
    handles.creat_grid_button_switch(3) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lat_max_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.creat_grid_button_switch(3) = 1;
end
if (isequal(handles.creat_grid_button_switch,ones(1,6)))
    set(handles.creat_grid_button,'Enable','on')
else
    set(handles.creat_grid_button,'Enable','off')
end
handles.grid_input_info = per_process_update_info(old_value,handles.lat_max,handles.grid_input_info);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of lat_max_input as text
%        str2double(get(hObject,'String')) returns contents of lat_max_input as a double


% --- Executes during object creation, after setting all properties.
function lat_max_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lat_max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lat_min_input_Callback(hObject, eventdata, handles)
% hObject    handle to lat_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.lat_min;
handles.lat_min = str2double((get(hObject,'String')));
if (isnan(handles.lat_min))
    handles.creat_grid_button_switch(2) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lat_min_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.creat_grid_button_switch(2) = 1;
end

if (isequal(handles.creat_grid_button_switch,ones(1,6)))
    set(handles.creat_grid_button,'Enable','on')
else
    set(handles.creat_grid_button,'Enable','off')
end
handles.grid_input_info = per_process_update_info(old_value,handles.lat_min,handles.grid_input_info);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of lat_min_input as text
%        str2double(get(hObject,'String')) returns contents of lat_min_input as a double


% --- Executes during object creation, after setting all properties.
function lat_min_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lat_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lat_more_min_input_Callback(hObject, eventdata, handles)
% hObject    handle to lat_more_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.lat_more_min;
handles.lat_more_min = str2double((get(hObject,'String')));
if (isnan(handles.lat_more_min))
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lat_more_min_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
end
handles.grid_input_info = per_process_update_info(old_value,handles.lat_more_min,handles.grid_input_info);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of lat_more_min_input as text
%        str2double(get(hObject,'String')) returns contents of lat_more_min_input as a double


% --- Executes during object creation, after setting all properties.
function lat_more_min_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lat_more_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_dis_input_Callback(hObject, eventdata, handles)
% hObject    handle to x_dis_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.x_dis;
handles.x_dis = str2double((get(hObject,'String')));
if (isnan(handles.x_dis))
    handles.creat_grid_button_switch(4) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.x_dis_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.creat_grid_button_switch(4) = 1;
end
if (isequal(handles.creat_grid_button_switch,ones(1,6)))
    set(handles.creat_grid_button,'Enable','on')
else
    set(handles.creat_grid_button,'Enable','off')
end
handles.grid_input_info = per_process_update_info(old_value,handles.x_dis,handles.grid_input_info );
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of x_dis_input as text
%        str2double(get(hObject,'String')) returns contents of x_dis_input as a double


% --- Executes during object creation, after setting all properties.
function x_dis_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_dis_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in x_more_switch.
function x_more_switch_Callback(hObject, eventdata, handles)
% hObject    handle to x_more_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ( get(hObject,'Value') ==0 )
    set(handles.x_more_input,'Enable','off','string','1')
    set(handles.lon_more_min_input,'Enable','off','string','')
    set(handles.lon_more_max_input,'Enable','off','string','')
    handles.x_more = 1;
    handles.x_more_switch_index = 0;
else
    set(handles.x_more_input,'Enable','on','string','1')
    set(handles.lon_more_min_input,'Enable','on')
    set(handles.lon_more_max_input,'Enable','on')
    handles.x_more = 1;
    handles.x_more_switch_index = 1;
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of x_more_switch



function x_more_input_Callback(hObject, eventdata, handles)
% hObject    handle to x_more_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.x_more;
handles.x_more = str2double((get(hObject,'String')));
if (isnan(handles.x_more)||handles.x_more < 1)
    msg = {'            经度方向上的加密等级必须大于等于1';'忽略此警告则经度方向上的加密等级将被设置为默认值：1'};
    msgbox(msg,'Warning','warn');
    set(hObject,'String','1')
    handles.x_more = 1;
end
handles.grid_input_info = per_process_update_info(old_value,handles.x_more,handles.grid_input_info);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of x_more_input as text
%        str2double(get(hObject,'String')) returns contents of x_more_input as a double


% --- Executes during object creation, after setting all properties.
function x_more_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_more_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lon_more_max_input_Callback(hObject, eventdata, handles)
% hObject    handle to lon_more_max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.lon_more_max;
handles.lon_more_max = str2double((get(hObject,'String')));
if (isempty(handles.lon_more_max))
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lon_more_max_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
end
handles.grid_input_info = per_process_update_info(old_value,handles.lon_more_max,handles.grid_input_info);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of lon_more_max_input as text
%        str2double(get(hObject,'String')) returns contents of lon_more_max_input as a double


% --- Executes during object creation, after setting all properties.
function lon_more_max_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lon_more_max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lon_max_input_Callback(hObject, eventdata, handles)
% hObject    handle to lon_max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.lon_max;
handles.lon_max = str2double((get(hObject,'String')));
if (isnan(handles.lon_max))
    handles.creat_grid_button_switch(6) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lon_max_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.creat_grid_button_switch(6) = 1;
end
if (isequal(handles.creat_grid_button_switch,ones(1,6)))
    set(handles.creat_grid_button,'Enable','on')
else
    set(handles.creat_grid_button,'Enable','off')
end
handles.grid_input_info = per_process_update_info(old_value,handles.lon_max,handles.grid_input_info);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of lon_max_input as text
%        str2double(get(hObject,'String')) returns contents of lon_max_input as a double


% --- Executes during object creation, after setting all properties.
function lon_max_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lon_max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lon_min_input_Callback(hObject, eventdata, handles)
% hObject    handle to lon_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.lon_min;
handles.lon_min = str2double((get(hObject,'String')));
if (isnan(handles.lon_min))
    handles.creat_grid_button_switch(5) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lon_min_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.creat_grid_button_switch(5) = 1;
end
if (isequal(handles.creat_grid_button_switch,ones(1,6)))
    set(handles.creat_grid_button,'Enable','on')
else
    set(handles.creat_grid_button,'Enable','off')
end
handles.grid_input_info = per_process_update_info(old_value,handles.lon_min,handles.grid_input_info);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of lon_min_input as text
%        str2double(get(hObject,'String')) returns contents of lon_min_input as a double


% --- Executes during object creation, after setting all properties.
function lon_min_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lon_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lon_more_min_input_Callback(hObject, eventdata, handles)
% hObject    handle to lon_more_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.lon_more_min;
handles.lon_more_min = str2double((get(hObject,'String')));
if (isnan(handles.lon_more_min))
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lon_more_min_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
end
handles.grid_input_info = per_process_update_info(old_value,handles.lon_more_min,handles.grid_input_info);
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of lon_more_min_input as text
%        str2double(get(hObject,'String')) returns contents of lon_more_min_input as a double


% --- Executes during object creation, after setting all properties.
function lon_more_min_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lon_more_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function layer_input_Callback(hObject, eventdata, handles)
% hObject    handle to layer_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of layer_input as text
%        str2double(get(hObject,'String')) returns contents of layer_input as a double
handles.layer = str2double(get(hObject,'String'));
if(isnan(handles.layer))
    set(hObject,'String','')
    handles.layer = 0;
end
if(~isequal(handles.layer,0))
    set(handles.layered_generate_button,'Enable','on');
else
    set(handles.layered_generate_button,'Enable','off');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function layer_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in layer_s_switch.
function layer_s_switch_Callback(hObject, eventdata, handles)
% hObject    handle to layer_s_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ( get(hObject,'Value') ==0 )
    set(handles.layer_s_input,'Enable','off','string','0');
    handles.layer_s = 0;
else
    set(handles.layer_s_input,'Enable','on')
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of layer_s_switch



function layer_s_input_Callback(hObject, eventdata, handles)
% hObject    handle to layer_s_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of layer_s_input as text
%        str2double(get(hObject,'String')) returns contents of layer_s_input as a double
handles.layer_s = str2double(get(hObject,'String'));
if(isnan(handles.layer_s))
    msgbox('表层加密层数将被设置为默认值：0','Warning','warn');
    set(hObject,'String','0')
    handles.layer_s = 0;
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function layer_s_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer_s_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in layer_b_switch.
function layer_b_switch_Callback(hObject, eventdata, handles)
% hObject    handle to layer_b_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ( get(hObject,'Value') ==0 )
    set(handles.layer_b_input,'Enable','off','string','0');
    handles.layer_b = 0;
else
    set(handles.layer_b_input,'Enable','on')
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of layer_b_switch



function layer_b_input_Callback(hObject, eventdata, handles)
% hObject    handle to layer_b_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of layer_b_input as text
%        str2double(get(hObject,'String')) returns contents of layer_b_input as a double
handles.layer_b = str2double(get(hObject,'String'));
if(isnan(handles.layer_b))
    msgbox('底层加密层数将被设置为默认值：0','Warning','warn');
    set(hObject,'String','0')
    handles.layer_b = 0;
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function layer_b_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer_b_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in layered_generate_button.
function layered_generate_button_Callback(hObject, eventdata, handles)
% hObject    handle to layered_generate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
layer_m = handles.layer-handles.layer_b-handles.layer_s;
layer_aver = (handles.layer_b+handles.layer_s)/2+layer_m;

layer_th = 100/layer_aver;
layer_bottom = ones(handles.layer_b,1)*layer_th/2;
layer_middle = ones(layer_m,1)*layer_th;
layer_surface = ones(handles.layer_s,1)*layer_th/2;

layer_ = [layer_surface;layer_middle;layer_bottom];
layer_ = roundn(layer_,-3);
layer_(1,1) = 100-sum(layer_(2:end,1));

% 展示分层效果
layer_show1 = cumsum(layer_);
handles.layer_show = zeros(handles.layer+1,1);
handles.layer_show(2:end,1) = layer_show1;
x = 0:0.1:10;

axes(handles.layer_axes);
cla;

for i = 1:handles.layer+1
    y1 = 6*sin(2*pi/20*x)-10;
    y2 = handles.layer_show(i,1)*y1/100;
    plot(x*100,y2*3,'-r');
    hold on
end

set(gca,'FontSize',7)
xlabel('距离（m）','FontSize',7);
ylabel('水深（m）','FontSize',7);

save([handles.workpath,'\layer'], 'layer_','-ascii');
msgbox('生成垂向分层成功！','提示','help');
guidata(hObject, handles);
% --- Executes on button press in creat_grid_button.

function creat_grid_button_Callback(hObject, eventdata, handles)
% hObject    handle to creat_grid_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_value = handles.x_axis_2;
if (get(handles.y_more_switch,'value') == 1 && get(handles.x_more_switch,'value') == 0)
    lon_vector = [handles.lon_min,handles.lon_max];
    lat_vector = [handles.lat_min,handles.lat_more_min,handles.lat_more_max,handles.lat_max];
    nan_id = find(isnan(lat_vector));
    lat_vector(nan_id) = [];
    if (~isequal(lon_vector,sort(lon_vector)) || ~isequal(length(lon_vector),length(unique(lon_vector))))
        msgbox('经度输入错误!','Error','error');
        return;
    elseif (~isequal(lat_vector,sort(lat_vector))|| ~isequal(length(lat_vector),length(unique(lat_vector))))
        msgbox('纬度输入错误!','Error','error');
        return;
    end
    if (~per_process_check_dis(lon_vector,handles.x_dis))
        msgbox('经度方向网格间距过大!','Error','error');
        return;
    elseif (~per_process_check_dis(lat_vector,handles.y_dis,handles.y_more,nan_id))
        msgbox('纬度方向网格间距过大!','Error','error');
        return;
    end
    handles.x_grid = pre_process_generat_grid(lon_vector,handles.x_dis);
    handles.y_grid = pre_process_generat_grid(lat_vector,handles.y_dis,handles.y_more,nan_id);
elseif (get(handles.y_more_switch,'value') == 0 && get(handles.x_more_switch,'value') == 1)
    lon_vector = [handles.lon_min,handles.lon_more_min,handles.lon_more_max,handles.lon_max];
    lat_vector = [handles.lat_min,handles.lat_max];
    nan_id = find(isnan(lon_vector));
    lon_vector(nan_id) = [];
    if (~isequal(lon_vector,sort(lon_vector))|| ~isequal(length(lon_vector),length(unique(lon_vector))))
        msgbox('经度输入错误!','Error','error');
        return;
    elseif (~isequal(lat_vector,sort(lat_vector))|| ~isequal(length(lat_vector),length(unique(lat_vector))))
        msgbox('纬度输入错误!','Error','error');
        return;
    end
    if (~per_process_check_dis(lon_vector,handles.x_dis,handles.x_more,nan_id))
        msgbox('经度方向网格间距过大!','Error','error');
        return;
    elseif (~per_process_check_dis(lat_vector,handles.y_dis))
        msgbox('纬度方向网格间距过大!','Error','error');
        return;
    end
    handles.x_grid = pre_process_generat_grid(lon_vector,handles.x_dis,handles.x_more,nan_id);
    handles.y_grid = pre_process_generat_grid(lat_vector,handles.y_dis);
elseif (get(handles.y_more_switch,'value') == 0 && get(handles.x_more_switch,'value') == 0)
    lon_vector = [handles.lon_min,handles.lon_max];
    lat_vector = [handles.lat_min,handles.lat_max];
    if (~isequal(lon_vector,sort(lon_vector))|| ~isequal(length(lon_vector),length(unique(lon_vector))))
        msgbox('经度输入错误!','Error','error');
        return;
    elseif (~isequal(lat_vector,sort(lat_vector))|| ~isequal(length(lat_vector),length(unique(lat_vector))))
        msgbox('纬度输入错误!','Error','error');
        return;
    end
    if (~per_process_check_dis(lon_vector,handles.x_dis))
        msgbox('经度方向网格间距过大!','Error','error');
        return;
    elseif (~per_process_check_dis(lat_vector,handles.y_dis))
        msgbox('纬度方向网格间距过大!','Error','error');
        return;
    end
    handles.x_grid = pre_process_generat_grid(lon_vector,handles.x_dis);
    handles.y_grid = pre_process_generat_grid(lat_vector,handles.y_dis);
else
    lon_vector = [handles.lon_min,handles.lon_more_min,handles.lon_more_max,handles.lon_max];
    lat_vector = [handles.lat_min,handles.lat_more_min,handles.lat_more_max,handles.lat_max];
    nan_id_lon = find(isnan(lon_vector));
    lon_vector(nan_id_lon) = [];
    nan_id_lat = find(isnan(lat_vector));
    lat_vector(nan_id_lat) = [];
    if (~isequal(lon_vector,sort(lon_vector))|| ~isequal(length(lon_vector),length(unique(lon_vector))))
        msgbox('经度输入错误!','Error','error');
        return;
    elseif (~isequal(lat_vector,sort(lat_vector))|| ~isequal(length(lat_vector),length(unique(lat_vector))))
        msgbox('纬度输入错误!','Error','error');
        return;
    end
    if (~per_process_check_dis(lon_vector,handles.x_dis,handles.x_more,nan_id_lon))
        msgbox('经度方向网格间距过大!','Error','error');
        return;
    elseif (~per_process_check_dis(lat_vector,handles.y_dis,handles.y_more,nan_id_lat))
        msgbox('纬度方向网格间距过大!','Error','error');
        return;
    end
    handles.x_grid = pre_process_generat_grid(lon_vector,handles.x_dis,handles.x_more,nan_id_lon);
    handles.y_grid = pre_process_generat_grid(lat_vector,handles.y_dis,handles.y_more,nan_id_lat);
end
% 写入文件
handles.write_result = pre_process_write_grid(handles.x_grid,handles.y_grid,handles);

%生成默认监控点
handles.obs_value = {handles.x_grid(floor(handles.write_result(1)/3)),handles.y_grid(floor(handles.write_result(2)/3));...
    handles.x_grid(floor(handles.write_result(1)/3)),handles.y_grid(floor(handles.write_result(2)/3*2));...
    handles.x_grid(floor(handles.write_result(1)/2)),handles.y_grid(floor(handles.write_result(2)/2));...
    handles.x_grid(floor(handles.write_result(1)/3*2)),handles.y_grid(floor(handles.write_result(2)/3));...
    handles.x_grid(floor(handles.write_result(1)/3*2)),handles.y_grid(floor(handles.write_result(2)/3*2))};
handles.obs_id = {floor(handles.write_result(1)/3),floor(handles.write_result(2)/3);...
    floor(handles.write_result(1)/3),floor(handles.write_result(2)/3*2);...
    floor(handles.write_result(1)/2),floor(handles.write_result(2)/2);...
    floor(handles.write_result(1)/3*2),floor(handles.write_result(2)/3);...
    floor(handles.write_result(1)/3*2),floor(handles.write_result(2)/3*2)};
obs_file_id = fopen([handles.workpath,'\1.obs'],'wt');
for i = 1:5
    fprintf(obs_file_id,'%s                  %d    %d\n',['obs',num2str(i)],handles.obs_id{i,1},handles.obs_id{i,2});
end
fclose(obs_file_id);
set(handles.obs_button,'Enable','on');

% 画出网格;
handles.x_axis_1=repmat(handles.y_grid,handles.write_result(1),1);
handles.y_axis_1=repmat(handles.x_grid',1,length(handles.y_grid));
handles.x_axis_2=repmat(handles.y_grid',1,handles.write_result(1));
handles.y_axis_2=repmat(handles.x_grid,length(handles.y_grid),1);
plot(handles.grid_axes,handles.y_axis_2,handles.x_axis_2,'k',handles.y_axis_1,handles.x_axis_1,'k');
axes(handles.grid_axes);
set(gca,'FontSize',7)
xlabel('经度（°）','FontSize',7);
ylabel('纬度（°）','FontSize',7);

if (isequal(handles.water_to_grid,0))
    if(isequal(handles.write_result(3),0) && isequal(handles.write_result(4),0))
        msgbox('生成网格成功！','提示','help');
    else
        msgbox('生成网格失败！','错误','error');
        return;
    end
end
handles.water_to_grid = 0;

handles.per_process_state(1) = 1;
handles.per_process_state(2) = 0;
handles.grid_generate_info = per_process_update_info(old_value,handles.x_axis_2,handles.grid_generate_info);

guidata(hObject, handles);


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in choose_water_depth_switch.
function choose_water_depth_switch_Callback(hObject, eventdata, handles)
% hObject    handle to choose_water_depth_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ( get(hObject,'Value') ==0 )
    handles.choose_water_depth_switch_index = 0;
    set(handles.water_depth_file_path_set,'string','');
    set(handles.choose_water_depth_file_button,'Enable','off');
    if (get(handles.choose_database_switch,'Value') == 0)
        set(handles.create_wate_depth_button,'Enable','off');
    end
else
    set(handles.choose_water_depth_file_button,'Enable','on');
    handles.choose_water_depth_switch_index = 1;
    if(~isempty(handles.water_depth_file_path))
        set(handles.create_wate_depth_button,'Enable','on');
        set(handles.water_depth_file_path_set,'string',handles.water_depth_file_path);
    end
end
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of choose_water_depth_switch


% --- Executes on button press in choose_water_depth_file_button.
function choose_water_depth_file_button_Callback(hObject, eventdata, handles)
% hObject    handle to choose_water_depth_file_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.xyz;','Water Depth file(*.xyz)';'*.*',...
    'AllFiles(*.*)'},'请选择文件');
if (isequal(filename,0) && isequal(pathname,0))
    if(isempty(handles.water_depth_file_path))
        msgbox('您没有选择任何数据文件, 请重新选择!','Error','error');
        set(handles.water_depth_file_path_set,'string','');
        if (isempty(handles.database_file_path))
            set(handles.create_wate_depth_button,'Enable','off');
        end
        return;
    else
        msg = {'您没有选择任何新的数据文件，系统将使用您先前的选择的文件：';handles.water_depth_file_path};
        msgbox(msg,'警告','warn');
        set(handles.water_depth_file_path_set,'string',handles.water_depth_file_path);
    end
    return
else
    handles.water_depth_file_path = [pathname filename];
    if(strcmp(get(handles.create_wate_depth_button,'Enable'), 'off'))
        set(handles.create_wate_depth_button,'Enable','on');
    end
    set(handles.water_depth_file_path_set,'string',handles.water_depth_file_path);
end
guidata(hObject, handles); 

% --- Executes on button press in create_wate_depth_button.
function create_wate_depth_button_Callback(hObject, eventdata, handles)
% hObject    handle to create_wate_depth_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (~isempty(handles.y_axis_2) && ~isempty(handles.x_axis_2))
    if (handles.grid_input_info ~= 0 && handles.grid_generate_info == 0)
        msg = {'网格输入参数信息已更新，但未成功生成新网格！';'是否对当前网格进行更新：';...
            '不更新：忽略参数信息更新，使用先前网格继续生成水深';...
            '更新：停止生成水深，待网格更新后重新生成水深'};
        button = questdlg(msg,'Info','不更新','更新','更新');
        if (button == '更新')
            handles.water_to_grid = 1;
            creat_grid_button_Callback(hObject, eventdata, handles);
            handles=guidata(hObject);
            if(isequal(handles.write_result(3),0) && isequal(handles.write_result(4),0))
                uiwait(msgbox('网格更新成功！','提示','help'));
                handles.Z = per_process_water_depth_generate(handles);
            else
                uiwait(msgbox('网格更新失败！','错误','error'));
                return;
            end
        else
            handles.Z = per_process_water_depth_generate(handles);
        end
    else
        handles.Z = per_process_water_depth_generate(handles);
    end
    if (~isempty(handles.Z) && isequal(size(handles.Z),size(handles.x_axis_2)+1))
        Z_plot = handles.Z(1:end-1,1:end-1);
        pcolor(handles.depth_axes,handles.y_axis_2,handles.x_axis_2,Z_plot);
        axes(handles.depth_axes);
        set(gca,'FontSize',7)
        xlabel('经度（°）','FontSize',7);
        ylabel('纬度（°）','FontSize',7);
        shading interp;   % 显示
        colorbar;
        Z = handles.Z;
        handles.dep_east = Z(1:end-1,end-1);
        handles.dep_west = Z(1:end-1,1);
        handles.dep_south = Z(1,1:end-1);
        handles.dep_north = Z(end-1,1:end-1);
        save([handles.workpath,'\1.dep'],'Z','-ascii');
        uiwait(msgbox('生成水深文件成功！','提示','help'));
    else
        uiwait(msgbox('计算错误，生成水深文件失败，请检查参数输入','错误','error'));
        return;
    end
else
    uiwait(msgbox('请先生成网格','错误','error'));
    return;
end 
handles.per_process_state(2) = 1;
handles.grid_input_info = 0; 
handles.grid_generate_info = 0;
guidata(hObject, handles);
if(~isequal(handles.bund_all_id,ones(1,4)))
    bund_east_select_Callback(hObject, 1, handles);
    handles = guidata(hObject);
    bund_west_select_CreateFcn(hObject, 1, handles);
    handles = guidata(hObject);
    bund_south_select_Callback(hObject, 1, handles);
    handles = guidata(hObject);
    bund_north_select_Callback(hObject, 1, handles);
    handles = guidata(hObject);
    if(~ismember(1,handles.bund_all_id)&&isequal(get(handles.comp_finish_button,'Enable'),'on'))
        comp_finish_button_Callback(hObject, eventdata, handles);
        handles = guidata(hObject);
    end
end
guidata(hObject, handles);

% --- Executes on selection change in bund_east_select.
function bund_east_select_Callback(hObject, eventdata, handles)
% hObject    handle to bund_east_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns bund_east_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bund_east_select
if (isequal(handles.per_process_state,zeros(1,2)))
    uiwait(msgbox('请先生成网格及水深','错误','error'));
    set(handles.bund_east_select,'Value',1);
    return;
elseif(handles.per_process_state(1) ~= handles.per_process_state(2))
    uiwait(msgbox('网格数据水深数据不配备，请更新水深数据','错误','error'));
    set(handles.bund_east_select,'Value',1);
    return;
else
    M = handles.write_result(1)+1;
    handles.bund_all_id(1) = get(handles.bund_east_select,'Value');
    if (isequal(handles.bund_all_id(1),1))
        handles.bund_all = handles.bund_all;
        return;
    elseif(isequal(handles.bund_all_id(1),2))
        if (~isempty(handles.bund_all))
            temp = {};
            [row,~] = size(handles.bund_all);
            for i = 1:row
                if(strfind(handles.bund_all{i,1},'east'))
                    temp = temp;
                else
                    temp = [temp;handles.bund_all(i,:)];
                end
            end
            handles.bund_all = temp;
        else
            handles.bund_all = handles.bund_all;
        end
    else
        t_typee = 'A';
        if isequal(handles.bund_all_id(1),5)
            b_typee = 'N';
            t_typee = 'T';
        elseif isequal(handles.bund_all_id(1),3)
            b_typee = 'Z';
        elseif isequal(handles.bund_all_id(1),4)
            b_typee = 'C';
        elseif isequal(handles.bund_all_id(1),6)
            b_typee = 'R';
        end
        
        if isequal(b_typee,'C')||isequal(b_typee,'R')
            profilee = 'Logarithmic      ';
        else
            profilee = '';
        end
        
        East = pre_process_rdMN(handles.dep_east',-999);
        [~,neast] = size(East);
        je = 0;
        for i = 1:neast/2
            temp = {['east',num2str(i)],b_typee,t_typee,M,East(1,i+je),...
                M, East(1,i+je+1),num2str(0,'%10.7e'),profilee,['east',num2str(i),'_1'],...
                ['east',num2str(i),'_2']};
            if (~isempty(handles.bund_all))
                [~,index] = ismember(temp{1},handles.bund_all(:,1));
                if(index)
                    handles.bund_all(index,:) = temp;
                else
                    handles.bund_all = [handles.bund_all;temp];
                end
            else
                handles.bund_all = [handles.bund_all;temp];
            end
            je = je+1;
        end
    end
    handles.bund_all = pre_process_sort_bund(handles.bund_all);
    if(~ismember(1,handles.bund_all_id))
       bund_file_status = pre_process_write_bnd(handles.bund_all,handles.workpath);
       handles.opne_bnd_num = length(find(handles.bund_all_id ~= 2));
       if (isequal(handles.claculation_content_status(4),1)||isequal(handles.claculation_content_status(6),1))
           bcc_file_status = pre_process_write_bcc(handles);
       else
           bcc_file_status = 0;
       end
       if(~isequal(eventdata,1))
           if (isequal(bund_file_status,0)&&isequal(bcc_file_status,0))
               if(~isequal(handles.comp_all_index,zeros(1,22)))
                   set(handles.comp_clean_select_button,'Enable','on');
                   handles.comp_button_status(2) = 1;
                   set(handles.comp_finish_button,'Enable','on');
                   handles.comp_button_status(3) = 1;
                   if(isequal(handles.comp_all_index,ones(1,22)))
                       set(handles.comp_all_select_button,'Enable','off');
                       handles.comp_button_status(1) = 0;
                   else
                       set(handles.comp_all_select_button,'Enable','on');
                       handles.comp_button_status(1) = 1;
                   end
               else
                   set(handles.comp_all_select_button,'Enable','on');
                   handles.comp_button_status(1) = 1;
               end
           else
               uiwait(msgbox('边界设置失败','错误','error'));
               handles.bund_all_id(1) = 1;
               set(handles.bund_north_select,'Value',1);
           end
       end
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bund_east_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bund_east_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in bund_south_select.
function bund_south_select_Callback(hObject, eventdata, handles)
% hObject    handle to bund_south_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns bund_south_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bund_south_select
if (isequal(handles.per_process_state,zeros(1,2)))
    uiwait(msgbox('请先生成网格及水深','错误','error'));
    set(handles.bund_south_select,'Value',1);
    return;
elseif(handles.per_process_state(1) ~= handles.per_process_state(2))
    uiwait(msgbox('网格数据水深数据不配备，请更新水深数据','错误','error'));
    set(handles.bund_south_select,'Value',1);
    return;
else
    handles.bund_all_id(3) = get(handles.bund_south_select,'Value');
    if (isequal(handles.bund_all_id(3),1))
        handles.bund_all = handles.bund_all;
        return;
    elseif(isequal(handles.bund_all_id(3),2))
        if (~isempty(handles.bund_all))
            temp = {};
            [row,~] = size(handles.bund_all);
            for i = 1:row
                if(strfind(handles.bund_all{i,1},'south'))
                    temp = temp;
                else
                    temp = [temp;handles.bund_all(i,:)];
                end
            end
            handles.bund_all = temp;
        else
            handles.bund_all = handles.bund_all;
        end
    else
        t_types = 'A';
        if isequal(handles.bund_all_id(3),5)
            b_types = 'N';
            t_types = 'T';
        elseif isequal(handles.bund_all_id(3),3)
            b_types = 'Z';
        elseif isequal(handles.bund_all_id(3),4)
            b_types = 'C';
        elseif isequal(handles.bund_all_id(3),6)
            b_types = 'R';
        end
        
        if isequal(b_types,'C')||isequal(b_types,'R')
            profiles = 'Logarithmic      ';
        else
            profiles = '';
        end
        
        South = pre_process_rdMN(handles.dep_south,-999);
        [~,nsouth] = size(South);
        js = 0;
        for i = 1:nsouth/2
            temp = {['south',num2str(i)],b_types,t_types,South(1,i+js),...
                1,South(1,i+js+1),1,num2str(0,'%10.7e'),profiles,['south',num2str(i),'_1'],...
                ['south',num2str(i),'_2']};
            if(~isempty(handles.bund_all))
                [~,index] = ismember(temp{1},handles.bund_all(:,1));
                if(index)
                    handles.bund_all(index,:) = temp;
                else
                    handles.bund_all = [handles.bund_all;temp];
                end
            else
                handles.bund_all = [handles.bund_all;temp];
            end
            js = js+1;
        end
    end
    handles.bund_all = pre_process_sort_bund(handles.bund_all);
    if(~ismember(1,handles.bund_all_id))
       bund_file_status = pre_process_write_bnd(handles.bund_all,handles.workpath);
       handles.opne_bnd_num = length(find(handles.bund_all_id ~= 2));
       if (isequal(handles.claculation_content_status(4),1)||isequal(handles.claculation_content_status(6),1))
           bcc_file_status = pre_process_write_bcc(handles);
       else
           bcc_file_status = 0;
       end
       if(~isequal(eventdata,1))
           if (isequal(bund_file_status,0)&&isequal(bcc_file_status,0))
               if(~isequal(handles.comp_all_index,zeros(1,22)))
                   set(handles.comp_clean_select_button,'Enable','on')
                   handles.comp_button_status(2) = 1;
                   set(handles.comp_finish_button,'Enable','on')
                   handles.comp_button_status(3) = 1;
                   if(isequal(handles.comp_all_index,ones(1,22)))
                       set(handles.comp_all_select_button,'Enable','off')
                       handles.comp_button_status(1) = 0;
                   else
                       set(handles.comp_all_select_button,'Enable','on')
                       handles.comp_button_status(1) = 1;
                   end
               else
                   set(handles.comp_all_select_button,'Enable','on');
                   handles.comp_button_status(1) = 1;
               end
               uiwait(msgbox('边界设置成功','提示','help'));
           else
               uiwait(msgbox('边界设置失败','错误','error'));
               handles.bund_all_id(3) = 1;
               set(handles.bund_north_select,'Value',1);
           end
       end
    end
end
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function bund_south_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bund_south_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in bund_west_select.
function bund_west_select_Callback(hObject, eventdata, handles)
% hObject    handle to bund_west_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns bund_west_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bund_west_select
if (isequal(handles.per_process_state,zeros(1,2)))
    uiwait(msgbox('请先生成网格及水深','错误','error'));
    set(handles.bund_west_select,'Value',1);
    return;
elseif(handles.per_process_state(1) ~= handles.per_process_state(2))
    uiwait(msgbox('网格数据水深数据不配备，请更新水深数据','错误','error'));
    set(handles.bund_west_select,'Value',1);
    return;
else
    handles.bund_all_id(2) = get(handles.bund_west_select,'Value');
    if (isequal(handles.bund_all_id(2),1))
        handles.bund_all = handles.bund_all;
        return;
    elseif(isequal(handles.bund_all_id(2),2))
        if (~isempty(handles.bund_all))
            temp = {};
            [row,~] = size(handles.bund_all);
            for i = 1:row
                if(strfind(handles.bund_all{i,1},'west'))
                    temp = temp;
                else
                    temp = [temp;handles.bund_all(i,:)];
                end
            end
            handles.bund_all = temp;
        else
            handles.bund_all = handles.bund_all;
        end
    else
        t_typew = 'A';
        if isequal(handles.bund_all_id(2),5)
            b_typew = 'N';
            t_typew = 'T';
        elseif isequal(handles.bund_all_id(2),3)
            b_typew = 'Z';
        elseif isequal(handles.bund_all_id(2),4)
            b_typew = 'C';
        elseif isequal(handles.bund_all_id(2),6)
            b_typew = 'R';
        end
        
        if isequal(b_typew,'C')||isequal(b_typew,'R')
            profilew = 'Logarithmic      ';
        else
            profilew = '';
        end
        West = pre_process_rdMN(handles.dep_west',-999);
        [~,nwest] = size(West);
        jw = 0;
        for i = 1:nwest/2
            temp = {['west',num2str(i)],b_typew,t_typew,1,West(1,i+jw),...
                1, West(1,i+jw+1),num2str(0,'%10.7e'),profilew,['west',num2str(i),'_1'],...
                ['west',num2str(i),'_2']};
            if(~isempty(handles.bund_all))
                [~,index] = ismember(temp{1},handles.bund_all(:,1));
                if(index)
                    handles.bund_all(index,:) = temp;
                else
                    handles.bund_all = [handles.bund_all;temp];
                end
            else
                handles.bund_all = [handles.bund_all;temp];
            end
            jw = jw+1;
        end
    end
    handles.bund_all = pre_process_sort_bund(handles.bund_all);
    if(~ismember(1,handles.bund_all_id))
       bund_file_status = pre_process_write_bnd(handles.bund_all,handles.workpath);
       handles.opne_bnd_num = length(find(handles.bund_all_id ~= 2));
       if (isequal(handles.claculation_content_status(4),1)||isequal(handles.claculation_content_status(6),1))
           bcc_file_status = pre_process_write_bcc(handles);
       else
           bcc_file_status = 0;
       end
       if(~isequal(eventdata,1))
           if (isequal(bund_file_status,0)&&isequal(bcc_file_status,0))
               if(~isequal(handles.comp_all_index,zeros(1,22)))
                   set(handles.comp_clean_select_button,'Enable','on')
                   handles.comp_button_status(2) = 1;
                   set(handles.comp_finish_button,'Enable','on')
                   handles.comp_button_status(3) = 1;
                   if(isequal(handles.comp_all_index,ones(1,22)))
                       set(handles.comp_all_select_button,'Enable','off')
                       handles.comp_button_status(1) = 0;
                   else
                       set(handles.comp_all_select_button,'Enable','on')
                       handles.comp_button_status(1) = 1;
                   end
               else
                   set(handles.comp_all_select_button,'Enable','on');
                   handles.comp_button_status(1) = 1;
               end
               uiwait(msgbox('边界设置成功','提示','help'));
           else
               uiwait(msgbox('边界设置失败','错误','error'));
               handles.bund_all_id(2) = 1;
               set(handles.bund_north_select,'Value',1);
           end
       end
    end
end
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function bund_west_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bund_west_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in bund_north_select.
function bund_north_select_Callback(hObject, eventdata, handles)
% hObject    handle to bund_north_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns bund_north_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bund_north_select
if (isequal(handles.per_process_state,zeros(1,2)))
    uiwait(msgbox('请先生成网格及水深','错误','error'));
    set(handles.bund_north_select,'Value',1);
    return;
elseif(handles.per_process_state(1) ~= handles.per_process_state(2))
    uiwait(msgbox('网格数据水深数据不配备，请更新水深数据','错误','error'));
    set(handles.bund_north_select,'Value',1);
    return;
else
    N = handles.write_result(2)+1;
    handles.bund_all_id(4) = get(handles.bund_north_select,'Value');
    if (isequal(handles.bund_all_id(4),1))
        handles.bund_all = handles.bund_all;
        return;
    elseif(isequal(handles.bund_all_id(4),2))
        if (~isempty(handles.bund_all))
            temp = {};
            [row,~] = size(handles.bund_all);
            for i = 1:row
                if(strfind(handles.bund_all{i,1},'north'))
                    temp = temp;
                else
                    temp =[temp;handles.bund_all(i,:)];
                end
            end
            handles.bund_all = temp;
        else
            handles.bund_all = handles.bund_all;
        end
    else
        t_typen = 'A';
        if isequal(handles.bund_all_id(4),5)
            b_typen = 'N';
            t_typen = 'T';
        elseif isequal(handles.bund_all_id(4),3)
            b_typen = 'Z';
        elseif isequal(handles.bund_all_id(4),4)
            b_typen = 'C';
        elseif isequal(handles.bund_all_id(4),6)
            b_typen = 'R';
        end
        
        if isequal(b_typen,'C')||isequal(b_typen,'R')
            profilen = 'Logarithmic      ';
        else
            profilen = '';
        end
        North = pre_process_rdMN(handles.dep_north,-999);
        [~,nnorth] = size(North);
        jn = 0;
        for i = 1:nnorth/2
            temp = {['north',num2str(i)],b_typen,t_typen,North(1,i+jn),N,...
                North(1,i+jn+1),N,num2str(0,'%10.7e'),profilen,['north',num2str(i),'_1'],...
                ['north',num2str(i),'_2']};
            if(~isempty(handles.bund_all))
                [~,index] = ismember(temp{1},handles.bund_all(:,1));
                if(index)
                    handles.bund_all(index,:) = temp;
                else
                    handles.bund_all = [handles.bund_all;temp];
                end
            else
                handles.bund_all = [handles.bund_all;temp];
            end
            jn=jn+1;
        end
    end
    handles.bund_all = pre_process_sort_bund(handles.bund_all);
    if(~ismember(1,handles.bund_all_id))
        bund_file_status = pre_process_write_bnd(handles.bund_all,handles.workpath);
        handles.opne_bnd_num = length(find(handles.bund_all_id ~= 2));
        if (isequal(handles.claculation_content_status(4),1)||isequal(handles.claculation_content_status(6),1))
            bcc_file_status = pre_process_write_bcc(handles);
        else
            bcc_file_status = 0;
        end
        if(~isequal(eventdata,1))
            if (isequal(bund_file_status,0)&&isequal(bcc_file_status,0))
                if(~isequal(handles.comp_all_index,zeros(1,22)))
                    set(handles.comp_clean_select_button,'Enable','on')
                    handles.comp_button_status(2) = 1;
                    set(handles.comp_finish_button,'Enable','on')
                    handles.comp_button_status(3) = 1;
                    if(isequal(handles.comp_all_index,ones(1,22)))
                        set(handles.comp_all_select_button,'Enable','off')
                        handles.comp_button_status(1) = 0;
                    else
                        set(handles.comp_all_select_button,'Enable','on')
                        handles.comp_button_status(1) = 1;
                    end
                else
                    set(handles.comp_all_select_button,'Enable','on');
                    handles.comp_button_status(1) = 1;
                end
                uiwait(msgbox('边界设置成功','提示','help'));
            else
                uiwait(msgbox('边界设置失败','错误','error'));
                handles.bund_all_id(4) = 1;
                set(handles.bund_north_select,'Value',1);
            end
        else
            if (isequal(bund_file_status,0))
                uiwait(msgbox('边界更新成功','提示','help'));
            end
        end
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function bund_north_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bund_north_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in coordinate_select.
function coordinate_select_Callback(hObject, eventdata, handles)
% hObject    handle to coordinate_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns coordinate_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from coordinate_select
coor = {'Spherical','Cartesian'};
old_value = handles.coordinate;
handles.coordinate = coor{get(handles.coordinate_select,'Value')};
handles.grid_input_info = per_process_update_info(old_value,handles.coordinate,handles.grid_input_info);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function coordinate_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordinate_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in choose_database_switch.
function choose_database_switch_Callback(hObject, eventdata, handles)
% hObject    handle to choose_database_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of choose_database_switch
if (get(hObject,'Value') ==0 )
    set(handles.choose_database_button,'Enable','off');
    set(handles.database_path_set,'string','');
    handles.choose_database_switch_index = 0;
    if (get(handles.choose_water_depth_switch,'Value') == 0)
        set(handles.create_wate_depth_button,'Enable','off');
    end
else
    set(handles.choose_database_button,'Enable','on');
    set(handles.database_path_set,'string',handles.database_file_path);
    handles.choose_database_switch_index = 1;
    if(~isempty(handles.database_file_path))
        set(handles.create_wate_depth_button,'Enable','on');
    end
end
guidata(hObject, handles);


% --- Executes on button press in choose_database_button.
function choose_database_button_Callback(hObject, eventdata, handles)
% hObject    handle to choose_database_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.flt;','Database file(*.flt)';'*.*',...
    'AllFiles(*.*)'},'请选择数据库文件');
if (isequal(filename,0)  && isequal(pathname,0))
    if(isempty(handles.database_file_path))
        uiwait(msgbox('您没有选择任何数据文件, 请重新选择!','Error','error'));
        set(handles.database_path_set,'string','');
        if (isempty(handles.water_depth_file_path))
            set(handles.create_wate_depth_button,'Enable','off');
        end
    else
        msg = {'您没有选择任何新的数据文件，系统将使用您先前的选择的文件：';handles.database_file_path};
        uiwait(msgbox(msg,'Warning','warn'));
        set(handles.database_path_set,'string',handles.database_file_path);
    end
    return;
else
    handles.database_file_path = [pathname filename];
    if(strcmp(get(handles.create_wate_depth_button,'Enable'),'off'))
        set(handles.create_wate_depth_button,'Enable','on');
    end
    set(handles.database_path_set,'string',handles.database_file_path);
end
guidata(hObject, handles); 


% --- Executes during object creation, after setting all properties.
function grid_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grid_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate grid_axes
set(gca,'XColor',[1 1 1])
set(gca,'YColor',[1 1 1])
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])

% --- Executes during object creation, after setting all properties.
function depth_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to depth_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate depth_axes
cla;
set(gca,'XColor',[1 1 1])
set(gca,'YColor',[1 1 1])
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])


% --- Executes on mouse press over axes background.
function depth_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to depth_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function layer_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate layer_axes
set(gca,'XColor',[1 1 1])
set(gca,'YColor',[1 1 1])
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])


% --- Executes on button press in clean_grid_button.
function clean_grid_button_Callback(hObject, eventdata, handles)
% hObject    handle to clean_grid_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%gui界面初始设置
set(handles.coordinate_select,'Value',1);
set(handles.y_dis_input,'string','');
set(handles.y_more_switch,'Value',1);
set(handles.y_more_input,'string','1');
set(handles.lat_min_input,'string','');
set(handles.lat_more_min_input,'string','');
set(handles.lat_more_max_input,'string','');
set(handles.lat_max_input,'string','');
set(handles.x_dis_input,'string','');
set(handles.x_more_switch,'Value',1);
set(handles.x_more_input,'string','1');
set(handles.lon_min_input,'string','');
set(handles.lon_more_min_input,'string','');
set(handles.lon_more_max_input,'string','');
set(handles.lon_max_input,'string','');
set(handles.lat_more_min_input,'Enable','on')
set(handles.lat_more_max_input,'Enable','on')
set(handles.lon_more_min_input,'Enable','on')
set(handles.lon_more_max_input,'Enable','on')
set(handles.x_more_input,'Enable','on','string','1')
set(handles.y_more_input,'Enable','on','string','1')
set(handles.creat_grid_button,'Enable','off')
set(handles.obs_button,'Enable','off');
%初始默认值
handles.coordinate = 'Spherical';
handles.y_dis = NaN;
handles.y_more = 1;
handles.lat_min = NaN;
handles.lat_more_min = NaN;
handles.lat_more_max = NaN;
handles.lat_max = NaN;
handles.x_dis = NaN;
handles.x_more = 1;
handles.lon_min = NaN;
handles.lon_more_min = NaN;
handles.lon_more_max = NaN;
handles.lon_max = NaN;
handles.x_grid = [];
handles.y_grid = [];
handles.obs_value = {};
handles.obs_num = 5;
handles.obs_id = {};
handles.x_more_switch_index = 1;
handles.y_more_switch_index = 1;
handles.per_process_state(1) = 0;
handles.per_process_state(2) = 0;
handles.obs_open = 0;  
%画图窗口
axes(handles.grid_axes);cla;
set(gca,'XColor',[1 1 1])
set(gca,'YColor',[1 1 1])
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])
%其他
handles.x_axis_1 = [];
handles.y_axis_1 = [];
handles.x_axis_2 = [];
handles.y_axis_2 = [];
handles.grid_input_info = 0;
handles.grid_generate_info = 0;
handles.creat_grid_button_switch = zeros(1,6);
handles.water_to_grid = 0;
handles.write_result = [];

guidata(hObject, handles);

% --- Executes on button press in clean_layer_button.
function clean_layer_button_Callback(hObject, eventdata, handles)
% hObject    handle to clean_layer_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%gui界面初始设置
set(handles.layer_input,'string','');
set(handles.layer_s_input,'Enable','off','string','0');
set(handles.layer_b_input,'Enable','off','string','0');
set(handles.layer_s_switch,'Value',0);
set(handles.layer_b_switch,'Value',0);
set(handles.layered_generate_button,'Enable','off');
%初始默认值
handles.layer = 0;
handles.layer_s = 0;
handles.layer_b = 0;
handles.layer_show = [];
%画图窗口
axes(handles.layer_axes);cla;
set(gca,'XColor',[1 1 1])
set(gca,'YColor',[1 1 1])
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])

guidata(hObject, handles);




% --- Executes on button press in clean_water_depth_button.
function clean_water_depth_button_Callback(hObject, eventdata, handles)
% hObject    handle to clean_water_depth_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%gui界面初始设置
set(handles.choose_database_switch,'Value',0);
set(handles.choose_database_button,'Enable','off');
set(handles.database_path_set,'string','');
set(handles.choose_water_depth_switch,'Value',0);
set(handles.choose_water_depth_file_button,'Enable','off');
set(handles.water_depth_file_path_set,'string','');
set(handles.create_wate_depth_button,'Enable','off');
%初始默认值
handles.choose_database_switch_index = 0;
handles.choose_water_depth_switch_index = 0;
handles.database_file_path = handles.water_path;
handles.water_depth_file_path = '';
handles.Z = [];
handles.dep_east = [];
handles.dep_west = [];
handles.dep_south = [];
handles.dep_north = [];
handles.per_process_state(2) = 0;
%画图窗口
axes(handles.depth_axes);cla;
set(gca,'XColor',[1 1 1])
set(gca,'YColor',[1 1 1])
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])
colorbar off;

guidata(hObject, handles);



% --- Executes on button press in clean_init_boundary_button.
function clean_init_boundary_button_Callback(hObject, eventdata, handles)
% hObject    handle to clean_init_boundary_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%gui界面初始设置

handles.bund_all = {};
handles.bund_all_id = ones(1,4);
handles.opne_bnd_num = 0;
handles.comp_all_index = zeros(1,22);
handles.comp_now = {};
handles.comp_all = {'2N2','J1','K1','K2','L2','M2','M3','M4','M6',...
    'M8','MKS2','MN4','MS4','N2','O1','P1','Q1','R2','S1','S2','S4','T2'};
comp_clean_select_button_Callback(hObject, eventdata, handles);
handles = guidata(hObject);
if(~isempty(handles.claculation_content_status)&&(isequal(handles.claculation_content_status(5),1)))
    set(handles.bund_east_select,'Enable','off');
    set(handles.bund_west_select,'Enable','off');
    set(handles.bund_south_select,'Enable','off');
    set(handles.bund_north_select,'Enable','off');
    set(handles.clean_init_boundary_button,'Enable','off');
else
    set(handles.bund_east_select,'Value',1,'Enable','on');
    set(handles.bund_west_select,'Value',1,'Enable','on');
    set(handles.bund_south_select,'Value',1,'Enable','on');
    set(handles.bund_north_select,'Value',1,'Enable','on');
    set(handles.clean_init_boundary_button,'Enable','on');
end
set(handles.comp_all_select_button,'Enable','off');
handles.comp_button_status = zeros(1,3);
guidata(hObject, handles);

% --- Executes on button press in clean_all_button.
function clean_all_button_Callback(hObject, eventdata, handles)
% hObject    handle to clean_all_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clean_grid_button_Callback(hObject, eventdata, handles);
handles=guidata(hObject);
clean_layer_button_Callback(hObject, eventdata, handles);
handles=guidata(hObject);
clean_water_depth_button_Callback(hObject, eventdata, handles);
handles=guidata(hObject);
clean_init_boundary_button_Callback(hObject, eventdata, handles);
handles=guidata(hObject);

guidata(hObject, handles);


% --- Executes when user attempts to close pre_process_fig.
function pre_process_fig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to pre_process_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
if(isequal(handles.obs_open,1))
      uiwait(msgbox('请先关闭监控点设置窗口！','错误','error'));
      return;
else
    if (handles.per_process_state(1) ~= handles.per_process_state(2))
        msg = {'网格已更新，但水深数据并未更新，是否继续完成水深数据的更新！';...
            '否：不更新水深数据，继续关闭窗口（可能导致生成主控制文件失败，无法计算）';...
            '是：停止关闭窗口，前往更新水深'};
        button = questdlg(msg,'Info','否','是','是');
        if (button == '是')
            if(isequal(get(handles.create_wate_depth_button,'Enable'),'on'))
                uicontrol(handles.create_wate_depth_button);
            elseif(isequal(get(handles.choose_database_switch,'Value'),1))
                uicontrol(handles.choose_database_button);
            elseif(isequal(get(handles.choose_water_depth_switch,'Value'),1))
                uicontrol(handles.choose_water_depth_file_button);
            else
                uicontrol(handles.choose_database_switch);
            end
            return;
        else
            handles.per_process_state(1) = 0;
            handles.per_process_state(2) = 0;
        end
    end
    uiresume(hObject)
end


% --- Executes on button press in creat_grid_button.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to creat_grid_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in obs_button.
function obs_button_Callback(hObject, eventdata, handles)
% hObject    handle to obs_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.obs_open = 1;  
guidata(hObject, handles);
handles.obs_num = observation_point(handles.obs_id,handles.obs_value,handles.x_grid,handles.y_grid,handles.workpath);
handles.obs_open = 0;  
guidata(hObject, handles);

% --- Executes on button press in two_N2_select.
function two_N2_select_Callback(hObject, eventdata, handles)
% hObject    handle to two_N2_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of two_N2_select
handles.comp_all_index(1) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);



% --- Executes on button press in J1_select.
function J1_select_Callback(hObject, eventdata, handles)
% hObject    handle to J1_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of J1_select
handles.comp_all_index(2) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in K1_select.
function K1_select_Callback(hObject, eventdata, handles)
% hObject    handle to K1_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of K1_select
handles.comp_all_index(3) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in K2_select.
function K2_select_Callback(hObject, eventdata, handles)
% hObject    handle to K2_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of K2_select
handles.comp_all_index(4) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in L2_select.
function L2_select_Callback(hObject, eventdata, handles)
% hObject    handle to L2_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of L2_select
handles.comp_all_index(5) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in M2_select.
function M2_select_Callback(hObject, eventdata, handles)
% hObject    handle to M2_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of M2_select
handles.comp_all_index(6) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in M3_select.
function M3_select_Callback(hObject, eventdata, handles)
% hObject    handle to M3_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of M3_select
handles.comp_all_index(7) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in M4_select.
function M4_select_Callback(hObject, eventdata, handles)
% hObject    handle to M4_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of M4_select
handles.comp_all_index(8) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in M6_select.
function M6_select_Callback(hObject, eventdata, handles)
% hObject    handle to M6_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of M6_select
handles.comp_all_index(9) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);

% --- Executes on button press in M8_select.
function M8_select_Callback(hObject, eventdata, handles)
% hObject    handle to M8_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of M8_select
handles.comp_all_index(10) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in MKS2_select.
function MKS2_select_Callback(hObject, eventdata, handles)
% hObject    handle to MKS2_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of MKS2_select
handles.comp_all_index(11) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in MN4_select.
function MN4_select_Callback(hObject, eventdata, handles)
% hObject    handle to MN4_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of MN4_select
handles.comp_all_index(12) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in MS4_select.
function MS4_select_Callback(hObject, eventdata, handles)
% hObject    handle to MS4_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of MS4_select
handles.comp_all_index(13) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in N2_select.
function N2_select_Callback(hObject, eventdata, handles)
% hObject    handle to N2_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of N2_select
handles.comp_all_index(14) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in O1_select.
function O1_select_Callback(hObject, eventdata, handles)
% hObject    handle to O1_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of O1_select
handles.comp_all_index(15) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);

% --- Executes on button press in P1_select.
function P1_select_Callback(hObject, eventdata, handles)
% hObject    handle to P1_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of P1_select
handles.comp_all_index(16) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in Q1_select.
function Q1_select_Callback(hObject, eventdata, handles)
% hObject    handle to Q1_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of Q1_select
handles.comp_all_index(17) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in R2_select.
function R2_select_Callback(hObject, eventdata, handles)
% hObject    handle to R2_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of R2_select
handles.comp_all_index(18) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in S1_select.
function S1_select_Callback(hObject, eventdata, handles)
% hObject    handle to S1_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of S1_select
handles.comp_all_index(19) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in S2_select.
function S2_select_Callback(hObject, eventdata, handles)
% hObject    handle to S2_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of S2_select
handles.comp_all_index(20) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in S4_select.
function S4_select_Callback(hObject, eventdata, handles)
% hObject    handle to S4_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of S4_select
handles.comp_all_index(21) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in T2_select.
function T2_select_Callback(hObject, eventdata, handles)
% hObject    handle to T2_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of T2_select
handles.comp_all_index(22) = get(hObject,'Value');
if (~ismember(1,handles.bund_all_id))
    if (~isequal(handles.comp_all_index,zeros(1,22)))
        set(handles.comp_finish_button,'Enable','on');
        handles.comp_button_status(3) = 1;
        set(handles.comp_clean_select_button,'Enable','on')
        handles.comp_button_status(2) = 1;
    else
        set(handles.comp_finish_button,'Enable','off');
        handles.comp_button_status(3) = 0;
        set(handles.comp_clean_select_button,'Enable','off')
        handles.comp_button_status(2) = 0;
    end
    if(~isequal(handles.comp_all_index,ones(1,22)))
        set(handles.comp_all_select_button,'Enable','on');
        handles.comp_button_status(1) = 1;
    else
        set(handles.comp_all_select_button,'Enable','off');
        handles.comp_button_status(1) = 1;
    end
end
guidata(hObject, handles);


% --- Executes on button press in comp_clean_select_button.
function comp_clean_select_button_Callback(hObject, eventdata, handles)
% hObject    handle to comp_clean_select_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.comp_all_index = zeros(1,22);
set(handles.two_N2_select,'Value',0);
for i = 2:22
    eval(['set(handles.',handles.comp_all{i},'_select',',','''Value''',',0)'])
end
set(handles.comp_finish_button,'Enable','off');
handles.comp_button_status(3) = 0;
set(handles.comp_clean_select_button,'Enable','off')
handles.comp_button_status(2) = 0;
set(handles.comp_all_select_button,'Enable','on');
handles.comp_button_status(1) = 1;
guidata(hObject, handles);

% --- Executes on button press in comp_all_select_button.
function comp_all_select_button_Callback(hObject, eventdata, handles)
% hObject    handle to comp_all_select_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.comp_all_index = ones(1,22);
set(handles.two_N2_select,'Value',1);
for i = 2:22
    eval(['set(handles.',handles.comp_all{i},'_select',',','''Value''',',1)'])
end
set(handles.comp_finish_button,'Enable','on');
handles.comp_button_status(3) = 1;
set(handles.comp_clean_select_button,'Enable','on');
handles.comp_button_status(2) = 1;
set(handles.comp_all_select_button,'Enable','off');
handles.comp_button_status(1) = 0;
guidata(hObject, handles);

% --- Executes on button press in comp_finish_button.
function comp_finish_button_Callback(hObject, eventdata, handles)
% hObject    handle to comp_finish_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hwait = waitbar(0,'正在设置分潮文件...');
m = 1;
n = 1;
dir = handles.comp_base_path;
handles.comp_now = handles.comp_all(logical(handles.comp_all_index'));
bct_file_id = fopen([handles.workpath,'\1.bct'],'wt');
bca_file_id = fopen([handles.workpath,'\1.bca'],'wt');
[row,~] = size(handles.bund_all);
for i = 1:row
    % 获取每一行的内容
    S = handles.bund_all(i,:);
    if isequal(S{3},'A')
        m1 = S{4};
        n1 = S{5};
        m2 = S{6};
        n2 = S{7};
        if isequal(S{2},'Z')
            B_name1 = S{10};
            B_name2 = S{11};
            AZ_name(m:m+1,1:3) = {B_name1,m1,n1;B_name2,m2,n2};
            m = m+2;
        elseif isequal(S{2},'R')||isequal(S{2},'C')
            C_name1 = S{10};
            C_name2 = S{11};
            CR_name(n:n+1,1:3) = {C_name1,m1,n1;C_name2,m2,n2};
            n = n+2;
        end
% 此处应放入边界条件为时间序列的边界文件，即.bct。Neumann边界不考虑中间的变化，而流速或水位的时间序列则需要指定。
    elseif isequal(S{3},'T')
%         bct_file_id = fopen('1.bct','a+');
        Bou_Sec = i;
        location = S{1};
        if isequal(S{2},'N')
            name_type = 'neumann';
            n_t = '(n)';
            unit = '''[-]''';
            len_rec = 2;
            data_ = [0 0 0;handles.tstop 0 0];  %% 此处5882更换为计算结束时间（以min计量，Tstop变量）
%         elseif isequal(S{2},'C')
%             name_type = 'current';
%             n_t = '(c)';
%             unit = '''[m/s]''';
%             data_ = load('velocity');%% 此处直接导入流速时间序列
%             [len_rec,~] = size(data_);
%         elseif isequal(S{2},'Z')
%             name_type = 'waver elevation';
%             n_t = '(z)';
%             unit = '''[m]''';
%             data_ = load('water_level');
%             [len_rec,~] = size(data_);
        end
        % 按行循环写入bct文件中
        line1 = ['table-name           ''Boundary Section : ',num2str(Bou_Sec),''''];
        line2 = 'contents             ''Uniform             ''';
        line3 = ['location             ''',location,'              '''];
        line4 = 'time-function        ''non-equidistant''';
        line5 = ['reference-time       ',handles.itdate]; % 此处20170404调用mdf中的参考时间变量Itdate。
        line6 = 'time-unit            ''minutes''';
        line7 = 'interpolation        ''linear''';
        line8 = 'parameter            ''time                ''                     unit ''[min]''';
        line9 = ['parameter            ''',name_type,'         ',n_t,'  end A''               unit ',unit];
        line10 = ['parameter            ''',name_type,'         ',n_t,'  end B''               unit ',unit];
        line11 = ['records-in-table     ',num2str(len_rec)];
        for lin = 1:11
            fprintf(bct_file_id,'%s\n',eval(['line',num2str(lin)]));
        end
        for kk = 1:len_rec
            for kkk = 1:3
                fprintf(bct_file_id,'%10.7e\t',data_(kk,kkk));
            end
            fprintf(bct_file_id,'\n');
        end
    end
end
bct_file_index = fclose(bct_file_id);
% 判断AZ_name及CR_name是否存在
if ~exist('AZ_name','var')
    AZ_name = {};
else
end

if ~exist('CR_name','var')
    CR_name = {};
else
end

[row_Z,~] = size(AZ_name);
[row_CR,~] = size(CR_name);
A_name = [AZ_name;CR_name];
% 外循环根据comp_name循环打开需要的分潮，内循环循环边界点位信息，查找调和常数，并放入元胞中
lon_com=92:1/16:143;
lat_com=-9:1/16:52;
[lon_com,lat_com] = meshgrid(lon_com,lat_com);

% % 获取分潮数量
[~,row2] = size(handles.comp_now);
% fid_comp = fopen('comp_name','rt');
[in,~] = size(A_name);

method = 'nearest';
waitbar(0.05,hwait,'正在查询数据库...');
for j = 1:row2
    % 先判断是否需要打开文件载入数据库
%     comp_name = fscanf(fid_comp,'%s',1);
    comp_name = handles.comp_now{j};
    
    if row_Z>0
        Dir_comp = [dir,'\H\',comp_name];
        % 获取分潮的幅值和相位
        a1 = importdata(Dir_comp);
        a1 = a1.data;
        p1 = textread(Dir_comp,'','headerlines',979);
        % 内循环点位
        for k = 1:row_Z
            S1  = A_name(k,:); 
            P = per_process_MN2ll(S1,handles.x_grid',handles.y_grid');
            a = interp2(lon_com,lat_com,a1,P(1,1),P(1,2),method);
            p = interp2(lon_com,lat_com,p1,P(1,1),P(1,2),method);
            aa = num2str(a/100,'%10.7e');
            pp = num2str(p,'%10.7e');
            bca_row(row2*(k-1)+j,:) = {comp_name,aa,pp};
        end
    end
    
    % 判断是否需要打开U、V流速文件，如果需要，则根据东西南北边界判断打开U还是V文件
    if row_CR>0
        row_ew = 0;
        row_sn = 0;
       for i = 1:row_CR
           mu = isequal(CR_name{i}(1),'e')||isequal(CR_name{i}(1),'w');
           mv = isequal(CR_name{i}(1),'s')||isequal(CR_name{i}(1),'n');
           row_ew = mu+row_ew;
           row_sn = mv+row_sn;
       end
       
       if row_ew ~= 0
%            comp_name = fscanf(fid_comp,'%s',1);
           Dir_comp = [dir,'\U\',comp_name];
           % 获取分潮的速度幅值和相位
           u1 = importdata(Dir_comp);
           u1 = u1.data;
           pl1 = textread(Dir_comp,'','headerlines',979);
           % 内循环点位
           for k = 1:row_ew
               S1  = A_name(k+row_ew,:); 
               P = per_process_MN2ll(S1,handles.x_grid',handles.y_grid');
               a = interp2(lon_com,lat_com,u1,P(1,1),P(1,2),method);
               p = interp2(lon_com,lat_com,pl1,P(1,1),P(1,2),method);
               aa = num2str(a,'%10.7e');
               pp = num2str(p,'%10.7e');
               bca_row(row2*(k-1)+j+row2*row_Z,:) = {comp_name,aa,pp};
           end
       end
       
       if row_sn ~= 0
           Dir_comp = [dir,'\V\',comp_name];
           % 获取分潮的速度幅值和相位
           v1 = importdata(Dir_comp);
           v1 = v1.data;
           pl2 = textread(Dir_comp,'','headerlines',979);
           % 内循环点位
           for k = 1:row_sn
               S1  = A_name(k+row_ew,:); 
               P = per_process_MN2ll(S1,handles.x_grid',handles.y_grid');
               a = interp2(lon_com,lat_com,v1,P(1,1),P(1,2),method);
               p = interp2(lon_com,lat_com,pl2,P(1,1),P(1,2),method);
               aa = num2str(a,'%10.7e');
               pp = num2str(p,'%10.7e');
               bca_row(row2*(k-1)+j+row2*(row_Z+row_ew),:) = {comp_name,aa,pp};
           end
       end             
    end
    waitbar((0.05+0.9*j/row2),hwait,'正在查询数据库...');
end
waitbar(0.95,hwait,'正在写入文件...');
bca = cell(row2*in+in,3);
for i = 1:in
    bca((row2*(i-1)+i),:) = {A_name{i,1},' ',' '};
    bca((row2*(i-1)+1+i):(row2*i+i),:) = bca_row((row2*(i-1)+1):(row2*i),:);
end
% [nrows,~] = size(bca);
for i = 1:in
    fprintf(bca_file_id,'%s\n',bca{(i-1)*row2+i,1});
    for j = 1:row2
        fprintf(bca_file_id,'%s   %s   %s\n',bca{(row2*(i-1)+j+i),:});
    end
end
bca_file_index = fclose(bca_file_id);
if (isequal(bca_file_index,0)&&isequal(bct_file_index,0))
    waitbar(1,hwait,'设置完成...');
    close(hwait)
%     uiwait(msgbox('分潮设置成功！','提示','help'))
else
    close(hwait)
    uiwait(msgbox('分潮设置失败！','错误','error'))
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function obs_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obs_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function uipanel5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function wathe_depth_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wathe_depth_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function clean_grid_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clean_grid_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
