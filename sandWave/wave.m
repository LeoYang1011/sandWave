function varargout = wave(varargin)
% WAVE MATLAB code for wave.fig
%      WAVE, by itself, creates a new WAVE or raises the existing
%      singleton*.
%
%      H = WAVE returns the handle to a new WAVE or the handle to
%      the existing singleton*.
%
%      WAVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAVE.M with the given input arguments.
%
%      WAVE('Property','Value',...) creates a new WAVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wave_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wave_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wave

% Last Modified by GUIDE v2.5 11-May-2018 22:56:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wave_OpeningFcn, ...
                   'gui_OutputFcn',  @wave_OutputFcn, ...
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


% --- Executes just before wave is made visible.
function wave_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wave (see VARARGIN)

% Choose default command line output for wave
warning('off')
env_path = getenv('sandWave');
h = handles.wave_fig; %返回其句柄
ico = [env_path,'sandWave_resources\icon_32.png'];
newIcon = javax.swing.ImageIcon(ico);
figFrame = get(h,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标

handles.output = hObject;
if (~isempty(varargin{2}))
    handles.workpath = varargin{2};
else
    handles.workpath = 'no_path';
end
if (~isempty(varargin{3}))
    handles.water_depth_file_path = varargin{3};
else
    handles.water_depth_file_path = '';
end

if (~isempty(varargin{4}))
    handles.claculation_content_status = varargin{4};
else
    handles.claculation_content_status = [];
end
if (~isempty(varargin{5}))
    handles.C_delta_t = varargin{5};
else
    handles.C_delta_t = NaN;
end
if (~isempty(varargin{6}))
    handles.ref_time = varargin{6};
else
    handles.ref_time = '';
end
global wave_handles_old;
if (isempty(wave_handles_old))
    set(handles.wave_file_generate_button,'Enable','off')
    clear_baisc_button_Callback(hObject, eventdata, handles)
    handles=guidata(hObject);
    clear_boundary_button_Callback(hObject, eventdata, handles)
    handles=guidata(hObject);
    clear_processes_button_Callback(hObject, eventdata, handles)
    handles=guidata(hObject);
else
    handles = wave_reconsitution(handles);
end
% Update handles structure
guidata(hObject, handles);
uiwait(hObject)
% UIWAIT makes wave wait for user response (see UIRESUME)
% uiwait(handles.wave_fig);


% --- Outputs from this function are returned to the command line.
function varargout = wave_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.hydro_grid_switch_status;
global wave_handles_old;
wave_handles_old = handles;
delete(hObject)


% --- Executes on button press in hydro_grid_switch.
function hydro_grid_switch_Callback(hObject, eventdata, handles)
% hObject    handle to hydro_grid_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ( get(hObject,'Value') ==0 )
    handles.hydro_grid_switch_status = 0;
    if(isequal(handles.coordinate,'Cartesian'))
        set(handles.coordinate_select,'Enable','on','Value',1);
    else
        set(handles.coordinate_select,'Enable','on','Value',2);
    end
    if(~isnan(handles.dy))
        set(handles.dy_input,'Enable','on','string',num2str(handles.dy));
    else
        set(handles.dy_input,'Enable','on','string','');
    end
    if(~isnan(handles.lat_min))
        set(handles.lat_min_input,'Enable','on','string',num2str(handles.lat_min));
    else
        set(handles.lat_min_input,'Enable','on','string','');
    end
    if(~isnan(handles.lat_max))
        set(handles.lat_max_input,'Enable','on','string',num2str(handles.lat_max));
    else
        set(handles.lat_max_input,'Enable','on','string','');
    end
    if(~isnan(handles.lon_min))
        set(handles.lon_min_input,'Enable','on','string',num2str(handles.lon_min));
    else
        set(handles.lon_min_input,'Enable','on','string','');
    end
    if(~isnan(handles.dx))
        set(handles.dx_input,'Enable','on','string',num2str(handles.dx));
    else
        set(handles.dx_input,'Enable','on','string','');
    end
    if(~isnan(handles.lon_max))
        set(handles.lon_max_input,'Enable','on','string',num2str(handles.lon_max));
    else
        set(handles.lon_max_input,'Enable','on','string','');
    end
    if(~isempty(handles.water_depth_file_path))
        set(handles.water_depth_file_way_set,'string',handles.water_depth_file_path);
    else
        set(handles.water_depth_file_way_set,'string','');
    end
    set(handles.water_depth_choose_button,'Enable','on')
    if (isequal(handles.generat_mesh_depth_button_status,ones(1,7)))
        set(handles.generat_mesh_depth_button,'Enable','on')
    else
        set(handles.generat_mesh_depth_button,'Enable','off')
    end
else
    handles.hydro_grid_switch_status = 1;
    set(handles.coordinate_select,'Enable','off','Value',1);
    set(handles.dy_input,'Enable','off','string','')
    set(handles.lat_min_input,'Enable','off','string','')
    set(handles.lat_max_input,'Enable','off','string','')
    set(handles.lon_min_input,'Enable','off','string','')
    set(handles.dx_input,'Enable','off','string','')
    set(handles.lon_max_input,'Enable','off','string','')
    set(handles.water_depth_choose_button,'Enable','off')
    set(handles.water_depth_file_way_set,'string','');
    set(handles.generat_mesh_depth_button,'Enable','off')
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of hydro_grid_switch



function dy_input_Callback(hObject, eventdata, handles)
% hObject    handle to dy_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of dy_input as text
%        str2double(get(hObject,'String')) returns contents of dy_input as a double
handles.dy = str2double((get(hObject,'String')));
if (isnan(handles.dy))
    handles.generat_mesh_depth_button_status(1) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.dy_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.generat_mesh_depth_button_status(1) = 1;
end
if (isequal(handles.generat_mesh_depth_button_status,ones(1,6)))
    set(handles.generat_mesh_depth_button,'Enable','on')
else
    set(handles.generat_mesh_depth_button,'Enable','off')
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function dy_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dy_input (see GCBO)
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
% Hints: get(hObject,'String') returns contents of lat_min_input as text
%        str2double(get(hObject,'String')) returns contents of lat_min_input as a double
handles.lat_min = str2double((get(hObject,'String')));
if (isnan(handles.lat_min))
    handles.generat_mesh_depth_button_status(2) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lat_min_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.generat_mesh_depth_button_status(2) = 1;
end
if (isequal(handles.generat_mesh_depth_button_status,ones(1,6)))
    set(handles.generat_mesh_depth_button,'Enable','on')
else
    set(handles.generat_mesh_depth_button,'Enable','off')
end
guidata(hObject,handles);

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



function lat_max_input_Callback(hObject, eventdata, handles)
% hObject    handle to lat_max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of lat_max_input as text
%        str2double(get(hObject,'String')) returns contents of lat_max_input as a double
handles.lat_max = str2double((get(hObject,'String')));
if (isnan(handles.lat_max))
    handles.generat_mesh_depth_button_status(3) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lat_max_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.generat_mesh_depth_button_status(3) = 1;
end
if (isequal(handles.generat_mesh_depth_button_status,ones(1,6)))
    set(handles.generat_mesh_depth_button,'Enable','on')
else
    set(handles.generat_mesh_depth_button,'Enable','off')
end
guidata(hObject,handles);

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



function lon_min_input_Callback(hObject, eventdata, handles)
% hObject    handle to lon_min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of lon_min_input as text
%        str2double(get(hObject,'String')) returns contents of lon_min_input as a double
handles.lon_min = str2double((get(hObject,'String')));
if (isnan(handles.lon_min))
    handles.generat_mesh_depth_button_status(4) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lon_min_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.generat_mesh_depth_button_status(4) = 1;
end
if (isequal(handles.generat_mesh_depth_button_status,ones(1,6)))
    set(handles.generat_mesh_depth_button,'Enable','on')
else
    set(handles.generat_mesh_depth_button,'Enable','off')
end
guidata(hObject,handles);

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



function dx_input_Callback(hObject, eventdata, handles)
% hObject    handle to dx_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of dx_input as text
%        str2double(get(hObject,'String')) returns contents of dx_input as a double
handles.dx = str2double((get(hObject,'String')));
if (isnan(handles.dx))
    handles.generat_mesh_depth_button_status(5) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.dx_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.generat_mesh_depth_button_status(5) = 1;
end
if (isequal(handles.generat_mesh_depth_button_status,ones(1,6)))
    set(handles.generat_mesh_depth_button,'Enable','on')
else
    set(handles.generat_mesh_depth_button,'Enable','off')
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function dx_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dx_input (see GCBO)
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
% Hints: get(hObject,'String') returns contents of lon_max_input as text
%        str2double(get(hObject,'String')) returns contents of lon_max_input as a double
handles.lon_max = str2double((get(hObject,'String')));
if (isnan(handles.lon_max))
    handles.generat_mesh_depth_button_status(6) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.lon_max_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.generat_mesh_depth_button_status(6) = 1;
end
if (isequal(handles.generat_mesh_depth_button_status,ones(1,6)))
    set(handles.generat_mesh_depth_button,'Enable','on')
else
    set(handles.generat_mesh_depth_button,'Enable','off')
end
guidata(hObject,handles);

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


% --- Executes on selection change in boundary_type_select.
function boundary_type_select_Callback(hObject, eventdata, handles)
% hObject    handle to boundary_type_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns boundary_type_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from boundary_type_select
handles.dir = wave_update_dir(handles.last_step,handles.dir,handles);
set(handles.boundary_type_select,'string',handles.dir);
handles.type_id = get(hObject,'Value');
handles.last_step = handles.type_id;
if (handles.type_id ~= 1)
    set(handles.WaveHeight_input,'Enable','on');
    set(handles.Period_input,'Enable','on');
    set(handles.Direction_input,'Enable','on');
    set(handles.DirSpreading_input,'Enable','on');
    if (handles.WaveHeight(handles.type_id-1)||handles.Period (handles.type_id-1)||...
            handles.Direction (handles.type_id-1)||handles.DirSpreading (handles.type_id-1) ~= 4)
        set(handles.WaveHeight_input,'string',num2str(handles.WaveHeight(handles.type_id-1)));
        set(handles.Period_input,'string',num2str(handles.Period (handles.type_id-1)));
        set(handles.Direction_input,'string',num2str(handles.Direction (handles.type_id-1)));
        set(handles.DirSpreading_input,'string',num2str(handles.DirSpreading (handles.type_id-1)));
    else
        set(handles.WaveHeight_input,'string','');
        set(handles.Period_input,'string','');
        set(handles.Direction_input,'string','');
        set(handles.DirSpreading_input,'string',num2str(4));
    end
else
    set(handles.WaveHeight_input,'string','','Enable','off');
    set(handles.Period_input,'string','','Enable','off');
    set(handles.Direction_input,'string','','Enable','off');
    set(handles.DirSpreading_input,'string','4','Enable','off');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function boundary_type_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boundary_type_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WaveHeight_input_Callback(hObject, eventdata, handles)
% hObject    handle to WaveHeight_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of WaveHeight_input as text
%        str2double(get(hObject,'String')) returns contents of WaveHeight_input as a double
handles.WaveHeight(handles.type_id-1) = str2double(get(hObject,'String'));
if(isnan(handles.WaveHeight(handles.type_id-1)))
    handles.WaveHeight(handles.type_id-1) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.WaveHeight_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
end
if (ne(handles.type_id,1) && ne(max(max(handles.WaveHeight)),0) &&  ne(max(max(handles.Period)),0))
    set(handles.wave_file_generate_button,'Enable','on')
    handles.wave_file_generate_button_index = 1;
else
    set(handles.wave_file_generate_button,'Enable','off')
    handles.wave_file_generate_button_index = 0;
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function WaveHeight_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WaveHeight_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Period_input_Callback(hObject, eventdata, handles)
% hObject    handle to Period_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Period_input as text
%        str2double(get(hObject,'String')) returns contents of Period_input as a double
handles.Period(handles.type_id-1) = str2double(get(hObject,'String'));
if(isnan(handles.Period(handles.type_id-1)))
    handles.Period(handles.type_id-1) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.Period_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
end
if (ne(handles.type_id,1) && ne(max(max(handles.WaveHeight)),0) &&  ne(max(max(handles.Period)),0))
    set(handles.wave_file_generate_button,'Enable','on')
    handles.wave_file_generate_button_index = 1;
else
    set(handles.wave_file_generate_button,'Enable','off')
    handles.wave_file_generate_button_index = 0;
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Period_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Period_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Direction_input_Callback(hObject, eventdata, handles)
% hObject    handle to Direction_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Direction_input as text
%        str2double(get(hObject,'String')) returns contents of Direction_input as a double
handles.Direction(handles.type_id-1) = str2double(get(hObject,'String'));
if(isnan(handles.Direction(handles.type_id-1)))
    msgbox('波向将被设置为默认值：0（度）','Warning','warn');
    set(hObject,'String','0')
    handles.Direction(handles.type_id-1) = 0.0;
    uicontrol(handles.Direction_input);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Direction_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Direction_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function DirSpreading_input_Callback(hObject, eventdata, handles)
% hObject    handle to DirSpreading_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of DirSpreading_input as text
%        str2double(get(hObject,'String')) returns contents of DirSpreading_input as a double
handles.DirSpreading(handles.type_id-1) = str2double(get(hObject,'String'));
if(isnan(handles.DirSpreading(handles.type_id-1)))
    msgbox('非法输入，展向将被设置为默认值：4','Warning','warn');
    set(hObject,'String','4')
    handles.DirSpreading(handles.type_id-1) = 4;
    uicontrol(handles.DirSpreading_input);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function DirSpreading_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DirSpreading_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in generat_grid_button.
function generat_grid_button_Callback(hObject, eventdata, handles)
% hObject    handle to generat_grid_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in water_depth_switch.
function water_depth_switch_Callback(hObject, eventdata, handles)
% hObject    handle to water_depth_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ( get(hObject,'Value') ==0 )
    set(handles.water_depth_choose_button,'Enable','off')
    set(handles.water_depth_file_way_set,'Enable','off')
else
    set(handles.water_depth_choose_button,'Enable','on')
    set(handles.water_depth_file_way_set,'Enable','on')
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of water_depth_switch


% --- Executes on button press in water_depth_choose_button.
function water_depth_choose_button_Callback(hObject, eventdata, handles)
% hObject    handle to water_depth_choose_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.flt;','Database file(*.flt)';'*.xyz;','Measurement file(*.xyz)';'*.*',...
    'AllFiles(*.*)'},'请选择数据库文件');
