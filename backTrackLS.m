function t = backTrackLS(fx, x, Dx, g)
    syms x1 x2;
    
    t=1;
    alpha = 0.1; 
    beta = 0.7;
    
%     hx = (x + t*Dx);
    while (vpa(subs(fx,[x1,x2],x + t*Dx)) > (fx(x(:,1),x(:,2)) + alpha*t*g*Dx'))
        t = beta*t;
    end
end