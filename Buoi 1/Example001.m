function Example001()
%EXAMPLE001 Summary of this function goes here
%   Detailed explanation goes here
%Random tu 0 den 1
a = rand();
fprintf('\n a = %8.3f',a);

%Random so nguyen tu 1 den 10
r = randi([1 10]);
fprintf('\n Random tu 1 den 10: %d',r);

%Random ma tran 1x10 trong [-10,10]
matran = randi([-10,10],1,10);
fprintf('\n Size ma tran: %d',size(matran,2));
fprintf('\n Ma tran duoc tao: ');
fprintf('[%2d]',matran);
end

