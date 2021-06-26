clc
clear all
Cost= [14 56 48 27;82 35 21 81 ; 99 31 71 63 ]; 
A=[13 19 16]; 
B=[7 14 21 6]; 
if sum(A)==sum(B) 
fprintf(' Given TPP is balanced\n')
else
    fprintf(' Given TPP is Unbalanced\n')
if sum(A)<sum(B) 
Cost(end+1,:)=zeros(1,size(A,2))
A(end+1)=sum(B)-sum(A)
elseif sum(B)<sum(A) 
Cost(:,end+1)=zeros(1,size(A,2))
B(end+1)=sum(A)-sum(B)
end 
end 
X=zeros(size(Cost)); 
[m,n]=size(Cost)
for i=1:m
    for j=1:n
        x11=min(A(i) ,B(j))
        X(i,j)=x11
        A(i) =A(i)-x11
        B(j) = B(j)-x11
    end
end

fprintf('Initial BFS =\n')
IB=array2table(X); 
disp(IB); 
TotalBFS=length(nonzeros(X))

 
InitialCost=sum(sum(Cost.*X))
 fprintf('Intial BFS Cost=%d\n',InitialCost) 
 fprintf('Registration number=19BCE7230') 
