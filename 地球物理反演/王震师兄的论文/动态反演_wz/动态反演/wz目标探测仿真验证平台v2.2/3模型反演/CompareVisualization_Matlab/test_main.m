
% a = zoom(@phi,@derphi,1,3,0.9);
% disp(a);
% 
% function f = phi(alpha)
%     f = (alpha-2)^2;
% end
% function f = derphi(alpha)
%     f = 2*(alpha-2);
% end

% for i=1:10
%     a = i;
%     function ret = func(val)
%         ret = a*val;
%         disp(ret);
%     func(a);
% end

% a = 10;
% func1();
% function func1()
%     a = 2;
%     function func2()
%         a = 1;
%     end
%     for i=1:5
%         a = a + 1;
%         func2()
%         disp(a);
%     end
% end

% func1();
% function func1()
%     a = 2;
%     function func2()
%         a = a + 1;
%     end
%     for i = 1:5
%         a = a + 1;
%         test_fun(@func2, a);
%         disp(a);
%     end
% end
% 
% function test_fun(f, a)
%     a = 1;
%     f();
% end

% func1(1);
% function func1(a)
%     function func2()
%         c = a + 1;
%         disp(c)
%     end
%     for i = 1:5
%         a = a + 1;
%         test_fun(@func2, a);
%     end
% end
 
% func2 = nan;
% %isnan(func2);
% function func2()
%     c =  1;
%     disp(c);
% end

% d = [0,0];
% d;e = c();
% disp(d);
% function [a,b] = c()
%     a = 1;
%     b = 2;
% end

