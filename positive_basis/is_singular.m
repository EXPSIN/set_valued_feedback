function isSingular = is_singular(A_L)
[n_l, n_x2] = size(A_L);
isSingular = false;

% combs = nchoosek(1:n_l, n_x2);
det_abs = inf;
next_comb = lexicographic_combinations(n_l, n_x2);

while true
    comb = next_comb();
    
    if isempty(comb)
        break;
    end

    selected_vectors = A_L(comb, :);
    

    det_abs = min(det_abs, abs(det(selected_vectors)));

    if det_abs < 1e-10
        isSingular = true;
        break;
    end
end

disp(det_abs);
end


function comb_gen = lexicographic_combinations(n, k)
    % n: Total number of elements
    % k: Number of elements in each combination
    % Returns a function handle that generates the next combination in lexicographic order

    % Initialize the first combination
    comb = 1:k;  % First combination
    
    function next_comb = get_next_comb()
        % Returns the next combination in lexicographic order
        next_comb = comb;
        
        % Find the rightmost element that can be incremented
        idx = k;
        while idx > 0 && comb(idx) == (n - k + idx)
            idx = idx - 1;
        end
        
        % If idx becomes 0, we've reached the last combination
        if idx == 0
            next_comb = [];  % No more combinations
        else
            comb(idx) = comb(idx) + 1;
            for j = idx + 1:k
                comb(j) = comb(j - 1) + 1;
            end
        end
    end
    
    % Output the function handle that will generate combinations
    comb_gen = @get_next_comb;
end
