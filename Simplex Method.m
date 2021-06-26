clear all
clc
%%Input Format
Noofvariables = 3
C = [45 50 55]
Info = [2 2.5 3;1.5 2 1;1 0.75 1.25]
b = [4006;2495;1500]
s = eye(size(Info,1))
A = [Info s b]
Cost = zeros(1,size(A,2))
Cost(1:Noofvariables) = C
%%%% Constraint BV
BV = Noofvariables+1:1:size(A,2)-1
%%%% calculate Zj-Cj R0W
ZjCj = Cost(BV)*A - Cost
%%%% Printing Table
ZCj = [ZjCj ; A]
SimpTable = array2table(ZCj)
%%%% SIMPLEX METHOD Start
RUN = true;



while RUN

if any(ZjCj<0) % checking if any negative value

fprintf(' The Current BFs is Not Optimal \n')
fprintf('\n ======= THE NEXT ITERATION RESULTS======= \n')

disp('Old Basic Variable (BV) = ')
disp(BV)

%%Finding the Entering Variable
ZC = ZjCj(1:end-1)
[EnterCol, pvt_col] = min(ZC)
fprintf('The Minimum Element in Zj-Cj row is')
%d Corresponding to column %d \n', EnterCol,pvt_col)
fprintf('Entering Variable is %d \n ',pvt_col)

%% Finding the Leaving Variable
sol = A(:,end)
Column = A(:,pvt_col)
if all(Column<=0)
error('LPP is UnBounded. All Enteries <=0 in column %d',pvt_col)
else
sol = A(:,end)
Column = A(:,pvt_col)
for i=1:size(Column,1)
if Column(i)>0



ratio(i) = sol(i)./Column(i)
else
ratio(i) = inf
end
end
%%%% Finding The Minimum
[MinRatio, pvt_row] = min(ratio)
fprintf('Minimum Ratio Corresponding to Pivotis %d \n', pvt_row)
fprintf(' Leaving Variable is %d \n',BV(pvt_row))
end

BV(pvt_row)= pvt_col
disp('New Basic Variables (BV) =')
disp(BV);

%% Pivot Key
pvt_key = A(pvt_row,pvt_col)

%%% Update the table for next Iteration
A(pvt_row,:) = A(pvt_row,:)./pvt_key
for i=1:size(A,1)
if i~=pvt_row
A(1,:) = A(i,:)-A(i,pvt_col).*A(pvt_row,:)
end
end

ZjCj = ZjCj - ZjCj(pvt_col).*A(pvt_row,:)



%%% For Printing Purpose
ZCj = [ZjCj;A]
TABLE = array2table(ZCj)

%%%% Printing The Solution
BFS = zeros(1,size(A,2))
BFS(BV) = A(:,end)
BFS(end) = sum(BFS.*Cost)
Current_BFs = array2table(BFS)
else
RUN = false;
fprintf('====== ******* ======= \n')
fprintf(' The Current BFS is optimal \n')
fprintf('======= ******* ======= \n')
end
end