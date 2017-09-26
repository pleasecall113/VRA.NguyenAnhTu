function Example003()
%EXAMPLE001 Summary of this function goes here
%   Detailed explanation goes here
strMessage = '\n Nhap n: ';
n = input(strMessage);
s = 0;
i = 1;
while i<=n
    s = s+i;
    i = i+1;
end
fprintf('\n Tong S = 1+2+...+%d la %d.\n',n,s);
end

