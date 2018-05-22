function varargout = sediment_features(varargin)
% sediment_features MATLAB code for sediment_features.fig
%      sediment_features, by itself, creates a new sediment_features or raises the existing
%      singleton*.
%
%      H = sediment_features returns the handle to a new sediment_features or the handle to
%      the existing singleton*.
%
%      sediment_features('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in sediment_features.M with the given input arguments.
%
%      sediment_features('Property','Value',...) creates a new sediment_features or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sediment_features_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sediment_features_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sediment_features

% Last Modified by GUIDE v2.5 11-May-2018 22:54:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sediment_features_OpeningFcn, ...
                   'gui_OutputFcn',  @sediment_features_OutputFcn, ...
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


% --- Executes just before sediment_features is made visible.
function sediment_features_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sediment_features (see VARARGIN)

% Choose default command line output for sediment_features
warning('off')
env_path = getenv('sandWave');
h = handles.sediment_fig; %返回其句柄
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
global  sediment_features_handles_old;
if (isempty(sediment_features_handles_old))
    %设置窗口开关及值
    set(handles.rhos_input,'string','2650');
    set(handles.sediment_file_button,'Enable','off');
    set(handles.Morstt_input,'string','','Enable','off');
    set(handles.Morfac_input,'string','','Enable','off');
    set(handles.MorUpd_select,'Value',1,'Enable','off');
    set(handles.Bed_select,'Value',1,'Enable','off');
    set(handles.Sus_input,'Value',1,'Enable','off');
    set(handles.morphology_file_button,'Enable','off');
    %参数定义及初始值
    handles.rhos = 2650;
    handles.ST = 0;
    handles.D50 = 0;
    handles.CDryB = 1600;
    handles.sediment_file_index = zeros(1,2);
    handles.sediment_file_button_index = 0;
    handles.Morstt = 0;
    handles.Morfac = 1;
    handles.Sus_id = 1;
    handles.Bed_id = 1;
    handles.MorUpd_id = 1;
else
    handles = sediment_features_reconsitution(handles);
end
% Update handles structure
guidata(hObject, handles);
uiwait(hObject);
% UIWAIT makes sediment_features wait for user response (see UIRESUME)
% uiwait(handles.sediment_fig);


% --- Outputs from this function are returned to the command line.
function varargout = sediment_features_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global  sediment_features_handles_old;
sediment_features_handles_old = handles;
delete(hObject)



function Morfac_input_Callback(hObject, eventdata, handles)
% hObject    handle to Morfac_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Morfac_input as text
%        str2double(get(hObject,'String')) returns contents of Morfac_input as a double
handles.Morfac = str2double(get(hObject,'String'));
if(isnan(handles.Morfac)||handles.Morfac<1)
    msgbox('非法输入，地貌加速因子将被设置为默认值：1','Warning','warn');
    set(hObject,'String','1')
    handles.Morfac = 1;
    uicontrol(handles.Morfac_input);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Morfac_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Morfac_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rhos_input_Callback(hObject, eventdata, handles)
% hObject    handle to rhos_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of rhos_input as text
%        str2double(get(hObject,'String')) returns contents of rhos_input as a double
handles.rhos = str2double(get(hObject,'String'));
if(isnan(handles.rhos))
    msgbox('非法输入，泥沙密度将被设置为默认值：2650','Warning','warn');
    set(hObject,'String','2650')
    handles.rhos = 2650;
    uicontrol(handles.rhos_input);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rhos_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rhos_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function D50_input_Callback(hObject, eventdata, handles)
% hObject    handle to D50_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of D50_input as text
%        str2double(get(hObject,'String')) returns contents of D50_input as a double
handles.D50 = str2double(get(hObject,'String'));
if(isnan(handles.D50))
    handles.D50 = 0;
    handles.sediment_file_index(1) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.D50_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.sediment_file_index(1) = 1;
end
if(isequal(handles.sediment_file_index,ones(1,2)))
    set(handles.sediment_file_button,'Enable','on');
else
    set(handles.sediment_file_button,'Enable','off');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function D50_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D50_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CDryB_input_Callback(hObject, eventdata, handles)
% hObject    handle to CDryB_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of CDryB_input as text
%        str2double(get(hObject,'String')) returns contents of CDryB_input as a double
handles.CDryB = str2double(get(hObject,'String'));
if(isnan(handles.CDryB))
    msgbox('非法输入，干床密度将被设置为默认值：1600','Warning','warn');
    set(hObject,'String','1600')
    handles.CDryB = 1600;
    uicontrol(handles.CDryB_input);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function CDryB_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CDryB_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ST_input_Callback(hObject, eventdata, handles)
% hObject    handle to ST_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of ST_input as text
%        str2double(get(hObject,'String')) returns contents of ST_input as a double
handles.ST = str2double(get(hObject,'String'));
if(isnan(handles.ST))
    handles.ST = 0;
    handles.sediment_file_index(2) = 0;
    if (~isempty(get(hObject,'String')))
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
        set(hObject,'Backgroundcolor',[0.8,0.2,0.2],'string','');
        uicontrol(handles.ST_input);
        return;
    end
else
    set(hObject,'Backgroundcolor','w');
    handles.sediment_file_index(2) = 1;
end
if(isequal(handles.sediment_file_index,ones(1,2)))
    set(handles.sediment_file_button,'Enable','on');
else
    set(handles.sediment_file_button,'Enable','off');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ST_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ST_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MorUpd_select.
function MorUpd_select_Callback(hObject, eventdata, handles)
% hObject    handle to MorUpd_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns MorUpd_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MorUpd_select
handles.MorUpd_id = get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function MorUpd_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MorUpd_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Bed_select.
function Bed_select_Callback(hObject, eventdata, handles)
% hObject    handle to Bed_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns Bed_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Bed_select
handles.Bed_id = get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Bed_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Bed_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Sus_input.
function Sus_input_Callback(hObject, eventdata, handles)
% hObject    handle to Sus_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns Sus_input contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Sus_input
handles.Sus_id = get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Sus_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sus_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in morphology_file_button.
function morphology_file_button_Callback(hObject, eventdata, handles)
% hObject    handle to morphology_file_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
morphology_file_id = fopen([handles.workpath,'\1.mor'],'wt');

line1 = '[MorphologyFileInformation]                                                                                                       ';
line2 = '   FileCreatedBy    = SandBed3D FLOW-GUI, Version: 3.41.06.10981                                                                    ';
line3 = '   FileCreationDate = Sun Apr 08 2018, 23:12:19                                                                                   ';
line4 = '   FileVersion      = 02.00                                                                                                       ';
line5 = '[Morphology]                                                                                                                      ';
line6 = '   EpsPar           = false                         Vertical mixing distribution according to van Rijn (overrules k-epsilon model)';
line7 = '   IopKCW           = 1                             Flag for determining Rc and Rw                                                ';
line8 = '   RDC              = 0.01                 [m]      Current related roughness height (only used if IopKCW <> 1)                   ';
line9 = '   RDW              = 0.02                 [m]      Wave related roughness height (only used if IopKCW <> 1)                      ';
line10 = ['   MorFac           =  ',num2str(handles.Morfac,'%10.7e'),'      [-]      Morphological scale factor                                                              '];
line11 = ['   MorStt           =  ',num2str(handles.Morstt,'%10.7e'),'      [min]    Spin-up interval from TStart till start of morphological changes                        '];
line12 = '   Thresh           =  5.0000001e-002      [m]      Threshold sediment thickness for transport and erosion reduction                        ';
if (isequal(handles.MorUpd_id,1))
    line13 = '   MorUpd           = true                          Update bathymetry during FLOW simulation                                                ';
else
    line13 = '   MorUpd           = false                          Update bathymetry during FLOW simulation                                                ';
end

line14 = '   EqmBc            = true                          Equilibrium sand concentration profile at inflow boundaries                             ';
line15 = '   DensIn           = false                         Include effect of sediment concentration on fluid density                               ';
line16 = '   AksFac           =  1.0000000e+000      [-]      van Rijn''s reference height = AKSFAC * KS                                               ';
line17 = '   RWave            =  2.0000000e+000      [-]      Wave related roughness = RWAVE * estimated ripple height. Van Rijn Recommends range 1-3 ';
line18 = '   AlfaBs           =  1.0000000e+000      [-]      Streamwise bed gradient factor for bed load transport                                   ';
line19 = '   AlfaBn           =  1.5000000e+000      [-]      Transverse bed gradient factor for bed load transport                                   ';
if (isequal(handles.Sus_id,1))
    line20 = '   Sus              =  1.0000000e+000      [-]      Multiplication factor for suspended sediment reference concentration                    ';
else
    line20 = '   Sus              =  0.0000000e+000      [-]      Multiplication factor for suspended sediment reference concentration                    ';
end
if (isequal(handles.Bed_id,1))
    line21 = '   Bed              =  1.0000000e+000      [-]      Multiplication factor for bed-load transport vector magnitude                           ';
else
    line21 = '   Bed              =  0.0000000e+000      [-]      Multiplication factor for bed-load transport vector magnitude                           ';    
end
line22 = '   SusW             =  1.0000000e+000      [-]      Wave-related suspended sed. transport factor                                            ';
line23 = '   BedW             =  1.0000000e+000      [-]      Wave-related bed-load sed. transport factor                                             ';
line24 = '   SedThr           =  1.0000000e-001      [m]      Minimum water depth for sediment computations                                           ';
line25 = '   ThetSD           =  0.0000000e+000      [-]      Factor for erosion of adjacent dry cells                                                ';
line26 = '   HMaxTH           =  1.5000000e+000      [m]      Max depth for variable THETSD. Set < SEDTHR to use global value only                    ';
line27 = '   FWFac            =  1.0000000e+000      [-]      Vertical mixing distribution according to van Rijn (overrules k-epsilon model)          ';
for i = 1:27
    fprintf(morphology_file_id,'%s\n',eval(['line',num2str(i)]));
end
if(isequal(fclose(morphology_file_id),0))
    msgbox('生成地貌文件成功！','提示','help')
else
    msgbox('生成地貌文件失败！','错误','error')
end

guidata(hObject, handles);

% --- Executes on button press in sediment_file_button.
function sediment_file_button_Callback(hObject, eventdata, handles)
% hObject    handle to sediment_file_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.ST <= 0 || handles.D50 <= 0 || handles.CDryB <= 0)
    msgbox('泥沙中值粒径、干床密度及床面厚度的值不能小于零','Error','error');
    return;
