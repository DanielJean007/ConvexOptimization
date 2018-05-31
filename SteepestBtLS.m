function param = SteepestBtLS(fx)
    clc;
    syms x1 x2;
    if nargin == 0
        fx = @(x1, x2) exp(x1+3*x2-0.1)+exp(x1-3*x2-0.1);
    end
    
    if nargin > 1
        exit;
    end
    
    x0 = rand(1, 2);
    
%% - COMPUTE FIRST AND SECOND DERIVATIVES 
    grad = [diff(fx,x1) diff(fx,x2)];
    hess = [diff(grad(1,1),x1) diff(grad(1,1),x2); diff(grad(1,2),x1) diff(grad(1,2),x2)];
        
%% - Testing area
    % To obtain values for gradiente: g = vpa(subs(grad,[x1,x2],[1,2]));
    % To obtain values for hessian:   h = vpa(subs(hess,[x1,x2],[1,2]));
    % To obtain t by exact line search: t = exactLS(fx, x0, -vpa(subs(grad,[x1,x2],x0));
    % To obtain t by backtracking: t = backTrackLS(fx, x0, -vpa(subs(grad,[x1,x2],x0)), vpa(subs(grad,[x1,x2],x0)));
    
%% - Steepest descent Exact Line Search
    tol = 1e-3;
    maxiter = 100000;    
    g = inf;
    niter = 0;
    x = x0;
    steps = [];

    % gradient descent algorithm:
    while(norm(g) >= tol & niter <= maxiter)
        g = vpa(subs(grad,[x1,x2],x));
        Delta_x = unnormSteepDesc(x, fx, g);
        t = backTrackLS(fx, x, Delta_x, g);
        steps = [steps;x];
        x = x + t*Delta_x;
        niter = niter + 1;
%         norm(g)
    end 
    
    xopt = x;
    niter = niter - 1;
    
%% - Plotting graph
    hold on;
    grid on;
    lowVal = -(2+(round(max(abs(xopt))))); highVal = 2+(round(max(abs(xopt))));
    [hor,ver] = meshgrid(lowVal:.15:highVal);
    surface = fx(hor,ver);
    fig = surfc(hor,ver,surface);
    plot3(steps(:,1),steps(:,2),fx(steps(:,1),steps(:,2)),'r*-');
    initial = plot3(x0(:,1),x0(:,2), vpa(subs(fx,[x1,x2],x0)),'o','MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor',[.2 1 .5], 'DisplayName',['$x_0$ = [' num2str(x0) ']']);
    optimum = plot3(xopt(:,1),xopt(:,2), vpa(subs(fx,[x1,x2],xopt)),'o','MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor',[.5 .9 1], 'DisplayName',['$\hat{x}$ = [' num2str(xopt) ']']);
    colorbar;
    set(gca,'FontSize',30, 'Box', 'on', 'linewidth', 1.5);
    lgd = legend([initial, optimum],'Location','northwest');
    lgd.Interpreter = 'latex';
    
%% - Update return structure
    param.fx = fx;
    param.grad = grad;
    param.hess = hess;
    param.x0 = x0;
    param.tol = tol;
    param.niter = niter;
    param.steps = steps;
    param.xopt = xopt;
    param.surface = surface;
end