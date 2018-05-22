function varargout = configuration(varargin)
% CONFIGURATION MATLAB code for configuration.fig
%      CONFIGURATION, by itself, creates a new CONFIGURATION or raises the existing
%      singleton*.
%
%      H = CONFIGURATION returns the handle to a new CONFIGURATION or the handle to
%      the existing singleton*.
%
%      CONFIGURATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIGURATION.M with the given input arguments.
%
%      CONFIGURATION('Property','Value',...) creates a new CONFIGURATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before configuration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to configuration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help configuration

% Last Modified by GUIDE v2.5 10-May-2018 10:06:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @configuration_OpeningFcn, ...
                   'gui_OutputFcn',  @configuration_OutputFcn, ...
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


% --- Executes just before configuration is made visible.
function configuration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to configuration (see VARARGIN)

% Choose default command line output for configuration
% handles.output = hObject;
warning('off')
handles.output = hObject;
env_path = getenv('sandWave');
h = handles.config_set; %返回其句柄
ico = [env_path,'sandWave_resources\icon_32.png'];
newIcon = javax.swing.ImageIcon(ico);
figFrame = get(h,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标

if (~isempty(varargin{2}))
    handles.water_path = varargin{2};
else
    handles.water_path = '';
end
if(~isempty(varargin{3}))
    handles.comp_base_path = varargin{3};
else
    handles.comp_base_path = '';
end
set(handles.comp_base_set,'string',handles.comp_base_path);
set(handles.water_set,'string',handles.water_path);
% Update handles structure
guidata(hObject, handles);
uiwait(handles.config_set);
% UIWAIT makes configuration wait for user response (see UIRESUME)
% uiwait(handles.config_set);


% --- Outputs from this function are returned to the command line.
function varargout = configuration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.water_path;
varargout{2} = handles.comp_base_path;
delete(hObject);


% --- Executes on button press in selective_water_button.
function selective_water_button_Callback(hObject, eventdata, handles)
% hObject    handle to selective_water_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname = uigetdir('*.*','请选择求解器所在目录');
if (isequal(pathname,0))
    if(~isempty(handles.water_path))
        msg = {'您没有选择任何新的目录，系统将使用您先前设置的目录：';handles.water_path};
        msgbox(msg,'警告','warn');
        set(handles.water_set,'string',handles.water_path);
    else
        msgbox('您没有选择任何目录, 请重新选择!','Error','error');
        handles.water_path = '';
    end
    return
else
    handles.water_path = pathname;
    set(handles.water_set,'string',handles.solver_path);
end
guidata(hObject, handles); 

% --- Executes on button press in selective_comp_base_button.
function selective_comp_base_button_Callback(hObject, eventdata, handles)
% hObject    handle to selective_comp_base_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname = uigetdir('*.*','请选择分潮库所在目录');
if (isequal(pathname,0))
    if(~isempty(handles.comp_base_path))
        msg = {'您没有选择任何新的目录，系统将使用您先前设置的目录：';handles.comp_base_path};
        msgbox(msg,'警告','warn');
        set(handles.comp_base_set,'string',handles.comp_base_path);
    else
        msgbox('您没有选择任何目录, 请重新选择!','Error','error');
        handles.comp_base_path = '';
    end
    return
else
    handles.comp_base_path = pathname;
    set(handles.comp_base_set,'string',handles.comp_base_path);
end
guidata(hObject, handles); 

% --- Executes on button press in close_config_button.
function close_config_button_Callback(hObject, eventdata, handles)
% hObject    handle to close_config_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
config_set_CloseRequestFcn(hObject, eventdata, handles);
handles = guidata(hObject);
guidata(hObject, handles);

% --- Executes when user attempts to close config_set.
function config_set_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to config_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
uiresume(handles.config_set) 
