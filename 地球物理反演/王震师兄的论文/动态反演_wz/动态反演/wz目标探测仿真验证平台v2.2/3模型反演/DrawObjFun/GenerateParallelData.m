clc;
clear;
close all;

load group1.mat
fun = @(x)ObjectFun3(detector,x,m_pk,m_data);

x = -2:1:2;
y = -2:1:2;
z = -4.5:0.4:-0.5;
m1 = 0:0.01:0.05;
m2 = 0:0.01:0.05;
m3 = 0:0.01:0.05;
m4 = 0:0.01:0.05;
m5 = 0:0.01:0.05;
m6 = 0:0.01:0.05;

n = length(x)*length(y)*length(z)*length(m1)*length(m2)*length(m3)*length(m4)*length(m5)*length(m6);
data = zeros(n,10);

i = 1;
for i1 = x
    for i2 = y
        for i3 = z
            for i4 = m1
                for i5 = m2
                    for i6 = m3
                        for i7 = m4
                            for i8 = m5
                                for i9 = m6
                                    alpha = [i1 i2 i3 i4 i5 i6 i7 i8 i9];
                                    fval = fun(alpha);
                                    data(i,:) = [alpha fval];
                                    i = i+1;
                                    disp(i);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end