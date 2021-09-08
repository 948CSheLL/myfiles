function [stp, fval, old_fval] = StepLength3(f, fprime, xk, pk, gfk, old_fval, old_old_fval, c1, c2, amax, amin, xtol)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

    function ret = phi(alpha)
        ret = f(xk + alpha * pk);
    end
    function ret = derphi(alpha)
        ret = fprime(xk + alpha * pk) * pk';
    end

    derphi0 = gfk * pk';
    phi0 = old_fval;
    old_phi0 = old_old_fval;
    
    if derphi0 ~= 0
        alpha1 = min(1.0, 1.01*2*(phi0 - old_phi0)/derphi0);
        if alpha1 < 0
            alpha1 = 1;
        end
    else
        alpha1 = 1;
    end
    
    phi1 = phi0;
    derphi1 = derphi0;
    isave = zeros(1,2);
    dsave = zeros(1,13);
    task = 'START';
    
    maxiter = 100;
    n = 0;
    for i = 1:maxiter
        n = n + 1;
        [stp, task, isave, dsave] = dcsrch(alpha1, phi1, derphi1, c1, c2, xtol, task, amin, amax, isave, dsave);
        if contains(task,'FG')
            alpha1 = stp;
            phi1 = phi(stp);
            derphi1 = derphi(stp);
        else
            break;
        end
    end
    if n == maxiter
        stp = nan;
    end
    if contains(task,'ERROR') || contains(task,'WARN')
        stp = nan;
    end
    fval = phi1;
    old_fval = phi0;
end

