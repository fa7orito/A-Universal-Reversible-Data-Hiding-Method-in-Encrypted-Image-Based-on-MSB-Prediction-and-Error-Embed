function random_matrix = get_encrypted_matrix(x,m,n)
%根据 x 获得m*n加密矩阵
u = 4;
for i = 1:1000
    x = u*x*(1-x);
end
A = zeros(1,m*n);
A(1) = x;
for i = 1:m*n-1
    A(i+1) = u*A(i)*(1-A(i));
end
B= uint8(255*A);
random_matrix = reshape(B,m,n);
end