if (isequal(filename,0) && isequal(pathname,0))
    if(isempty(handles.water_depth_file_path))
        msgbox('您没有选择任何数据文件, 请重新选择!','Error','error');
        set(handles.water_depth_file_way_set,'string','');
    else
        msg = {'您没有选择任何新的数据文件，系统将使用您先前的选择的文件：';handles.water_depth_file_path};
        msgbox(msg,'Warning','warn');
        set(handles.water_depth_file_way_set,'string',handles.water_depth_file_path);
    end
    return;
else
    handles.water_depth_file_path = [pathname filename];
    set(handles.water_depth_file_way_set,'string',handles.water_depth_file_path);
end
guidata(hObject, handles); 


% --- Executes on button press in generat_mesh_depth_button.
function generat_mesh_depth_button_Callback(hObject, eventdata, handles)
% hObject    handle to generat_mesh_depth_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wave_file_id = fopen([handles.workpath,'\wave.grd'],'wt');
x_grid = handles.lon_min:handles.dx:handles.lon_max;
y_grid = handles.lat_min:handles.dy:handles.lat_max;
[data_x_grid,data_y_grid] = meshgrid(x_grid,y_grid);

[x_num,y_num] = size(data_x_grid);
line1 = ['Coordinate System = ',handles.coordinate];
fprintf(wave_file_id,'%s\n',line1);
line2 = [y_num,x_num];
fprintf(wave_file_id,'      %s    %s\n',num2str(line2(1,1)),num2str(line2(1,2)));
fprintf(wave_file_id,' %s %s %s\n','0','0','0');

