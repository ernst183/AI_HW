function [ value_func ] = value_iter( T, R, discount )
    threshold = .000001;
    value_func = [0, 0, 0, 1; 0, 0, 0, -1; 0, 0, 0, 0];
    old_value_func = [0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0];
    new_values = [0, 0, 0, 0];
    while check_threshold(threshold, value_func, old_value_func)
        old_value_func = value_func;
        for j = 1:12
            for a = 1:4
                new_values(a) = individual_value(value_func, T, R, discount, j, a);
            end
            max_value = -1;
            for k = 1:4
                if new_values(k) > max_value
                    max_value = new_values(k);
                end
            end
            value_func(j) = max_value;
        end
    end
end

function [ value ] = individual_value( value_func, T, R, discount, position, a )
    if value_func(position) == 1
        value = 1;
        return;
    end
    if  value_func(position) == -1
        value = -1;
        return;
    end
    new_pos = take_action(position, a, T);
    value = R;
    for i = 1:3
        if new_pos(i) ~= 0
            value = value + discount * (T(position, a, new_pos(i)) * value_func(new_pos(i)));
        end
    end
end

function [ new_pos ] = take_action( position, action, T )
    new_pos = [0, 0, 0];
    j = 1;
    for k = 1:12
        if T(position, action, k) ~= 0
            new_pos(j) = k;
            j = j + 1;
        end
    end
end

function [ not_changed ] = check_threshold( threshold, new_value_func, old_value_func )
    not_changed = 0;
    for i = 1:12
        if new_value_func(i) - old_value_func(i) >= threshold
            not_changed = 1;
            return;
        end
    end
            
end
