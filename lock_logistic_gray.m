
function v=lock_logistic_gray(I,x0,u)
%input: the image I, x0, u
%output: the 7 LSB encrypted image v with MSB preserved (except I(1,1), which is encrypted all 8 bits)
[M,N]=size(I);
x=x0;
%����500�Σ��ﵽ��ֻ���״̬
for i=1:500
    x=u*x*(1-x);
end
%����һά�����������
A=zeros(1,M*N);
A(1)=x;
for i=1:M*N-1
A(i+1)=u*A(i)*(1-A(i));
end
%��һ������
B=uint8(255*A);
%ת��Ϊ��ά�����������
Fuck=reshape(B,M,N);
Rod=bitxor(I,Fuck);%����������
v=Rod;
% %���ֳ���һ�����ص�ÿ�����ص�MSB����
% for i=1:M
%     for j=1:N
%         if i~=1 || j~=1
%             v(i,j) = mod(v(i,j),128) + (I(i,j)/128)*128;
%         end
%     end
% end
end