for i = 1:x_num
    line = [' ETA=   ',num2str(i)];
    fprintf(wave_file_id,'%s\t',line);
    fprintf(wave_file_id,'%10.7f\t%10.7f\t%10.7f\t%10.7f\t%10.7f\n',x_grid);
    fprintf(wave_file_id,'\n');
end

for i = 1:x_num
    line = [' ETA=   ',num2str(i)];
    yy_grid = y_grid(1,i)*ones(1,y_num);
    fprintf(wave_file_id,'%s\t',line);
    fprintf(wave_file_id,'%10.7f\t%10.7f\t%10.7f\t%10.7f\t%10.7f\n',yy_grid);
    fprintf(wave_file_id,'\n');
end
wave_file_id_status = fclose(wave_file_id);

if(isequal(handles.water_depth_file_path(end-3:end),'.flt'))
    lon_lim = [handles.lon_min handles.lon_max];
    lat_lim = [handles.lat_min handles.lat_max];
    [topo,~] = etopo(handles.water_depth_file_path, 1, lat_lim, lon_lim);
    topo=-1*topo;
    topo(topo<0)=-999;
    
    [m_1,n_1] = size(topo);
    dx_1 = (handles.lat_max-handles.lat_min)/(m_1-1);
    dy_1 = (handles.lon_max-handles.lon_min)/(n_1-1);
    
    lat = handles.lat_min:dx_1:handles.lat_max;
    lon = handles.lon_min:dy_1:handles.lon_max;
    
    [Lon,Lat] = meshgrid(lon,lat);
    dep = griddata(Lon,Lat,topo,data_x_grid,data_y_grid);
