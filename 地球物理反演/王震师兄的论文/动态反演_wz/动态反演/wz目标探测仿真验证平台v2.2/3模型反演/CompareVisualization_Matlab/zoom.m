function [a_star, val_star, valprime_star] = zoom(a_lo, a_hi, phi_lo, phi_hi, derphi_lo, phi, derphi, phi0, derphi0, c1, c2, extra_condition)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

maxiter = 100;
i = 0;
delta1 = 0.2;
delta2 = 0.1;
phi_rec = phi0;
a_rec = 0;

while true
    dalpha = a_hi - a_lo;
    if dalpha < 0 
        a = a_hi;
        b = a_lo;
    else
        a = a_lo;
        b = a_hi;
    end
    if(i>0)
        cchk = delta1*dalpha;
        a_j = cubicmin(a_lo,phi_lo,derphi_lo,a_hi,phi_hi,a_rec,phi_rec);
    end
    if ((i==0) || isnan(a_j) || a_j>b-cchk || a_j<a+cchk)
        qchk = delta2*dalpha;
        a_j = quadmin(a_lo, phi_lo, derphi_lo, a_hi, phi_hi);
        if(isnan(a_j) || a_j > b-qchk || a_j < a+qchk)
            a_j = a_lo + 0.5*dalpha;
            %disp("a_j error !");
        end
    end
    phi_aj = phi(a_j);
    if(phi_aj > phi0 + c1*a_j*derphi0) || phi_aj >= phi_lo
        phi_rec = phi_hi;
        a_rec = a_hi;
        a_hi = a_j;
        phi_hi = phi_aj;
    else
        derphi_aj = derphi(a_j);
        if(abs(derphi_aj) <= -c2*derphi0 && extra_condition(a_j, phi_aj))
            a_star = a_j;
            val_star = phi_aj;
            valprime_star = derphi_aj;
            break;
        end
        if(derphi_aj*(a_hi-a_lo) >= 0)
            phi_rec = phi_hi;
            a_rec = a_hi;
            a_hi = a_lo;
            phi_hi = phi_lo;
        else
            phi_rec = phi_lo;
            a_rec = a_lo;
        end
        a_lo = a_j;
        phi_lo = phi_aj;
        derphi_lo = derphi_aj;
    end
    i=i+1;
    if(i > maxiter)
        disp("alpha error 2 !");
        a_star = nan;
        val_star = nan;
        valprime_star = nan;
        break;
    end
    
end

end

