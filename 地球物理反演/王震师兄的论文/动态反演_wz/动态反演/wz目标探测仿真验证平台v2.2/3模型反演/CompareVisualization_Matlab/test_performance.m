clc;
clear;
close all;

%parpool('local',4);

%���庯�������൱�ڽ�����ָ�븳ֵ��f��Rosenbrock���ڱ���ļ���д�õĺ���
f = @Rosenbrock;
%�ݶ�
grad = @JacobianRosen;
%��ɭ����
hessian = @HessianRosen;

data = [];
sd = [];
newton = [];
bfgs = [];
cg = [];

for i = -50:2:50
    for j = -50:2:50
        data = [data; i,j];
        t = 0;
        n = 0;
        for k = 1:5
            t1 = clock;
            %[~, ~, ~, nn, fval] = QuasiNewtonBFGS(f, grad, [i,j], 1000, 1e-4);
            %[~, ~, ~, nn, fval] = ConjugateGradient(f, grad, [i,j], 1000, 1e-4);
            [~, ~, ~, nn, fval] = SteepestDescent(f, grad, [i,j], 10000, 1e-4);
            %[~, ~, ~, nn, fval] = Newton(f, grad, hessian, [i,j], 1000, 1e-4);
            %[~, ~, ~, nn, fval] = GradientDescent(f, grad, 0.002, [i,j], 100000, 1e-4);
            t2 = clock;
            t = t + etime(t2,t1);
            if nn == 10000
                nn = nan;
            end
            n = n + nn;
        end
        t = t/5;
        n = n/5;
        cg = [cg; n,t,fval];
    end
end
data = [data cg];
        