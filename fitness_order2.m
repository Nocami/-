%%%%%%�����ʶ�ֵ%%%%%%
function fitness_order()
global lchrom oldpop fitness popsize chrom fit gen C m n  fitness1 yuzhisum cross_rate mutation_rate
global lowsum higsum u1 u2 yuzhi gen oldpop1 popsize1 b1 b yuzhi1 bestyuzhi bestfit

%�����ʶ�ֵ
for i=1:popsize
    lowsum=0;
    higsum=0;
    lownum=0;
    hignum=0;
    chrom=oldpop(i,:);
    c=0;
    for j=1:lchrom
        c=c+chrom(1,j)*(2^(lchrom-j));
    end
    %ת�����Ҷ�ֵ
b(1,i)=c*255/(2^lchrom-1);          
    for x=1:m
        for y=1:n
            if C(x,y)<=b(1,i)
            lowsum=lowsum+double(C(x,y)); %ͳ�Ƶ�����ֵ�ĻҶ�ֵ���ܺ�
            lownum=lownum+1; %ͳ�Ƶ�����ֵ�ĻҶ�ֵ�����ص��ܸ���
            else
            higsum=higsum+double(C(x,y)); %ͳ�Ƹ�����ֵ�ĻҶ�ֵ���ܺ�
            hignum=hignum+1; %ͳ�Ƹ�����ֵ�ĻҶ�ֵ�����ص��ܸ���
            end
        end
    end
    if lownum~=0
        %u1��u2Ϊ��Ӧ�������ƽ���Ҷ�ֵ
u1=lowsum/lownum; 
    else
        u1=0;
    end
    if hignum~=0
        u2=higsum/hignum;
    else
        u2=0;
    end   
    %�����ʶ�ֵ
fitness(1,i)=lownum*hignum*(u1-u2)^2; 
end

%�±�ͳ��ÿһ���е������ֵ�������Ӧ��ֵ
if gen==1
    fit(1,gen)=fitness(1,popsize);
    yuzhi(1,gen)=b(1,popsize);
else
    yuzhi(1,gen)=b(1,popsize); %ÿһ���е������ֵ
    fit(1,gen)=fitness(1,popsize); %ÿһ���е������Ӧ��
end
%�±߼�������˴�����ʷ�����ֵ
if gen==1
    bestfit(1,gen)=fitness(1,popsize);
    bestyuzhi(1,gen)=b(1,popsize);
else
    if fitness(1,popsize)>bestfit(1,gen-1)
        bestfit(1,gen)=fitness(1,popsize);
        bestyuzhi(1,gen)=b(1,popsize);
    else
        bestfit(1,gen)=bestfit(1,gen-1);
        bestyuzhi(1,gen)=bestyuzhi(1,gen-1);
    end
end