else
    water_depth_data = load(handles.water_depth_file_path);
    x_meas = water_depth_data(:,1);
    y_meas = water_depth_data(:,2);
    z_meas = water_depth_data(:,3);
    dep = griddata(x_meas,y_meas,z_meas,data_x_grid,data_y_grid);
end
dep = [dep,-999*ones(x_num,1)];
dep = [dep;-999*ones(1,y_num+1)];
save([handles.workpath,'\wave.dep'],'dep','-ascii');

if (isequal(wave_file_id_status,0))
    msgbox('网格及水深生成成功','提示','help');
else
    msgbox('网格及水深生成失败','错误','error');
end
guidata(hObject, handles); 

% --- Executes on button press in Breaking_switch.
function Breaking_switch_Callback(hObject, eventdata, handles)
% hObject    handle to Breaking_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Breaking_switch
if ( get(hObject,'Value') ==0 )
    set(handles.BreakAlpha_input,'Enable','off','string','')
    set(handles.BreakGamma_input,'Enable','off','string','')
    handles.Breaking = 'false';
else
    set(handles.BreakAlpha_input,'Enable','on','string','1')
    set(handles.BreakGamma_input,'Enable','on','string','0.73')
    handles.Breaking = 'ture';
end
guidata(hObject, handles); 

% --- Executes on button press in Triads_switch.
function Triads_switch_Callback(hObject, eventdata, handles)
% hObject    handle to Triads_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Triads_switch
if ( get(hObject,'Value') ==0 )
    set(handles.TriadsAlpha_input,'Enable','off','string','')
    set(handles.TriadsBeta_input,'Enable','off','string','')
    handles.Triads = 'false';
else
    set(handles.TriadsAlpha_input,'Enable','on','string','0.1')
    set(handles.TriadsBeta_input,'Enable','on','string','2.2')
    handles.Triads = 'ture';
end
guidata(hObject, handles); 

% --- Executes on button press in BedFricCoef_switch.
function BedFricCoef_switch_Callback(hObject, eventdata, handles)
% hObject    handle to BedFricCoef_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BedFricCoef_switch
if ( get(hObject,'Value') ==0 )
    set(handles.BedFricCoef_input,'Enable','off','string','')
    handles.BedFricCoef_switch_index = 0;
else
    set(handles.BedFricCoef_input,'Enable','on','string','0.067')
    handles.BedFricCoef_switch_index = 1;
end
guidata(hObject, handles); 

% --- Executes on button press in WhiteCapping_switch.
function WhiteCapping_switch_Callback(hObject, eventdata, handles)
% hObject    handle to WhiteCapping_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of WhiteCapping_switch
if ( get(hObject,'Value') ==0 )
    handles.WhiteCapping = 'off';
