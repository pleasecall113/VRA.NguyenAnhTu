function Example004()
%EXAMPLE004 Summary of this function goes here
%   Detailed explanation goes here
strMessage = '\n Nhap n: ';
n = input(strMessage);
s = 0;
for i =1:n
    s=s+i;
end
fprintf('\n Tong S = 1 + 2 + ... + %d la %d.\n',n,s);
end

