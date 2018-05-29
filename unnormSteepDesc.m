function Delta_x = unnormSteepDesc(x, fx, g)
    [~,i] = max(abs(g));
    Delta_x = zeros(size(x));
    Delta_x(i) = -g(i);
end