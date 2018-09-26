function E=CannyEdge(img,type)

    [x,y,~]=size(img);
    
    %对图像进行二值化处理
    threshold=graythresh(img);
    img1b=im2bw(img,threshold); 
    
    e1 = edge(img1b,'canny');       %进行canny边缘检测 
    e2 = bwareaopen(e1,160,8);      %利用连通域算法，消除小区域
    
    %根据不同的图像类型，设置不同的矩形对图像进行区域膨胀
    if (type==1)
        se = strel('rectangle',[8 8]);
    else
        se = strel('rectangle',[12 12]);
    end
    I = imdilate(e2,se);
    
    %设置圆盘对图像进行区域腐蚀
    se = strel('disk',2);
    I = imerode(I,se);
    
    STATS = regionprops(I,'all');   %获取连通域信息

    %独立出工件外围连通域
    C=zeros(x,y);
    for i=1:STATS(1).Area
    	C(STATS(1).PixelList(i,2),STATS(1).PixelList(i,1))=1;
    end
    
    %独立出整个工件
    C=~C;
    STATS = regionprops(C,'all');
    E=zeros(x,y);
    for i=1:STATS(1).Area
    	E(STATS(1).PixelList(i,2),STATS(1).PixelList(i,1))=1;
    end
    E=~E;
    
end