function img1 = Fog1_RGB(imgb)
    %% ͼƬ��ȡ����ͨ����ȡ
    imgd=double(imgb);	%ת��Ϊ˫����
    [height,width,~]=size(imgd);	%��ȡ�ߴ�
    R=imgd(:,:,1);      %�ֱ���ȡ��ͨ��ֵ
    G=imgd(:,:,2); 
    B=imgd(:,:,3);
    
    %% ��Rͨ������ֱ��ͼ���⴦��
    %��һ����ͳ�Ƹ��Ҷȼ�������Ŀ����¼��PixelN����
    PixelN=zeros(1,256);
    for i=1:height
        for j=1:width
            PixelN((R(i,j)+1))=PixelN((R(i,j)+1))+1;
        end
    end
    %�ڶ�����������Ҷȼ��ֲ��ܶȲ���¼��PixelP����
    PixelP=zeros(1,256);
    for i=1:256
        PixelP(i)=PixelN(i)/(height*width);
    end
    %������������Ҷȼ��ۼƷֲ�����¼��PixelAccu����
    PixelAccu=zeros(1,256);
    for i=1:256
        if i==1
            PixelAccu(i)=PixelP(i);
        else
            PixelAccu(i)=PixelAccu(i-1)+PixelP(i);
        end
    end
    %���Ĳ������ۼƷֲ�ת��Ϊ0~255�ĻҶȼ�����¼��PixelDisc����
    PixelDisc=zeros(1,256);
    PixelDisc=uint8(255.*PixelAccu+0.5);
    %���岽������ԭ�Ҷ�ֵӳ��洢����ͼ����
    for i=1:height
        for j=1:width
            R2(i,j)=PixelDisc(R(i,j)+1);
        end
    end
    
    %% ��Gͨ������ֱ��ͼ���⴦��
    %��һ����ͳ�Ƹ��Ҷȼ�������Ŀ����¼��PixelN����
    PixelN=zeros(1,256);
    for i=1:height
        for j=1:width
            PixelN((G(i,j)+1))=PixelN((G(i,j)+1))+1;
        end
    end
    %�ڶ�����������Ҷȼ��ֲ��ܶȲ���¼��PixelP����
    PixelP=zeros(1,256);
    for i=1:256
        PixelP(i)=PixelN(i)/(height*width);
    end
    %������������Ҷȼ��ۼƷֲ�����¼��PixelAccu����
    PixelAccu=zeros(1,256);
    for i=1:256
        if i==1
            PixelAccu(i)=PixelP(i);
        else
            PixelAccu(i)=PixelAccu(i-1)+PixelP(i);
        end
    end
    %���Ĳ������ۼƷֲ�ת��Ϊ0~255�ĻҶȼ�����¼��PixelDisc����
    PixelDisc=zeros(1,256);
    PixelDisc=uint8(255.*PixelAccu+0.5);
    %���岽������ԭ�Ҷ�ֵӳ��洢����ͼ����
    for i=1:height
        for j=1:width
            G2(i,j)=PixelDisc(G(i,j)+1);
        end
    end
    
    %% ��Bͨ������ֱ��ͼ���⴦��
    %��һ����ͳ�Ƹ��Ҷȼ�������Ŀ����¼��PixelN����
    PixelN=zeros(1,256);
    for i=1:height
        for j=1:width
            PixelN((B(i,j)+1))=PixelN((B(i,j)+1))+1;
        end
    end
    %�ڶ�����������Ҷȼ��ֲ��ܶȲ���¼��PixelP����
    PixelP=zeros(1,256);
    for i=1:256
        PixelP(i)=PixelN(i)/(height*width);
    end
    %������������Ҷȼ��ۼƷֲ�����¼��PixelAccu����
    PixelAccu=zeros(1,256);
    for i=1:256
        if i==1
            PixelAccu(i)=PixelP(i);
        else
            PixelAccu(i)=PixelAccu(i-1)+PixelP(i);
        end
    end
    %���Ĳ������ۼƷֲ�ת��Ϊ0~255�ĻҶȼ�����¼��PixelDisc����
    PixelDisc=zeros(1,256);
    PixelDisc=uint8(255.*PixelAccu+0.5);
    %���岽������ԭ�Ҷ�ֵӳ��洢����ͼ����
    for i=1:height
        for j=1:width
            B2(i,j)=PixelDisc(B(i,j)+1);
        end
    end
    
    %% ͼ��RGB��ͨ������
    img1(:,:,1)=R2(:,:);
    img1(:,:,2)=G2(:,:);
    img1(:,:,3)=B2(:,:);