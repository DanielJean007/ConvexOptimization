
function [Delta_x, lambda] = NewStepDecrem(hess, grad)
    Delta_x = -inv(hess)*grad';
    Delta_x = Delta_x';

    lambda = grad*inv(hess)*grad';

end