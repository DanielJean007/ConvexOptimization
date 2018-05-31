function t = exactLS(fx, x, Dx)
    s = 0.01:0.01:0.99;
    
    ray = repmat(x,size(s'))+(s'*Dx);
    [~,idx] = min(fx(ray(:,1), ray(:,2)));
    t = s(idx);
end