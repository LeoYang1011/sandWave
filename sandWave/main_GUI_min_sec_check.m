function output = main_GUI_min_sec_check(out_name,hObject,handles)

if (contains(out_name,'min'))
    index = '��';
else
    index = '��';
end

min_sec = 0;
eval(['min_sec','=','handles.',out_name,';']);
eval(['min_sec_input','=', 'handles.',out_name,'_input',';']);

if(isnan(min_sec))
    eval(['handles.',out_name,'=','0',';']);
    if(~isempty(get(hObject,'String')))
        uiwait(msgbox(['��������ַ��Ƿ������������֣������Ա���������ֵ��������ΪĬ��ֵ��00',index],'����','warn'));
        uicontrol(min_sec_input);
    end
    set(hObject,'String','00')
elseif(min_sec < 0|| min_sec >= 60)
    set(hObject,'String','00')
    eval(['handles.',out_name,'=','0',';'])
    uiwait(msgbox(['�������',index,'����Ӧ������ڵ���0��С��60�������Ա���������ֵ��������ΪĬ��ֵ��00',index],'����','warn'));
    uicontrol(min_sec_input);
end
output = handles;
end

