clc
clear all
variables ={'x_1','x_2','s_1','s_2','s_3','s_4','sol'}
Cost=[-3 -2 0 0 0 0 0]
Info=[-1 -1;1 1;-1 -2;0 1]
b=[-1;7;-10;3]
s=eye(size(Info,1))
A=[Info s b]
BV=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            BV=[BV i]
            
        end
    end
    
end
fprintf('Basic variables(BV)=');
disp(variables(BV))

zjcj=Cost(BV)*A-Cost

zcj=[zjcj;A]

SimpleTable=array2table(zcj)

SimpleTable.Properties.VariableNames(1:size(zcj,2))=variables
RUN=true
while RUN
    SOL=A(:,end)
    if any(SOL<0)
% fprintf('The current basic solution is not feasible \n');
        
        
[LeaVal,pvt_row]=min(SOL);
%fprintf('Leaving row =%d \n ',pvt_row)
        
        ROW=A(pvt_row,1:end-1);
        ZJ=zjcj(:,1:end-1);
 for i=1:size(ROW,2)
     if ROW(i)<0
         ratio(i)=abs(ZJ(i)./ROW(i));
     else
         ratio(i)=inf;
     end
 end
  [MinVAL,pvt_col]=min(ratio)
  % fprintf('Entering variable=%d \n', pvt_col);
   BV(pvt_row)=pvt_col;
   fprintf=('Basic variable(BV)=');
   disp(variables(BV));
   
   pvt_key=A(pvt_row,pvt_col)
   A(pvt_row,:)=A(pvt_row,:)./pvt_key;
   
   for i=1:size(A,1)
       if i~=pvt_row
           A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
       end
   end
   zcj=[zjcj;A];
   SimpleTable=array2table(zcj);
   SimpleTable.Properties.VariableNames(1:size(zcj,2))=variables
    else
        RUN =false;
       % fprintf('The current basic variable solution is optimal and feasible \n');
        
    end
end

FINAL_BFS=zeros(1,size(A,2));
FINAL_BFS(BV)=A(:,end);
OptimalBFS=array2table(FINAL_BFS)
Optimes(1:OptimalBFS.Properties.VariableNames(OptimalBFS,2))=variables
