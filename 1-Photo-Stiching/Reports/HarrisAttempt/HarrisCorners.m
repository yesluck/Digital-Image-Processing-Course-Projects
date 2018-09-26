%对图片进行Harris角点提取
function [x,y,value] = HarrisCorners(img,widthRangeL,widthRangeR,heightRange,t)

    %img=imread('gauss1.jpg');
    [height,width]=size(img);

    %1、计算图像亮度在x、y两个方向的梯度Ix、Iy
    sobelFilter=fspecial('sobel');  %sobel滤波器,用于边缘提取、计算图像在各个方向亮度的梯度
    Ix=imfilter(img,sobelFilter,'replicate','same');    %x方向亮度梯度
    Iy=imfilter(img,sobelFilter','replicate','same');   %y方向亮度梯度
    
    %2、求得M矩阵（偏导数矩阵）各元素的值
    Ix2=Ix.^2;
    Iy2=Iy.^2;
    IxIy=Ix.*Iy;
    
    %3、对M矩阵各元素进行高斯滤波，为的是消除一些不必要的孤立点和凸起，得到新的矩阵M
    gaussFilter=fspecial('gaussian',[5 5],1);   %gauss低通滤波器，用于高斯模糊。【参数待调】
    Ix2Gauss=imfilter(Ix2,gaussFilter);
    Iy2Gauss=imfilter(Iy2,gaussFilter);
    IxIyGauss=imfilter(IxIy,gaussFilter);
    
    %4、利用M计算对应每个像素的角点响应函数R
    R=(Ix2Gauss.*Iy2Gauss-IxIyGauss.^2)./(Ix2Gauss+Iy2Gauss);
    
    %5、求取R的最大值并设置有效阈值
    Rmax=0;
    for i=1:height  
        for j=1:width  
            if (R(i,j)>Rmax)
                Rmax=R(i,j); 
            end
        end
    end
    Rt=t*Rmax;    %候选角点阈值【参数待调】
    
    %6、筛选角点：删除小于阈值的角点、删除45*25区域内非极大角点，剩余角点为Harris角点
    cnt=0;
    flg=0;
    isCorner=zeros(height,width);
    for i=50:(round(heightRange*height)-50)
        for j=(round(widthRangeL*width)+30):(round(widthRangeR*width)-30)
            for m=1:45
                for n=1:25
                    if (R(i,j)>Rt && R(i,j)>R(i-m,j-n) && R(i,j)>R(i-m,j) && R(i,j)>R(i-m,j+n) && R(i,j)>R(i,j-n) && ...  
                        R(i,j)>R(i,j+n) && R(i,j)>R(i+m,j-n) && R(i,j)>R(i+m,j) && R(i,j)>R(i+m,j+n))  
                        flg=flg+1;
                    else flg=flg-1;
                    end
                end
            end
            if (flg==25*45)
                isCorner(i,j) = 1;  
                cnt=cnt+1;
            end
            flg=0;
        end
    end
    
    %7、将是角点的点传回主函数
    i=1;  
    for j=1:height  
        for k=1:width  
            if (isCorner(j,k)==1) 
                i=i+1;  
            end 
        end
    end
    [x,y,value]=find(isCorner==1);
    
end
    
    
    