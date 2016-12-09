%Zachary Job

%Cooool... x and y are not logically swapped
%		 as they maintain array structure :P

%Predefine everything for readability
x = [1  2  3  4  5  6  7  8  9  10 11 12]
y = [58 59 59 58 57 58 57 58 60 64 63 68]
dataLen      	= length(x);
%Thanks to that AWESOME loop option ELEM(i:j), no need
%for a 2d array as everything can be computed on the fly
%all that is needed is that we store what would have
%been (1,n) aka the multiplier
cArray			= y;
strResult		= '';

%Summary
	%Loop through each x index by y finding the result
	%print

%Calculate the rest of the c values
for i=2:dataLen
	cArray(1,i:dataLen) = (cArray(1,i:dataLen) - cArray(1,i - 1)) ...
						./ (x(i:dataLen) - x(i - 1));
end

%Print the results!
disp(['y = ( ...']);
disp([num2str(cArray(1)), ' ...']);
for i=2:dataLen
	strResult = strcat(strResult, ' .* (x - (', num2str(x(i - 1)), '))');
	disp(['+ ', num2str(cArray(1,i)), strResult, ' ...']);
end
disp([');']);