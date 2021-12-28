
function v=lock_logistic_gray(I,x0,u)
%input: the image I, x0, u
%output: the 7 LSB encrypted image v with MSB preserved (except I(1,1), which is encrypted all 8 bits)
[M,N]=size(I);
x=x0;
%迭代500次，达到充分混沌状态
for i=1:500
    x=u*x*(1-x);
end
%产生一维混沌加密序列
A=zeros(1,M*N);
A(1)=x;
for i=1:M*N-1
A(i+1)=u*A(i)*(1-A(i));
end
%归一化序列
B=uint8(255*A);
%转化为二维混沌加密序列
Fuck=reshape(B,M,N);
Rod=bitxor(I,Fuck);%异或操作加密
v=Rod;
% %保持除第一个像素的每个像素的MSB不变
% for i=1:M
%     for j=1:N
%         if i~=1 || j~=1
%             v(i,j) = mod(v(i,j),128) + (I(i,j)/128)*128;
%         end
%     end
% end
end