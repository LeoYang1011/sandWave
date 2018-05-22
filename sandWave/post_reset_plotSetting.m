function output = post_reset_plotSetting(handles)
if(isequal(handles.data_id,1))
    set(handles.parameter_select,'Enable','off','Value',1,'string',handles.parameter_all_ch);
else
    set(handles.parameter_select,'Enable','on','Value',1,'string',handles.parameter_all_ch);
end
set(handles.stepmin_input,'Enable','off','string','');
set(handles.stepmax_input,'Enable','off','string','');
set(handles.xmin_input,'Enable','off','string','');
set(handles.xmax_input,'Enable','off','string','');
set(handles.ymin_input,'Enable','off','string','');
set(handles.ymax_input,'Enable','off','string','');
set(handles.zmin_input,'Enable','off','string','');
set(handles.zmax_input,'Enable','off','string','');
set(handles.x_scale_switch,'Enable','off','Value',0);
set(handles.x_scale_input,'Enable','off','string','');
set(handles.y_scale_switch,'Enable','off','Value',0);
set(handles.y_scale_input,'Enable','off','string','');
set(handles.z_scale_switch,'Enable','off','Value',0);
set(handles.z_scale_input,'Enable','off','string','');
set(handles.gene_fig_button,'Enable','off');
set(handles.new_time_set_input,'Enable','off','string','');
set(handles.change_time_slider,'Enable','off');
axes(handles.plot_axes);cla;
set(gca,'XColor',[1 1 1])
set(gca,'YColor',[1 1 1])
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])
colorbar off;
delete(get(gca,'title'))
delete(get(gca,'xlabel'))
delete(get(gca,'ylabel'))
output = handles;

end

