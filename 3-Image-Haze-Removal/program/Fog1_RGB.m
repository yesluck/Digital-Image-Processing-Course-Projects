function img1 = Fog1_RGB(imgb)
    %% 图片读取与三通道提取
    imgd=double(imgb);	%转换为双精度
    [height,width,~]=size(imgd);	%读取尺寸
    R=imgd(:,:,1);      %分别提取三通道值
    G=imgd(:,:,2); 
    B=imgd(:,:,3);
    
    %% 对R通道进行直方图均衡处理
    %第一步：统计各灰度级像素数目并记录于PixelN数组
    PixelN=zeros(1,256);
    for i=1:height
        for j=1:width
            PixelN((R(i,j)+1))=PixelN((R(i,j)+1))+1;
        end
    end
    %第二步：计算各灰度级分布密度并记录于PixelP数组
    PixelP=zeros(1,256);
    for i=1:256
        PixelP(i)=PixelN(i)/(height*width);
    end
    %第三步：计算灰度级累计分布并记录于PixelAccu数组
    PixelAccu=zeros(1,256);
    for i=1:256
        if i==1
            PixelAccu(i)=PixelP(i);
        else
            PixelAccu(i)=PixelAccu(i-1)+PixelP(i);
        end
    end
    %第四步：将累计分布转换为0~255的灰度级并记录于PixelDisc数组
    PixelDisc=zeros(1,256);
    PixelDisc=uint8(255.*PixelAccu+0.5);
    %第五步：将各原灰度值映射存储于新图像中
    for i=1:height
        for j=1:width
            R2(i,j)=PixelDisc(R(i,j)+1);
        end
    end
    
    %% 对G通道进行直方图均衡处理
    %第一步：统计各灰度级像素数目并记录于PixelN数组
    PixelN=zeros(1,256);
    for i=1:height
        for j=1:width
            PixelN((G(i,j)+1))=PixelN((G(i,j)+1))+1;
        end
    end
    %第二步：计算各灰度级分布密度并记录于PixelP数组
    PixelP=zeros(1,256);
    for i=1:256
        PixelP(i)=PixelN(i)/(height*width);
    end
    %第三步：计算灰度级累计分布并记录于PixelAccu数组
    PixelAccu=zeros(1,256);
    for i=1:256
        if i==1
            PixelAccu(i)=PixelP(i);
        else
            PixelAccu(i)=PixelAccu(i-1)+PixelP(i);
        end
    end
    %第四步：将累计分布转换为0~255的灰度级并记录于PixelDisc数组
    PixelDisc=zeros(1,256);
    PixelDisc=uint8(255.*PixelAccu+0.5);
    %第五步：将各原灰度值映射存储于新图像中
    for i=1:height
        for j=1:width
            G2(i,j)=PixelDisc(G(i,j)+1);
        end
    end
    
    %% 对B通道进行直方图均衡处理
    %第一步：统计各灰度级像素数目并记录于PixelN数组
    PixelN=zeros(1,256);
    for i=1:height
        for j=1:width
            PixelN((B(i,j)+1))=PixelN((B(i,j)+1))+1;
        end
    end
    %第二步：计算各灰度级分布密度并记录于PixelP数组
    PixelP=zeros(1,256);
    for i=1:256
        PixelP(i)=PixelN(i)/(height*width);
    end
    %第三步：计算灰度级累计分布并记录于PixelAccu数组
    PixelAccu=zeros(1,256);
    for i=1:256
        if i==1
            PixelAccu(i)=PixelP(i);
        else
            PixelAccu(i)=PixelAccu(i-1)+PixelP(i);
        end
    end
    %第四步：将累计分布转换为0~255的灰度级并记录于PixelDisc数组
    PixelDisc=zeros(1,256);
    PixelDisc=uint8(255.*PixelAccu+0.5);
    %第五步：将各原灰度值映射存储于新图像中
    for i=1:height
        for j=1:width
            B2(i,j)=PixelDisc(B(i,j)+1);
        end
    end
    
    %% 图像RGB三通道重组
    img1(:,:,1)=R2(:,:);
    img1(:,:,2)=G2(:,:);
    img1(:,:,3)=B2(:,:);