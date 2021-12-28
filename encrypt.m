function encrypted_img = encrypt(I,x)
[m,n] = size(I);
random_matrix = get_encrypted_matrix(x,m,n);
encrypted_img = bitxor(I,random_matrix);
end