function [ TD_func ] = TD_learning( T, R, discount )
    TD_func = [0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0];
    alpha = .001; %Change alpha here
    prob_rand = 1;
    for i = 1: 100000
        path = [];
        r = randi([1, 12]);
        curr_pos = r;
        path = [path curr_pos];
        term_found = 0;
        while ~term_found
            if curr_pos == 10
                final_value = 1;
                TD_func = learn_values(TD_func, final_value, path, alpha, discount, R);
                term_found = 1;
                continue
            end
            if curr_pos == 11
                final_value = -1;
                TD_func = learn_values(TD_func, final_value, path, alpha, discount, R);
                term_found = 1;
                continue
            end
            action = find_action(curr_pos, T, TD_func, prob_rand);
            curr_pos = take_action(curr_pos, action, T);
        end
    end
end

function [ new_pos ] = take_action( position, action, T )
    new_pos = 0;
    possible_pos = [0, 0, 0];
    probs = [0, 0, 0];
    j = 0;
    for k = 1:12
        if T(position, action, k) > 0
            j = j + 1;
            possible_pos(j) = k;
            probs(j) = T(position, action, k);
        end
    end
    random = rand();
    current_rand = 0;
    for i = 1:j
        current_rand = current_rand + probs(i);
        if random < current_rand
            new_pos = possible_pos(i);
            return;
        end
    end
end

function [ TD_func ] = learn_values( TD_func, final_value, path, alpha, discount, R )
    for i = 1:length(path)
        TD_func(path(i)) = TD_func(path(i)) + alpha*((R + discount*final_value) - TD_func(path(i)));
    end
end

function [action] = find_action(position, T, TD_func, prob_rand)
    if rand() < prob_rand
        action = randi([1, 4]);
        return;
    end
    
    action_value = [0, 0, 0, 0];
    for action = 1:4
        new_pos = [0, 0, 0];
        j = 0;
        for k = 1:12
            if T(position, action, k) ~= 0
                j = j + 1;
                new_pos(j) = k;
            end
        end
        for i = 1:j
            action_value(action) = action_value(action) + TD_func(new_pos(j));
        end
        
    end
    total_value = 0;
    max_value = -10;
    max_action = 0;
    for i = 1:4
        if action_value(i) > max_value
            max_value = action_value(i);
            max_action = i;
        end
        total_value = total_value + action_value(i);
    end
    if total_value == 0;
        max_action = randi([1 ,4]);
    end
    action = max_action;
end