else
    handles.WhiteCapping = 'on';
end
guidata(hObject, handles); 


% --- Executes on button press in Refraction_switch.
function Refraction_switch_Callback(hObject, eventdata, handles)
% hObject    handle to Refraction_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of Refraction_switch
if ( get(hObject,'Value') ==0 )
    handles.Refraction = 'false'; 
else
    handles.Refraction = 'true'; 
end
guidata(hObject, handles); 


% --- Executes on button press in FreqShift_switch.
function FreqShift_switch_Callback(hObject, eventdata, handles)
% hObject    handle to FreqShift_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of FreqShift_switch
if ( get(hObject,'Value') ==0 )
    handles.FreqShift = 'false';
else
    handles.FreqShift = 'true';
end
guidata(hObject, handles); 

% --- Executes on button press in WindGrowth_switch.
function WindGrowth_switch_Callback(hObject, eventdata, handles)
% hObject    handle to WindGrowth_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of WindGrowth_switch
if ( get(hObject,'Value') ==0 )
    handles.WindGrowth = 'false'; 
else
    handles.WindGrowth = 'ture'; 
end
guidata(hObject, handles); 



function BreakAlpha_input_Callback(hObject, eventdata, handles)
% hObject    handle to BreakAlpha_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of BreakAlpha_input as text
%        str2double(get(hObject,'String')) returns contents of BreakAlpha_input as a double
if (get(handles.BreakAlpha_input,'Enable') == 'on')
    handles.BreakAlpha = str2double(get(hObject,'string'));
    if(isnan(handles.BreakAlpha))
        msgbox('水深引起破碎系数α将被设置为默认值：1','Warning','warn');
        set(hObject,'String','1')
        handles.BreakAlpha = 1;
    end
else
    handles.BreakAlpha = 0;
end
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function BreakAlpha_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BreakAlpha_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BreakGamma_input_Callback(hObject, eventdata, handles)
% hObject    handle to BreakGamma_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of BreakGamma_input as text
%        str2double(get(hObject,'String')) returns contents of BreakGamma_input as a double
if (get(handles.BreakGamma_input,'Enable') == 'on')
    handles.BreakGamma = str2double(get(hObject,'string'));
    if(isnan(handles.BreakGamma))
        msgbox('水深引起破碎系数γ将被设置为默认值：0.73','Warning','warn');
        set(hObject,'String','0.73')
        handles.BreakGamma = 0.73;
    end
else
    handles.BreakGamma = 0;
end
guidata(hObject, handles); 


% --- Executes during object creation, after setting all properties.
function BreakGamma_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BreakGamma_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TriadsAlpha_input_Callback(hObject, eventdata, handles)
% hObject    handle to TriadsAlpha_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of TriadsAlpha_input as text
%        str2double(get(hObject,'String')) returns contents of TriadsAlpha_input as a double
if (get(handles.TriadsAlpha_input,'Enable') == 'on')
    handles.TriadsAlpha = str2double(get(hObject,'string'));
    if(isnan(handles.TriadsAlpha))
        msgbox('非线性波相互作用系数α将被设置为默认值：0.1','Warning','warn');
        set(hObject,'String','0.1')
        handles.TriadsAlpha = 0.1;
    end
else
    handles.TriadsAlpha = 0;
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function TriadsAlpha_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TriadsAlpha_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TriadsBeta_input_Callback(hObject, eventdata, handles)
% hObject    handle to TriadsBeta_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of TriadsBeta_input as text
%        str2double(get(hObject,'String')) returns contents of TriadsBeta_input as a double
if (get(handles.TriadsBeta_input,'Enable') == 'on')
    handles.TriadsBeta = str2double(get(hObject,'string'));
    if(isnan(handles.TriadsBeta))
        msgbox('非线性波相互作用系数β将被设置为默认值：2.2','Warning','warn');
        set(hObject,'String','2.2')
        handles.TriadsBeta = 2.2;
    end
else
    handles.TriadsBeta = 0;
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function TriadsBeta_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TriadsBeta_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in wave_file_generate_button.
function wave_file_generate_button_Callback(hObject, eventdata, handles)
% hObject    handle to wave_file_generate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 打开文件存入头文件信息
if(isequal(handles.claculation_content_status(3),1)||isequal(handles.claculation_content_status(5),1)||isequal(handles.claculation_content_status(6),1))
    couple_flow = 1;
else
    couple_flow = 0;
end
wave_file_id = fopen([handles.workpath,'\1.mdw'],'wt');
line1 = '[WaveFileInformation]';
line2 = '   FileVersion          = 02.00                        ';
fprintf(wave_file_id,'%s\n%s\n',line1,line2);
% 写入通用信息
line3 = '[General]';
fprintf(wave_file_id,'%s\n',line3);
if couple_flow ==1
    simmode = 'non-stationary              ';
    fprintf(wave_file_id,'%s\n','   FlowFile             = 1.mdf                       ');
else
    simmode = 'stationary         ';
end

line5 = '   OnlyInputVerify      = false                        ';
line6 = ['   SimMode              = ',simmode];  % 此处需要选择稳态或非稳态
fprintf(wave_file_id,'%s\n%s\n',line5,line6);

