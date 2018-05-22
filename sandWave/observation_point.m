function varargout = observation_point(varargin)
% OBSERVATION_POINT MATLAB code for observation_point.fig
%      OBSERVATION_POINT, by itself, creates a new OBSERVATION_POINT or raises the existing
%      singleton*.
%
%      H = OBSERVATION_POINT returns the handle to a new OBSERVATION_POINT or the handle to
%      the existing singleton*.
%
%      OBSERVATION_POINT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OBSERVATION_POINT.M with the given input arguments.
%
%      OBSERVATION_POINT('Property','Value',...) creates a new OBSERVATION_POINT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before observation_point_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to observation_point_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help observation_point

% Last Modified by GUIDE v2.5 18-Apr-2018 15:06:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @observation_point_OpeningFcn, ...
                   'gui_OutputFcn',  @observation_point_OutputFcn, ...
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


% --- Executes just before observation_point is made visible.
function observation_point_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to observation_point (see VARARGIN)

% Choose default command line output for observation_point
% handles.output = hObject;
warning('off')
env_path = getenv('sandWave');
h = handles.obs_set; %返回其句柄
ico = [env_path,'sandWave_resources\icon_32.png'];
newIcon = javax.swing.ImageIcon(ico);
figFrame = get(h,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标

handles.workpath = varargin{5};
global observation_point_handle_old;
if (isempty(observation_point_handle_old))
    handles.obs_id = varargin{1};
    handles.obs_value = varargin{2};
    handles.x_grid = varargin{3};
    handles.y_grid = varargin{4};
    handles.obs_row_name = {'监测点1','监测点2','监测点3','监测点4','监测点5'};
    handles.now_row_id = NaN;
    set(handles.obs_table,'data',handles.obs_value);%进入该GUI界面时，初始化uitable内容为空。
    set(handles.obs_table,'RowName',handles.obs_row_name);
else
    handles = observation_point_reconsitution(handles);
end

% Update handles structure
guidata(hObject, handles);
uiwait(hObject);

% UIWAIT makes observation_point wait for user response (see UIRESUME)
% uiwait(handles.obs_set);


% --- Outputs from this function are returned to the command line.
function varargout = observation_point_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
global observation_point_handle_old;
[row,~] = size(handles.obs_id);
handles.output = row;
varargout{1} = handles.output;
observation_point_handle_old = handles;
delete(hObject)



% --- Executes when selected cell(s) is changed in obs_table.
function obs_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to obs_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
if (~isempty(eventdata.Indices))
    handles.now_row_id = eventdata.Indices(1);
else
    return;
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function obs_table_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obs_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in add_obs_button.
function add_obs_button_Callback(hObject, eventdata, handles)
% hObject    handle to add_obs_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.obs_value = [handles.obs_value;{'',''}];
handles.obs_id = [handles.obs_id;{'',''}]; 
set(handles.obs_table,'data',handles.obs_value)
[~,num] = size(handles.obs_row_name);
handles.obs_row_name = [handles.obs_row_name,{['监控点',num2str(num+1)]}];
set(handles.obs_table,'RowName',handles.obs_row_name);
guidata(hObject, handles);


% --- Executes on button press in delete_obs_button.
function delete_obs_button_Callback(hObject, eventdata, handles)
% hObject    handle to delete_obs_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[row,~ ] = size(handles.obs_value);
if(isnan(handles.now_row_id)||handles.now_row_id >= row)
    handles.now_row_id = row;
end
handles.obs_value(handles.now_row_id,:) = [];
handles.obs_id(handles.now_row_id,:) = [];
set(handles.obs_table,'data',handles.obs_value)
handles.obs_row_name = handles.obs_row_name(1:end-1);
set(handles.obs_table,'RowName',handles.obs_row_name);
guidata(hObject, handles);

% --- Executes on button press in obs_close_button.
function obs_close_button_Callback(hObject, eventdata, handles)
% hObject    handle to obs_close_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
obs_set_CloseRequestFcn(hObject, eventdata, handles);
handles = guidata(hObject);
guidata(hObject, handles);

% --- Executes on button press in clean_obs_button.
function clean_obs_button_Callback(hObject, eventdata, handles)
% hObject    handle to clean_obs_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.obs_value = {'',''};
handles.obs_id = {'',''};
handles.obs_row_name = {'监控点1'};
set(handles.obs_table,'data',handles.obs_value);
set(handles.obs_table,'RowName',{'监控点1'});
guidata(hObject, handles);


% --- Executes when entered data in editable cell(s) in obs_table.
function obs_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to obs_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
if(isempty(eventdata.Error))
    row = eventdata.Indices(1);
    col = eventdata.Indices(2);
    if (ischar(eventdata.NewData))
        NewData = str2double(eventdata.NewData);
        if(isnan(NewData))
            uiwait(msgbox('输入非法，请重新输入！','错误','error'));
            return;
        end
    end
    if(isequal(col,1))
        if(NewData < handles.x_grid(1)||NewData > handles.x_grid(end))
            uiwait(msgbox('所输入的经度不在网格区间内','错误','error'));
            return;
        else
            obs_x = abs(handles.x_grid(1,:)-NewData);
            [~,x_id] = find(obs_x == min(min(obs_x)));
            handles.obs_value{row,col} = NewData;
            handles.obs_id{row,col} = x_id;
        end
    else
        if(NewData < handles.y_grid(1)||NewData > handles.y_grid(end))
            uiwait(msgbox('所输入的纬度不在网格区间内','错误','error'));
            return;
        else
            obs_y = abs(handles.y_grid(1,:)-NewData);
            [~,y_id] = find(obs_y == min(min(obs_y)));
            handles.obs_value{row,col} = NewData;
            handles.obs_id{row,col} = y_id;
        end
    end
else
    uiwait(msgbox('输入非法，请重新输入！','错误','error'));
end
set(handles.obs_table,'data',handles.obs_value);
guidata(hObject, handles);
    


% --- Executes when user attempts to close obs_set.
function obs_set_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to obs_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
obs_file_id = fopen([handles.workpath,'\1.obs'],'wt');
[row,col] = size(handles.obs_id);
for i = 1:row
    for j = 1:col
        if(isempty(handles.obs_id{i,j}))
            if(j == 1)
                uiwait(msgbox(['监控点',num2str(i),'的经度值为空或输入错误，请重新输入或删除该监控点'],'错误','error'));
                return;
            else
                uiwait(msgbox(['监控点',num2str(i),'的纬度值为空或输入错误，请重新输入或删除该监控点'],'错误','error'));
                return;
            end
        end
    end
end
for i = 1:row
    fprintf(obs_file_id,'%s                  %d    %d\n',['obs',num2str(i)],handles.obs_id{i,1},handles.obs_id{i,2});
end
obs_file_status = fclose(obs_file_id);
if(~isequal(obs_file_status,0))
    uiwait(msgbox('写入文件失败','错误','error'));
    return;
end
uiresume(handles.obs_set) ;
