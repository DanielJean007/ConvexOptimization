function t = backTrackLS(fx, x, Dx, g)
    syms x1 x2;
    
    t=1;
    alpha = 0.1; 
    beta = 0.6;
    
    while (vpa(subs(fx,[x1,x2],x + t*Dx)) > (vpa(subs(fx,[x1,x2],x)) + alpha*t*g*Dx'))
        t = beta*t;
    end
end