end
%% 各行内容
line1 = '[SedimentFileInformation]';
line2 = '   FileCreatedBy    = SandBed3D FLOW-GUI, Version: 3.41.06.10981         ';
line3 = '   FileCreationDate = Thu Mar 08 2018, 15:02:53         ';
line4 = '   FileVersion      = 02.00                        ';
line5 = '[SedimentOverall]';
line6 = '   Cref             =  1.6000000e+003      [kg/m3]  CSoil Reference density for hindered settling calculations';
line7 = '   IopSus           = 0                             If Iopsus = 1: susp. sediment size depends on local flow and wave conditions';
line8 = '[Sediment]';
line9 = '   Name             = #Sediment1#                   Name of sediment fraction';
line10 = '   SedTyp           = sand                          Must be "sand", "mud" or "bedload"';
line11 = ['   RhoSol           =  ',num2str(handles.rhos,'%10.7e'),'      [kg/m3]  Specific density'];
line12 = ['   SedDia           =  ',num2str(handles.D50,'%10.7e'),'      [m]      Median sediment diameter (D50)'];
line13 = ['   CDryB            =  ',num2str(handles.CDryB,'%10.7e'),'      [kg/m3]  Dry bed density'];
line14 = ['   IniSedThick      =  ',num2str(handles.ST,'%10.7e'),'      [m]      Initial sediment layer thickness at bed (uniform value or filename)'];
line15 = '   FacDSS           =  1.0000000e+000      [-]      FacDss * SedDia = Initial suspended sediment diameter. Range [0.6 - 1.0]';

