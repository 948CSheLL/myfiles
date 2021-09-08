clc;
clear;
close all;

%�����Ķ�˳��main-Rosenbrock-JacobianRosen-HessianRosen-GradientDescent-
%SteepestDescent-StepLength-Newton-QuasiNewtonGFGS-ConjugateGradient.

%���庯�������൱�ڽ�����ָ�븳ֵ��f��Rosenbrock���ڱ���ļ���д�õĺ���
f = @Rosenbrock;
%�ݶ�
grad = @JacobianRosen;
%��ɭ����
hessian = @HessianRosen;

%loadlibrary('fortran.dll','fortran_c.h');

%�ֱ�������Ż�������tic toc���ڼ�������ʱ��
% tic;
% [xlog, ylog, xdlog, n] = GradientDescent(f, grad, 0.00008, [-10 2], 10000, 1e-4);
% toc
% %��ͼ
% DrawRosen(xlog, ylog, xdlog, n, 'GradientDescent');

tic
[xlog, ylog, xdlog, n] = SteepestDescent(f, grad, [-50,-42], 10000, 1e-4);
toc
DrawRosen(xlog, ylog, xdlog, n, 'SteepestDescent');

% tic
% [xlog, ylog, xdlog, n] = Newton(f, grad, hessian, [-100,30], 10000, 1e-4);
% toc
% DrawRosen(xlog, ylog, xdlog, n, 'Newton');

% tic
% [xlog, ylog, xdlog, n, fval] = QuasiNewtonBFGS(f, grad, [-36,-36], 1000, 1e-4);
% toc
% DrawRosen(xlog, ylog, xdlog, n, 'QuasiNewtonBFGS');

% tic;
% [xlog, ylog, xdlog, n] = ConjugateGradient(f, grad, [-50,-48], 1000, 1e-4);
% toc
% DrawRosen(xlog, ylog, xdlog, n, 'ConjugateGradient');

% vfun = @(x) [100*(x(2) - x(1)^2)^2,(1 - x(1))^2];
% options = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt');
% tic
% [x] = lsqnonlin(vfun,[2,3],[],[],options);
% toc
% x
%unloadlibrary fortran