if couple_flow == 1
    fprintf(wave_file_id,'%s\n',['   TimeStep             =  ',num2str(handles.C_delta_t)])
end
line8 = '   DirConvention        = nautical                     ';
if couple_flow == 1
    line9 = ['   ReferenceDate        = ',handles.ref_time,'                   '];
else
    ref_time = [num2str(year(now)),'-',num2str(month(now),'%02d'),'-',num2str(day(now),'%02d')];
    line9 = ['   ReferenceDate        = ',ref_time,'                   '];
end
line10 = ['   WindSpeed            =  ',num2str(handles.WindSpeed,'%10.7e')];
line11 = ['   WindDir              =  ',num2str(handles.WindDir,'%10.7e')];
% 写入文件
for i = 8:11
    fprintf(wave_file_id,'%s\n',eval(['line',num2str(i)]));
end
% 定义一些常量
line12 = '[Constants]';
line13 = '   WaterLevelCorrection =  0.0000000e+000              ';
line14 = '   Gravity              =  9.8100004e+000              ';
line15 = '   WaterDensity         =  1.0250000e+003              ';  % 水的密度，可与水动力的的输入相同。
line16 = '   NorthDir             =  9.0000000e+001              ';
line17 = '   MinimumDepth         =  5.0000001e-002              ';
% 写入文件
for i = 12:17
    fprintf(wave_file_id,'%s\n',eval(['line',num2str(i)]));
end
% 定义物理过程
line18 = '[Processes]';
line19 = '   GenModePhys          = 3                            ';% 第三代波浪模型
line20 = '   WaveSetup            = false                        ';%波浪增水
line21 = ['   Breaking             = ',handles.Breaking];%波浪破碎
line22 = ['   BreakAlpha           =  ',num2str(handles.BreakAlpha,'%10.7e')];
line23 = ['   BreakGamma           =  ',num2str(handles.BreakGamma,'%10.7e')];
line24 = ['   Triads               = ',handles.Triads];
line25 = ['   TriadsAlpha          =  ',num2str(handles.TriadsAlpha,'%10.7e')];
line26 = ['   TriadsBeta           =  ',num2str(handles.TriadsBeta,'%10.7e')];
if (get(handles.BedFricCoef_switch,'Value') == 1)
    line27 = '   BedFriction          = jonswap                      ';
    line28 = ['   BedFricCoef          =  ',num2str(handles.BedFricCoef,'%10.7e')];% 仅提供JONSWAP摩阻
else
    line27 = '   BedFriction          = Non                      ';
    line28 = '';
end
line29 = '   Diffraction          = false                        ';
line30 = '   DiffracCoef          =  2.0000000e-001              ';
line31 = '   DiffracSteps         = 5                            ';
line32 = '   DiffracProp          = true                         ';
line33 = ['   WindGrowth           = ',handles.WindGrowth];
line34 = ['   WhiteCapping         = ',handles.WhiteCapping];
line35 = '   Quadruplets          = false                        ';
line36 = ['   Refraction           = ',handles.Refraction];
line37 = ['   FreqShift            = ',handles.FreqShift];
line38 = '   WaveForces           = radiation stresses           ';
% 写入文件
for i = 18:38
    if (~isempty(eval(['line',num2str(i)])))
        fprintf(wave_file_id,'%s\n',eval(['line',num2str(i)]));
    end
end
% 关于数值方面
line39 = '[Numerics]';
line40 = '   DirSpaceCDD          =  5.0000000e-001      ';
line41 = '   FreqSpaceCSS         =  5.0000000e-001       ';
line42 = '   RChHsTm01            =  2.0000000e-002              ';
line43 = '   RChMeanHs            =  2.0000000e-002              ';
line44 = '   RChMeanTm01          =  2.0000000e-002              ';
line45 = '   PercWet              =  9.8000000e+001              ';
line46 = '   MaxIter              = 15                           ';
% 写入文件
for i = 39:46
    fprintf(wave_file_id,'%s\n',eval(['line',num2str(i)]));
end
% 关于输出
line47 = '[Output]';
line48 = '   TestOutputLevel      = 0             ';
line49 = '   TraceCalls           = false            ';
line50 = '   UseHotFile           = false              ';
% 写入文件
for i = 47:50
    fprintf(wave_file_id,'%s\n',eval(['line',num2str(i)]));
end
if couple_flow == 0
    fprintf(wave_file_id,'%s\n','   WriteCOM             = false                        ');
else
    line51 = ['   MapWriteInterval     =  ',num2str(handles.C_delta_t,'%10.7e'),'      '];       %此处为map文件的保存间隔，是用户输入参数
    line52 = '   WriteCOM             = true                  ';
    line53 = ['   COMWriteInterval     =  ',num2str(handles.C_delta_t,'%10.7e'),'            '];  %此处为关联文件的保存间隔，用户输入参数。
    for i = 51:53
        fprintf(wave_file_id,'%s\n',eval(['line',num2str(i)]));
    end
end

% 关于波浪场
if handles.hydro_grid_switch_status == 0
    grid = 'wave.grd                      ';
    dep = 'wave.dep                      ';
else
    grid = '1.grd                      ';
    dep = '1.dep                      ';
