function isSingular = is_singular2(vecs)
[n, m] = size(vecs);
isSingular = false;

combs = nchoosek(1:m, n);
det_abs = inf;
for i = 1:size(combs, 1)
    selected_vectors = vecs(:, combs(i, :));
    det_val = det(selected_vectors);

    det_abs = min(det_abs, abs(det(selected_vectors)));

    if det_abs < 1e-10
        isSingular = true;
        break;
    end
end
disp(det_abs);
end

