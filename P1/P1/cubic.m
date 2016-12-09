%Zachary Job

%Cooool... x and y are not logically swapped
%		 as they maintain array structure :P

%Predefine everything for readability
x = [1  2  3  4  5  6  7  8  9  10 11 12]
y = [58 59 59 58 57 58 57 58 60 64 63 68]
dataLen								= length(x);
ls_aMatrix      					= zeros(dataLen, dataLen);
ls_bMatrix       					= zeros(dataLen, 1);
hArray								= zeros(dataLen - 1, 1);
%aArray = x(i)
bArray								= zeros(dataLen, 1);
cArray       						= zeros(dataLen);
dArray								= zeros(dataLen, 1);

ls_aMatrix(1,1)         			= 1;
ls_aMatrix(dataLen, dataLen) 		= 1;
ls_bMatrix(1,1)            			= 0;
ls_bMatrix(dataLen,1)        		= 0;

%Summary
	%calculate h's
	%calculate x of Ax = b
	%linsolve for c's
	%solve the unsolved constants
	%print

%Calculate h's
for i=1:dataLen - 1
	hArray(i) = x(i + 1) - x(i); 
end

%Calculate A and b's of Ax = b for linsolve where x is c
for i=2:dataLen - 1
	%A calculation - matrix y of i, x of i-1:i:i+1
	ls_aMatrix(i,i - 1) = hArray(i - 1);
	ls_aMatrix(i,i)     = 2 .* (hArray(i - 1) + hArray(i));
	ls_aMatrix(i,i + 1) = hArray(i);
	%B calculation - 1D matrix of b @ i
	ls_bMatrix(i) 		= ((3 ./ hArray(i)) .* (y(i + 1) - y(i))) ...
						- ((3 ./ hArray(i - 1)) .* (y(i) - y(i - 1)));
end

%Calculate c's
cArray = linsolve(ls_aMatrix,ls_bMatrix);

%Calculate b's and d's
for i=1:dataLen - 1
	bArray(i) 	= ((1 ./ hArray(i)) .* (y(i + 1) - y(i))) ...
				- ((hArray(i) ./ 3) .* (cArray(i + 1) + (2 .* cArray(i))));
	dArray(i) 	= ((1 ./ (3 .* hArray(i))) .* (cArray(i + 1) - cArray(i)));
end

%Print the values for graphing
for i=1:dataLen - 1
	disp(['y',num2str(i) ,' = (', ...
	num2str(y(i)), ' + ', ...
	num2str(bArray(i,1)), ' .* (x', num2str(i),' - (', num2str(x(i)), ')) + ', ...
	num2str(cArray(i,1)), ' .* (x', num2str(i),' - (', num2str(x(i)), ')).^2 + ', ...
	num2str(dArray(i,1)), ' .* (x', num2str(i),' - (', num2str(x(i)), ')).^3);']);
end