end
fprintf(wave_file_id,'%s\n','[Domain]                    ');
fprintf(wave_file_id,'%s\n',['   Grid                 = ',grid]);
if couple_flow == 1
    line_1 = '   FlowBedLevel         = 0                             ';  %% 这四行是要考虑波浪计算中是否需要考虑的变化。
    line_2 = '   FlowWaterLevel       = 0                             ';  %% 0表示完全不考虑；
    line_3 = '   FlowVelocity         = 0                             ';
    line_4 = '   FlowWind             = 0                             ';
    for i = 1:4
        fprintf(wave_file_id,'%s\n',eval(['line_',num2str(i)]));
    end
else
end

line60 = ['   BedLevel             = ',dep];
line61 = '   DirSpace             = circle                        ';
line62 = '   NDir                 = 36                            ';
line63 = '   StartDir             =  0.0000000e+000               ';
line64 = '   EndDir               =  3.6000000e+002               ';
line65 = '   FreqMin              =  5.0000001e-002               ';
line66 = '   FreqMax              =  1.0000000e+000               ';
line67 = '   NFreq                = 24                            ';
line68 = '   Output               = true                          ';
% 写入文件
for i = 60:68
    fprintf(wave_file_id,'%s\n',eval(['line',num2str(i)]));
end
% 关于边界设置
dir_list = {'east','west','south','north','southeast','southwest','northeast','northwest'};
dir_list_ch = {'东','西','南','北','东南','西南','东北','西北'};
for i = 1:8
    if (handles.WaveHeight(i) ~= 0 && handles.Period(i) ~= 0)
        for j = 1:14
            l1 = '[Boundary]                                  ';
            l2 = ['   Name                 = Boundary ',num2str(i)];
            l3 = '   Definition           = orientation       ';
            l4 = ['   Orientation          = ',dir_list{i}];
            l5 = '   SpectrumSpec         = parametric        ';
            l6 = '   SpShapeType          = jonswap           ';
            l7 = '   PeriodType           = peak              ';
            l8 = '   DirSpreadType        = power             ';
            l9 = '   PeakEnhanceFac       =  3.3000000e+000   ';
            l10 = '   GaussSpread          =  9.9999998e-003   ';
            l11 =[ '   WaveHeight           =  ',num2str(handles.WaveHeight(i),'%10.7e')];  % 输入参数
            l12 =[ '   Period               =  ',num2str(handles.Period(i),'%10.7e')];  % 输入参数
            l13 =['   Direction            =  ',num2str(handles.Direction(i),'%10.7e')];   % 输入参数
            l14 =[ '   DirSpreading         =  ',num2str(handles.DirSpreading(i),'%10.7e')];  % 输入参数
            fprintf(wave_file_id,'%s\n',eval(['l',num2str(j)]));
        end
    elseif ((handles.WaveHeight(i) ~= 0 && handles.Period(i) == 0) ||(handles.WaveHeight(i) == 0 && handles.Period(i) ~= 0))
        msgbox([dir_list_ch{i},'方向上波高或周期输入错误!'],'Error','error') ;
    else
        continue
    end
end
% 关闭文件
if(isequal(fclose(wave_file_id),0))
    msgbox('生成波浪文件成功！','提示','help');
else
    msgbox('生成波浪文件失败！','错误','error');
    return;
end


guidata(hObject, handles);
function WindSpeed_input_Callback(hObject, eventdata, handles)
% hObject    handle to WindSpeed_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of WindSpeed_input as text
%        str2double(get(hObject,'String')) returns contents of WindSpeed_input as a double
handles.WindSpeed = str2double(get(hObject,'string'));
if (isnan(handles.WindSpeed))
    msgbox('非法输入，风速将被设置为默认值：0.0（米/秒）','Warning','warn');
    set(hObject,'String','0.0')
    handles.WindSpeed = 0.0;
    uicontrol(handles.WindSpeed_input);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function WindSpeed_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindSpeed_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WindDir_input_Callback(hObject, eventdata, handles)
% hObject    handle to WindDir_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of WindDir_input as text
%        str2double(get(hObject,'String')) returns contents of WindDir_input as a double
handles.WindDir = str2double(get(hObject,'string'));
if (isnan(handles.WindDir))
    msgbox('风向将被设置为默认值：0.0（度）','Warning','warn');
    set(hObject,'String','0.0')
    handles.WindDir = 0.0;
    uicontrol(handles.WindDir_input);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function WindDir_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindDir_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BedFricCoef_input_Callback(hObject, eventdata, handles)
% hObject    handle to BedFricCoef_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of BedFricCoef_input as text
%        str2double(get(hObject,'String')) returns contents of BedFricCoef_input as a double
if (get(handles.BedFricCoef_input,'Enable') == 'on')
    handles.BedFricCoef = str2double(get(hObject,'string'));
    if(isnan(handles.BedFricCoef ))
        msgbox('底摩阻系数将被设置为默认值：0.067','Warning','warn');
        set(hObject,'string','0.067')
        handles.BedFricCoef  = 0.067;
    end
