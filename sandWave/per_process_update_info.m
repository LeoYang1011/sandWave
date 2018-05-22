function output = per_process_update_info(old_value,new_value,target_info)
    if (target_info == 0 && ~isequal(old_value,new_value))
        output = 1;
    else
        output = target_info;
    end
end

