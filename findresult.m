%%%%%%�鿴���%%%%%%
function findresult()
global maxgen yuzhi m n C B A result bestyuzhi
%resultΪ�����ֵ
result=floor(bestyuzhi(1,maxgen)) 
C=B;
[m,n]=size(C);
%�����ҵ�����ֵ�ָ�ͼ��
for i=1:m
    for j=1:n
        if C(i,j)<=result
            C(i,j)=0;
        else
            C(i,j)=255;
        end
    end
end


