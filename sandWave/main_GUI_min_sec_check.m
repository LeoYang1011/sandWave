function output = main_GUI_min_sec_check(out_name,hObject,handles)

if (contains(out_name,'min'))
    index = '分';
else
    index = '秒';
end

min_sec = 0;
eval(['min_sec','=','handles.',out_name,';']);
eval(['min_sec_input','=', 'handles.',out_name,'_input',';']);

if(isnan(min_sec))
    eval(['handles.',out_name,'=','0',';']);
    if(~isempty(get(hObject,'String')))
        uiwait(msgbox(['所输入的字符非法，请输入数字！若忽略本警告则其值将被设置为默认值：00',index],'警告','warn'));
        uicontrol(min_sec_input);
    end
    set(hObject,'String','00')
elseif(min_sec < 0|| min_sec >= 60)
    set(hObject,'String','00')
    eval(['handles.',out_name,'=','0',';'])
    uiwait(msgbox(['开计算的',index,'钟数应满足大于等于0且小于60，若忽略本警告则其值将被设置为默认值：00',index],'警告','warn'));
    uicontrol(min_sec_input);
end
output = handles;
end

