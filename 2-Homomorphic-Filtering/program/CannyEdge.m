function E=CannyEdge(img,type)

    [x,y,~]=size(img);
    
    %��ͼ����ж�ֵ������
    threshold=graythresh(img);
    img1b=im2bw(img,threshold); 
    
    e1 = edge(img1b,'canny');       %����canny��Ե��� 
    e2 = bwareaopen(e1,160,8);      %������ͨ���㷨������С����
    
    %���ݲ�ͬ��ͼ�����ͣ����ò�ͬ�ľ��ζ�ͼ�������������
    if (type==1)
        se = strel('rectangle',[8 8]);
    else
        se = strel('rectangle',[12 12]);
    end
    I = imdilate(e2,se);
    
    %����Բ�̶�ͼ���������ʴ
    se = strel('disk',2);
    I = imerode(I,se);
    
    STATS = regionprops(I,'all');   %��ȡ��ͨ����Ϣ

    %������������Χ��ͨ��
    C=zeros(x,y);
    for i=1:STATS(1).Area
    	C(STATS(1).PixelList(i,2),STATS(1).PixelList(i,1))=1;
    end
    
    %��������������
    C=~C;
    STATS = regionprops(C,'all');
    E=zeros(x,y);
    for i=1:STATS(1).Area
    	E(STATS(1).PixelList(i,2),STATS(1).PixelList(i,1))=1;
    end
    E=~E;
    
end