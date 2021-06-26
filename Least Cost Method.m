clc 
clear all 
c=[14 82 99;56 35 31;48 21 71;27 81 63]
s=[7 ;14; 21; 6]; 
d=[13 19 16 0];
x=[c s;d] 
[m n]=size(x)
x1=zeros(m,n)
sumc=0
sumr=0 
for i=1:m-1 
sumc=sumc+x(i,n); 
end 
for j=1:n-1 
sumr=sumr+x(m,j); 
end 
if(sumc == sumr) 
for i=1:m 
for j=1:n 
x11=min(x(i,n),x(m,j)); 
x1(i,j)=x11; 
x(i,n)=x(i,n)-x11; 
x(m,j)=x(m,j)-x11; 
end 
end 
else 
disp('unbalanced transportation')
end 
xre=0; 
for i=1:m-1 
for j=1:n-1 
xre=xre+(x(i,j).*x1(i,j)); 
end 
end 
disp(['the transportation cost is ',num2str(xre)]); 
disp('19BCE7230');
