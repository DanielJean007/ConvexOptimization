function GradDescFixed_t(fx)
    clc;
    syms x1 x2;
    if nargin == 0
        fx = @(x1, x2) exp(x1+3*x2-0.1)+exp(x1-3*x2-0.1);
    end
    
    if nargin > 1
        exit;
    end
    
    x0 = randn(1, 2);
    
%% - COMPUTE FIRST DERIVATIVE
    grad = [diff(fx,x1) diff(fx,x2)];
        
%% - Gradient Descent Fixed t
    tol = 0.1;
    maxiter = 100000;    
    t = 0.0002;
    g = inf;
    niter = 0;
    x = x0;
    steps = [];

    % gradient descent algorithm:
    while(norm(g) >= tol & niter <= maxiter)
        g = -vpa(subs(grad,[x1,x2],x));
        steps = [steps;x];
        x = x + t*g;
        niter = niter + 1;
    end 
    
    xopt = x;
    a = char(xopt(1,1));
    b = char(xopt(1,2));
    a = a(1:7); b = b(1:7);
    niter = niter - 1;
%% - Plotting graph
    hold on;
    lowVal = -(2+str2num(char(round(max(abs(xopt)))))); highVal = 2+str2num(char(round(max(abs(xopt)))));
    [hor,ver] = meshgrid(lowVal:.15:highVal);
    surface = fx(hor,ver);
    fig = surfc(hor,ver,surface);
    plot3(steps(:,1),steps(:,2),fx(steps(:,1),steps(:,2)),'r*-');
    initial = plot3(x0(:,1),x0(:,2), vpa(subs(fx,[x1,x2],x0)),'o','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor',[.2 1 .5], 'DisplayName',['$x_0$ = [' num2str(x0) ']']);
    optimum = plot3(xopt(:,1),xopt(:,2), vpa(subs(fx,[x1,x2],xopt)),'o','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor',[.5 .9 1], 'DisplayName',['$\hat{x}$ = [' a ' ' b ']']);
    colorbar;
    set(gca,'FontSize',50, 'Box', 'on', 'linewidth', 1.5);
    lgd = legend([initial, optimum],'Location','northeast');
    lgd.Interpreter = 'latex';
end