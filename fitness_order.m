%%%%%%�����ʶ�ֵ��������%%%%%%
function fitness_order()
global lchrom oldpop fitness popsize chrom fit gen C m n  fitness1 yuzhisum cross_rate mutation_rate
global lowsum higsum u1 u2 yuzhi gen oldpop1 popsize1 b1 b yuzhi1 maxgen bestfit bestyuzhi
if popsize>=5
    popsize=ceil(popsize-0.03*gen);
end
%��������ĩ�ڵ�ʱ�������Ⱥ��ģ�ͽ��桢�������
if gen==round(maxgen/2)  
cross_rate=0.8;            %�������
mutation_rate=0.3;         %�������
end
%������ǵ�һ������һ�����������Ⱥ���ݴ˴�����Ⱥ��ģװ��˴���Ⱥ��
if gen>1   %�ɴ�С����װ��oldpop
    t=oldpop;
    j=popsize1;
    for i=1:popsize
        if j>=1
            oldpop(i,:)=t(j,:);
        end
        j=j-1;
    end
end
%�����ʶ�ֵ������
for i=1:popsize
    lowsum=0;
    higsum=0;
    lownum=0;   
    hignum=0;
    chrom=oldpop(i,:);
    c=0;
    %ת��Ϊʮ����
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
%���Ϊ��һ������С��������
if gen==1 
    for i=1:popsize
        j=i+1;
        while j<=popsize
            if fitness(1,i)>fitness(1,j)
                tempf=fitness(1,i);
                tempc=oldpop(i,:);
                tempb=b(1,i);
                b(1,i)=b(1,j);
                b(1,j)=tempb;
                fitness(1,i)=fitness(1,j);
                oldpop(i,:)=oldpop(j,:);
                fitness(1,j)=tempf;
                oldpop(j,:)=tempc;
            end
            j=j+1;
        end
    end
    for i=1:popsize
        fitness1(1,i)=fitness(1,i);
        b1(1,i)=b(1,i);
        oldpop1(i,:)=oldpop(i,:);
    end
    popsize1=popsize;
%����һ��ʱ�������´�С��������
else 
    for i=1:popsize
        j=i+1;
        while j<=popsize
            if fitness(1,i)>fitness(1,j)
                tempf=fitness(1,i);
                tempc=oldpop(i,:);
                tempb=b(1,i);
                b(1,i)=b(1,j);
                b(1,j)=tempb;
                fitness(1,i)=fitness(1,j);
                oldpop(i,:)=oldpop(j,:);
                fitness(1,j)=tempf;
                oldpop(j,:)=tempc;
            end
            j=j+1;
        end
    end
end 
%����һ��Ⱥ���������
for i=1:popsize1
    j=i+1;
    while j<=popsize1
        if fitness1(1,i)>fitness1(1,j)
            tempf=fitness1(1,i);
            tempc=oldpop1(i,:);
            tempb=b1(1,i);
            b1(1,i)=b1(1,j);
            b1(1,j)=tempb;
            fitness1(1,i)=fitness1(1,j);
            oldpop1(i,:)=oldpop1(j,:);
            fitness1(1,j)=tempf;
            oldpop1(j,:)=tempc;
        end
        j=j+1;
    end
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