else
    handles.BedFricCoef = 0;
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function BedFricCoef_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BedFricCoef_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in clear_baisc_button.
function clear_baisc_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_baisc_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (isequal(handles.claculation_content_status(2),1))
    set(handles.hydro_grid_switch,'Enable','off');
    set(handles.coordinate_select,'Enable','on','Value',1);
    set(handles.water_depth_choose_button,'Enable','on')
    set(handles.water_depth_file_way_set,'Enable','on','string',handles.water_depth_file_path)
    set(handles.dy_input,'Enable','on','string','')
    set(handles.lat_min_input,'Enable','on','string','')
    set(handles.lat_max_input,'Enable','on','string','')
    set(handles.lon_min_input,'Enable','on','string','')
    set(handles.dx_input,'Enable','on','string','')
    set(handles.lon_max_input,'Enable','on','string','')
    handles.hydro_grid_switch_status = 0;
else
    set(handles.hydro_grid_switch,'Value',1,'Enable','on')
    set(handles.coordinate_select,'Enable','off','Value',1);
    set(handles.water_depth_choose_button,'Enable','off')
    set(handles.water_depth_file_way_set,'Enable','off','string','')
    set(handles.dy_input,'Enable','off','string','')
    set(handles.lat_min_input,'Enable','off','string','')
    set(handles.lat_max_input,'Enable','off','string','')
    set(handles.lon_min_input,'Enable','off','string','')
    set(handles.dx_input,'Enable','off','string','')
    set(handles.lon_max_input,'Enable','off','string','')
    handles.hydro_grid_switch_status = 1;
end
set(handles.generat_mesh_depth_button,'Enable','off')
set(handles.WindSpeed_input,'string','0.0');
set(handles.WindDir_input,'string','0.0');
handles.coordinate = 'Cartesian';
handles.dy = NaN;
handles.lat_min = NaN;
handles.lat_max = NaN;
handles.dx = NaN;
handles.lon_min = NaN;
handles.lon_max = NaN;
handles.generat_mesh_depth_button_status = zeros(1,6);
handles.WindSpeed = 0.0;
handles.WindDir = 0.0;
guidata(hObject, handles);

% --- Executes on button press in clear_boundary_button.
function clear_boundary_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_boundary_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.WaveHeight_input,'string','','Enable','off');
set(handles.Period_input,'string','','Enable','off');
set(handles.Direction_input,'string','','Enable','off');
set(handles.DirSpreading_input,'string','4','Enable','off');
handles.WaveHeight = zeros(8,1);
handles.Period = zeros(8,1);
handles.Direction = zeros(8,1);
handles.DirSpreading = ones(8,1)*4;
handles.type_id = 1;
handles.last_step = handles.type_id;
handles.dir = {'     请选择边界...',...
    '              东','              西','              南'...
    '              北 ','            东南','            西南',...
    '            东北','            西北'};
for i = 1:length(handles.dir)
    handles.dir = wave_update_dir(i,handles.dir,handles);
end
set(handles.boundary_type_select,'string',handles.dir);  
set(handles.boundary_type_select,'Value',1); 
handles.wave_file_generate_button_index = 0;
guidata(hObject, handles);


% --- Executes on button press in clear_processes_button.
function clear_processes_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_processes_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Breaking_switch,'Value',1)
set(handles.Triads_switch,'Value',0)
set(handles.WhiteCapping_switch,'Value',0)
set(handles.WindGrowth_switch,'Value',0)
set(handles.TriadsAlpha_input,'Enable','off')
set(handles.TriadsBeta_input,'Enable','off')
set(handles.BedFricCoef_switch,'Value',1)
set(handles.Refraction_switch,'Value',1)
set(handles.FreqShift_switch,'Value',1)
set(handles.BreakAlpha_input,'string','1')
set(handles.BreakGamma_input,'string','0.73')
set(handles.TriadsAlpha_input,'string','0.1')
set(handles.TriadsBeta_input,'string','2.2')
set(handles.BedFricCoef_input,'string','0.067')
handles.Breaking = 'true';
handles.Triads = 'false';
handles.WhiteCapping = 'off';
handles.Refraction = 'true'; 
handles.FreqShift = 'true';
handles.WindGrowth = 'false'; 
handles.BreakAlpha = 1;
handles.BreakGamma = 0.73;
handles.TriadsAlpha = 0.1;
handles.TriadsBeta = 2.2;
handles.BedFricCoef = 0.067;
handles.BedFricCoef_switch_index = 1;
guidata(hObject, handles);

% --- Executes on button press in clear_all_button.
function clear_all_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_all_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear_baisc_button_Callback(hObject, eventdata, handles)
handles=guidata(hObject);
clear_boundary_button_Callback(hObject, eventdata, handles)
handles=guidata(hObject);
clear_processes_button_Callback(hObject, eventdata, handles)
handles=guidata(hObject);
guidata(hObject, handles);


% --- Executes when user attempts to close wave_fig.
function wave_fig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to wave_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(hObject) 


% --- Executes on selection change in coordinate_select.
function coordinate_select_Callback(hObject, eventdata, handles)
% hObject    handle to coordinate_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns coordinate_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from coordinate_select
coor = {'Spherical','Cartesian'};
handles.coordinate = coor{get(handles.coordinate_select,'Value')};
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
