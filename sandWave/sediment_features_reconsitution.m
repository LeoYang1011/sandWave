function output = sediment_features_reconsitution(handles)
global  sediment_features_handles_old;
%% 泥沙
handles.rhos = sediment_features_handles_old.rhos;
handles.ST = sediment_features_handles_old.ST;
handles.D50 = sediment_features_handles_old.D50;
handles.CDryB = sediment_features_handles_old.CDryB;
handles.sediment_file_index = sediment_features_handles_old.sediment_file_index;
handles.sediment_file_button_index = sediment_features_handles_old.sediment_file_button_index;
%设置界面
if(~isequal(handles.rhos,2650))
    set(handles.rhos_input,'string',num2str(handles.rhos));
end
if(isequal(handles.ST,0))
    set(handles.ST_input,'string','');
else
    set(handles.ST_input,'string',num2str(handles.ST));
end
if(isequal(handles.D50,0))
    set(handles.D50_input,'string','');
else
    set(handles.D50_input,'string',num2str(handles.D50));
end
if(isequal(handles.CDryB,0))
    set(handles.CDryB_input,'string','');
else
    set(handles.CDryB_input,'string',num2str(handles.CDryB));
end
if(isequal(handles.sediment_file_index,ones(1,3)))
    set(handles.sediment_file_button,'Enable','on');
else
    set(handles.sediment_file_button,'Enable','off');
end

%% 地貌
handles.Morstt = sediment_features_handles_old.Morstt;
handles.Morfac = sediment_features_handles_old.Morfac;
handles.Sus_id = sediment_features_handles_old.Sus_id;
handles.Bed_id = sediment_features_handles_old.Bed_id;
handles.MorUpd_id = sediment_features_handles_old.MorUpd_id;
if(isequal(handles.sediment_file_button_index ,1))
    set(handles.Morstt_input,'string',num2str(handles.Morstt),'Enable','on');
    set(handles.Morfac_input,'string',num2str(handles.Morfac),'Enable','on');
    set(handles.MorUpd_select,'Value',handles.MorUpd_id,'Enable','on');
    set(handles.Bed_select,'Value',handles.Bed_id,'Enable','on');
    set(handles.Sus_input,'Value',handles.Sus_id,'Enable','on');
    set(handles.morphology_file_button,'Enable','on');
else
    set(handles.Morstt_input,'string','','Enable','off');
    set(handles.Morfac_input,'string','','Enable','off');
    set(handles.MorUpd_select,'Value',1,'Enable','off');
    set(handles.Bed_select,'Value',1,'Enable','off');
    set(handles.Sus_input,'Value',1,'Enable','off');
    set(handles.morphology_file_button,'Enable','off');
end
%%
output = handles;
end

