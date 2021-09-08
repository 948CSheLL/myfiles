function [alpha,fval,old_fval] = StepLength2(f, grad, xk, pk, gk, old_fval, old_old_fval, c1, c2, amax, extra_condition, ex, maxiter)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

    gval = nan;
    gval_alpha = nan;
    
    function [val] = phi(alpha)
        val = f(xk + alpha * pk);
    end
    function [val] = derphi(alpha)
        gval = grad(xk + alpha * pk);
        gval_alpha = alpha;  %不懂
        val = gval * pk';
    end    

    function [n] = extra_condition2(alpha ,phi)
        if ~isnan(ex)
            if gval_alpha ~= alpha
                derphi(alpha)
            end
            x = xk + alpha * pk;
            n = extra_condition(alpha, x, phi, gval);
        else
            n = true;
        end
    end
    %derphi0 = gfk * pk';
    
    old_phi0 = old_old_fval;
    phi0 = phi(0);
    derphi0 = gk*pk';
    alpha0 = 0;
    if derphi0 ~= 0 
        alpha1 = min(1.0, 1.01*2*(phi0 - old_phi0)/derphi0);
    else
        alpha1 = 1.0;
    end
    old_fval = phi0;
    if alpha1 < 0
        alpha1 = 1.0;
    end
    alpha1 = min(alpha1, amax);  
    
    phi_a1 = phi(alpha1);
    phi_a0 = phi0;
    derphi_a0 = derphi0;
    
    for i = 1:maxiter
        %fprintf("i=%f, a0=%e, a1=%e \n",i,alpha0,alpha1);
        if (phi_a1 > phi0 + c1 * alpha1 * derphi0) || ((phi_a1 >= phi_a0) && (i>2))
            alpha = zoom(alpha0,alpha1,phi_a0,phi_a1,derphi_a0,@phi,@derphi,phi0,derphi0,c1,c2,@extra_condition2);
            fval = phi(alpha);
            return;
        end
        derphi_a1 = derphi(alpha1);
        if (abs(derphi_a1) <= -c2*derphi0)
            if extra_condition2(alpha1,alpha1)
                alpha = alpha1;
                fval = phi(alpha);
                return;
            end
        end
        if (derphi_a1 >= 0)
            alpha = zoom(alpha1,alpha0,phi_a1,phi_a0,derphi_a1,@phi,@derphi,phi0,derphi0,c1,c2,@extra_condition2);
            fval = phi(alpha);
            return;
        end
        alpha2 = 2 * alpha1;
        alpha2 = min(alpha2, amax);
        alpha0 = alpha1;
        alpha1 = alpha2;
        phi_a0 = phi_a1;
        phi_a1 = phi(alpha1);
        derphi_a0 = derphi_a1;
    end
    disp('alpha error 1 !');
    alpha = alpha1;
    %alpha = nan;
    
end



