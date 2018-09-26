function img2 = Fog2_HSI(imgb)
    %% 图片读取与三通道提取
    [x,y,~]=size(imgb);[height,width,~]=size(imgb); 
    rgb=im2double(imgb);
    r=rgb(:,:,1);
    g=rgb(:,:,2);
    b=rgb(:,:,3);
    
    %% RGB->HSI
    %求H
    deno=sqrt((r-g).^2+(r-b).*(g-b));
    nomi=0.5*((r-g)+(r-b));
    theta=acos(nomi./deno);
    H=theta;
    H(b>g)=2*pi-H(b>g);
    %求S
    num=min(min(r,g),b);
    deno=r+g+b;
    S=1-3.*num./deno;
    for i=1:x
        for j=1:y
            if S(i,j)==0
                H(i,j)=0;
            end
        end
    end
    %求I
    I=(r+g+b)/3;
    
    %% 对I通道进行直方图均衡处理
    %第一步：统计各灰度级像素数目并记录于PixelN数组
    PixelN=zeros(1,256);
    for i=1:height
        for j=1:width
            I(i,j)=round(I(i,j)*255);
            PixelN((I(i,j)+1))=PixelN((I(i,j)+1))+1;
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
    PixelDisc=uint8(256.*PixelAccu-0.5);
    %第五步：将各原灰度值映射存储于新图像中
    for i=1:height
        for j=1:width
            I(i,j)=PixelDisc(I(i,j));
            S(i,j)=3*S(i,j);
        end
    end
    
    %% HSI->RGB
    
    R=zeros(x,y);
    G=zeros(x,y);
    B=zeros(x,y);

    for i=1:x
        for j=1:y
            if ((0<=H(i,j))&&(H(i,j)<2*pi/3))
                B(i,j)=I(i,j).*(1-S(i,j));
                R(i,j)=I(i,j).*(1+S(i,j).*cos(H(i,j))./cos(pi/3-H(i,j)));
                G(i,j)=3*I(i,j)-(R(i,j)+B(i,j));
            else
                if (2*pi/3<=H(i,j))&&(H(i,j)<4*pi/3)
                    R(i,j)=I(i,j).*(1-S(i,j));
                    G(i,j)=I(i,j).*(1+S(i,j).*cos(H(i,j)-2*pi/3)./cos(pi-H(i,j)));
                    B(i,j)=3*I(i,j)-(R(i,j)+G(i,j));
                else
                    if (4*pi/3<=H(i,j))&&(H(i,j)<=2*pi)
                        G(i,j)=I(i,j).*(1-S(i,j));
                        B(i,j)=I(i,j).*(1+S(i,j).*cos(H(i,j)-4*pi/3)./cos(5*pi/3-H(i,j)));
                        R(i,j)=3*I(i,j)-(G(i,j)+B(i,j));
                    end
                end
            end
        end
    end
    
    img2=uint8(cat(3,R,G,B));
    