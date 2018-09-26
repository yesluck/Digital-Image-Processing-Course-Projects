function imgh = Advanced(imgh,edge,radiuM)

    imghR(:,:)=imgh(:,:,1);
    imghG(:,:)=imgh(:,:,2);
    imghB(:,:)=imgh(:,:,3);
    
    [x,y,~]=size(imgh);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %第一次处理：针对生成的黑白图像＞0.25的浅色部分
    
    imghb=im2bw(uint8(imgh),0.25); 
    se = strel('disk',4);          %利用矩形进行区域膨胀，使边缘连续
    imghb=imdilate(imghb,se);
    se = strel('disk',6);                   %利用圆盘进行区域收缩
    imghb=imerode(imghb,se);
    se = strel('disk',6);                   %利用圆盘进行区域收缩
    imghb=imerode(imghb,se);
    se = strel('disk',3);          %利用矩形进行区域膨胀，使边缘连续
    imghbe=imdilate(imghb,se);
    
    for i=1:x
        for j=1:y
            if(imghbe(i,j)==1 && j>150 && i<x-50 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50 && imgh(i,j-150,2)<100 &&imgh(i,j-150,3)<100)
                    imghR(i,j)=imgh(i,j-150,1);
                    imghG(i,j)=imgh(i,j-150,2);
                    imghB(i,j)=imgh(i,j-150,3);
                else
                    imghR(i,j)=imgh(i+50,j-150,1);
                    imghG(i,j)=imgh(i+50,j-150,2);
                    imghB(i,j)=imgh(i+50,j-150,3);
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %第二次处理：进行二次同态滤波
    
    imgh=HomoRGB(imghR,imghG,imghB,edge,0.8,0.6);  
    for i=1:x
        for j=1:y
            imgh(i,j,1)=imgh(i,j,1)*1.25/1.1/1.2;
            imgh(i,j,2)=imgh(i,j,2)*1.15/1.1/1.2;
            imgh(i,j,3)=imgh(i,j,3)*1.3/1.1/1.2;
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %第三次处理：针对生成的灰度在65~85范围的的浅色部分
    
    imghg=rgb2gray(uint8(imgh));
    
    imghm=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imghg(i,j)>65 && imghg(i,j)<85)
                imghm(i,j)=1;
            end
        end
    end
    
    se = strel('disk',1);                   %利用圆盘进行区域收缩
    imghm=imerode(imghm,se);
    se = strel('disk',radiuM);          %利用矩形进行区域膨胀，使边缘连续
    imghme=imdilate(imghm,se);
    
    for i=1:x
        for j=1:y
            if(imghme(i,j)==1 && j>150 && i<x-50 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50 && imgh(i,j-150,2)<100 &&imgh(i,j-150,3)<100)
                    imghR(i,j)=imgh(i,j-150,1)*0.78;
                    imghG(i,j)=imgh(i,j-150,2)*0.78;
                    imghB(i,j)=imgh(i,j-150,3)*0.78;
                else
                    imghR(i,j)=imgh(i+50,j-150,1)*0.78;
                    imghG(i,j)=imgh(i+50,j-150,2)*0.78;
                    imghB(i,j)=imgh(i+50,j-150,3)*0.78;
                end
            end
        end
    end
    
    imgh(:,:,1)=imghR(:,:);
    imgh(:,:,2)=imghG(:,:);
    imgh(:,:,3)=imghB(:,:);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %第四次处理：针对生成的灰度在105~117范围的的浅色部分
    
    imghm=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imghg(i,j)>105 && imghg(i,j)<117)
                imghm(i,j)=1;
            end
        end
    end
    
    se = strel('disk',1);                   %利用圆盘进行区域收缩
    imghm=imerode(imghm,se);
    se = strel('disk',5);          %利用矩形进行区域膨胀，使边缘连续
    imghme=imdilate(imghm,se);
    
    for i=1:x
        for j=1:y
            if(imghme(i,j)==1 && j>150 && i<x-50 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50 && imgh(i,j-150,2)<100 &&imgh(i,j-150,3)<100)
                    imghR(i,j)=imgh(i,j-150,1);
                    imghG(i,j)=imgh(i,j-150,2);
                    imghB(i,j)=imgh(i,j-150,3);
                else
                    imghR(i,j)=imgh(i+10,j-150,1);
                    imghG(i,j)=imgh(i+10,j-150,2);
                    imghB(i,j)=imgh(i+10,j-150,3);
                end
            end
        end
    end
    
    imgh(:,:,1)=imghR(:,:);
    imgh(:,:,2)=imghG(:,:);
    imgh(:,:,3)=imghB(:,:);
    
    for i=1:x
        for j=1:y
            imgh(i,j,1)=imgh(i,j,1)*1.4;
            imgh(i,j,2)=imgh(i,j,2)*1.5;
            imgh(i,j,3)=imgh(i,j,3)*1.4;
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %第五次处理：针对生成的灰度在162~173范围的的浅色部分
    
    imgg=rgb2gray(uint8(imgh));
    
    imgz=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imgg(i,j)>162 && imgg(i,j)<173)
                imgz(i,j)=1;
            end
        end
    end
    
    se = strel('rectangle',[2 2]);          %利用矩形进行区域膨胀，使边缘连续
    imgz = imdilate(imgz,se);
    
    se = strel('disk',2);                   %利用圆盘进行区域收缩
    imgz=imerode(imgz,se);
    
    se = strel('rectangle',[5 5]);          %利用矩形进行区域膨胀，使边缘连续
    imgz = imdilate(imgz,se);
    
    for i=1:x
        for j=1:y
            if(imgz(i,j)==1 && j>150 && i<x-50 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50/256 && imgh(i,j-150,2)<100/256 && imgh(i,j-150,3)<100/256)
                    imgh(i,j,1)=imgh(i,j-150,1);
                    imgh(i,j,2)=imgh(i,j-150,2);
                    imgh(i,j,3)=imgh(i,j-150,3);
                else
                    imgh(i,j,1)=imgh(i+50,j-150,1);
                    imgh(i,j,2)=imgh(i+50,j-150,2);
                    imgh(i,j,3)=imgh(i+50,j-150,3);
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %第六次处理：针对生成的灰度在75~140范围的的浅色部分
    
    imgg=rgb2gray(uint8(imgh));
    
    imgz=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imgg(i,j)>75 && imgg(i,j)<140)
                imgz(i,j)=1;
            end
        end
    end
    
    se = strel('disk',2);                   %利用圆盘进行区域收缩
    imgz=imerode(imgz,se);
    
    se = strel('disk',10);          %利用矩形进行区域膨胀，使边缘连续
    imgz = imdilate(imgz,se);
    
    for i=1:x
        for j=1:y
            if(imgz(i,j)==1 && j>150 && i<x-75 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50/256 && imgh(i,j-150,2)<100/256 && imgh(i,j-150,3)<100/256)
                    imgh(i,j,1)=imgh(i,j-150,1);
                    imgh(i,j,2)=imgh(i,j-150,2);
                    imgh(i,j,3)=imgh(i,j-150,3);
                else
                    imgh(i,j,1)=imgh(i+75,j-150,1);
                    imgh(i,j,2)=imgh(i+75,j-150,2);
                    imgh(i,j,3)=imgh(i+75,j-150,3);
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %第七次处理：针对生成的灰度在210以上范围的的浅色部分
    
    imgg=rgb2gray(uint8(imgh));
    
    imgz=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imgg(i,j)>210)
                imgz(i,j)=1;
            end
        end
    end
    for i=1:x
        for j=1:y
            if(imgz(i,j)==1 && j>150 && i<x-75 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50/256 && imgh(i,j-150,2)<100/256 && imgh(i,j-150,3)<100/256)
                    imgh(i,j,1)=imgh(i,j-150,1);
                    imgh(i,j,2)=imgh(i,j-150,2);
                    imgh(i,j,3)=imgh(i,j-150,3);
                else
                    imgh(i,j,1)=imgh(i+75,j-150,1);
                    imgh(i,j,2)=imgh(i+75,j-150,2);
                    imgh(i,j,3)=imgh(i+75,j-150,3);
                end
            end
        end
    end
    
end