function [ policy_func ] = find_policy( T, R, discount, value_func )
    policy_func = [ 0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0];
    for i = 1:12
        policy_func(i) = find_max_action(T, R, discount, value_func, i);
    end
end

function [ max_action] = find_max_action(T, R, discount, value_func, position)
    max_action = 0;
    max_value = -10;
    for i = 1:4
        new_pos = [0, 0, 0];
        for k = 1:12
            if T(position, action, k) ~= 0
                new_pos(j) = k;
                j = j + 1;
            end
        end
        current_value = R;
        for k = 1:j
            current_value = current_value + discount*T(position, i, new_pos(k))*value_func(new_pos(k));
        end
        if current_value > max_value
            max_value = current_value;
            max_action = i;
        end
    end
end