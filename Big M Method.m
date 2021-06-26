clc
clear all
variables ={'x_1','x_2','s_1','s_2','A_1','s_3','sol'}; m=1000;
cost=[40 60 0 0 -m 0 0];
A= [2 1 1 0 0 0 70; 1 1 0 1 0 0 40; 1 3 0 0 0 1 90]

s=eye(size(A,1));
BV=[];
for j=1:size(s,2)
for i=1:size(A,2)
    if A(:,i)==s(:,j)
BV = [BV i]; 
    end
end 
end
B =A(:,BV);
A = inv(B)*A;
ZjCj = cost(BV)*A-cost;
ZCj = [ZjCj;A];



SimpTable=array2table(ZCj);
SimpTable.Properties.VariableNames(1:size(ZCj,2)) =variables;
 SimpTable 
 RUN=true;
while RUN
ZC =ZjCj(:,1:end);
if any(ZC<0);
fprintf('The current BFS is not optimal solution\n');
[Entval,pvt_col] = min(ZC);
fprintf('Entering column = %d \n',pvt_col);
sol = A(:,end);
column=A(:,pvt_col); 
if all(column)==0
fprintf('solution is UNBOUNDED') 
else
for i=1:size(column,1)
if column(i)>0
ratio(i)=sol(i)./column(i);
else
ratio(i)=inf;
end
end
[minR,pvt_row]=min(ratio);
fprintf('Leaving row = %d \n',pvt_row);
BV(pvt_row)=pvt_col;
B = A(:,BV);
A=inv(B)*A;
ZjCj =cost(BV)*A-cost;
ZCj =[ZjCj;A];
TABLE=array2table(ZCj);
TABLE.Properties.VariableNames(1:size(ZCj,2))=variables
end
else
    RUN = false;
fprintf('----Current BFS is optimal-----\n'); 

FINAL_BFS = zeros(1,size(A,2));
FINAL_BFS(BV) = A(:,end);
FINAL_BFS(end) = sum(FINAL_BFS.*cost);
OptimalBFS=array2table(FINAL_BFS);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2)) =variables
OptimalBFS
end
end