sediment_file_id = fopen([handles.workpath,'\1.sed'],'wt');
for i = 1:15
    fprintf(sediment_file_id,'%s\n',eval(['line',num2str(i)]));
end
if(isequal(fclose(sediment_file_id),0))
    msgbox('生成泥沙文件成功！','提示','help')
else
    msgbox('生成泥沙文件失败！','错误','error')
end
handles.sediment_file_button_index = 1;
set(handles.Morstt_input,'string','0','Enable','on');
set(handles.Morfac_input,'string','1','Enable','on');
set(handles.MorUpd_select,'Value',1,'Enable','on');
set(handles.Bed_select,'Value',1,'Enable','on');
set(handles.Sus_input,'Value',1,'Enable','on');
set(handles.morphology_file_button,'Enable','on');
guidata(hObject, handles);


function Morstt_input_Callback(hObject, eventdata, handles)
% hObject    handle to Morstt_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Morstt_input as text
%        str2double(get(hObject,'String')) returns contents of Morstt_input as a double
handles.Morstt = str2double(get(hObject,'String'));
if(isnan(handles.Morstt)||handles.Morstt<0)
    msgbox('非法输入，地貌开始计算时间将被设置为默认值：0','Warning','warn');
    set(hObject,'String','0')
    handles.Morstt = 0;
    uicontrol(handles.Morstt_input);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Morstt_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Morstt_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close sediment_fig.
function sediment_fig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to sediment_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(hObject);
