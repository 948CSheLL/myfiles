clc;
clear;
close all;

%建议阅读顺序：main-Rosenbrock-JacobianRosen-HessianRosen-GradientDescent-
%SteepestDescent-StepLength-Newton-QuasiNewtonGFGS-ConjugateGradient.

%定义函数，这相当于将函数指针赋值给f，Rosenbrock是在别的文件中写好的函数
f = @Rosenbrock;
%梯度
grad = @JacobianRosen;
%海森矩阵
hessian = @HessianRosen;

%loadlibrary('fortran.dll','fortran_c.h');

%分别测试最优化方法，tic toc用于计算运行时间
% tic;
% [xlog, ylog, xdlog, n] = GradientDescent(f, grad, 0.00008, [-10 2], 10000, 1e-4);
% toc
% %画图
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