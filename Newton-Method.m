clc
clear all
syms x;
format long;
f=x.^4+(75/x);
g=diff(f);
h=diff(g);
epsilon=10^-6;
x0=1;
%input('Enter the function')
for i=1:100
f1=subs(g,x,x0);
f11=subs(h,x,x0);
y=x0-f1/f11;
err=abs(subs(g,x,y));
if err<epsilon
    break ;  
end
x0=y;
end
f_value=subs(f,x,y);
fprintf('The minimum value of f is at :%f\n',y);
fprintf('The minimum value of f is  :%f\n',f_value);
fprintf('No. of iterations:%d\n',i);

