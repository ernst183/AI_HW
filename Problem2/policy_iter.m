function [ policy_func, value_func ] = policy_iter( T, R, discount )
    value_func = [0, 0, 0, 1; 0, 0, 0, -1; 0, 0, 0, 0]; 
    policy_func = [1, 1, 1, 1; 1, 1, 1, 1; 1, 1, 1, 1];
    no_change = 0;
    while ~no_change
        no_change = 1;
        for i = 1:12
            q_best = value_func(i);
            for a = 1:4
                q_sa = individual_value(value_func, T, R, discount, i, a);
                if q_sa > q_best
                    policy_func(i) = a;
                    value_func(i) = q_sa;
                    q_best = q_sa;
                    no_change = 0;
                end
            end
        end
    end
    value_func
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
    value = 0;
    for i = 1:3
        if new_pos(i) ~= 0
            value = value + T(position, a, new_pos(i)) * (R + discount * value_func(new_pos(i)));
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
