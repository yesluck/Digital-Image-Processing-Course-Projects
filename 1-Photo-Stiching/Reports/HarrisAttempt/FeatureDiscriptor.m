%求取关键点周边特征的描述
function [dscrpt] = FeactureDiscriptor(img,x,y)

    %1、对图像进行高斯滤波
    gaussFilter=fspecial('gaussian',5,7);   %gauss低通滤波器，用于高斯模糊。【参数待调】
    gauss=imfilter(img,gaussFilter,'replicate','same');

    %2、取40x40像素的区域。将该区域降采样至8x8的大小，生成一个64维的向量。
    points=length(x)
    descrpt=zeros(points,64);
    for i=1:points
        xL=x(i)-20;
        xR=x(i)+19;
        yL=y(i)-20;
        yR=y(i)+19;
        patch=gauss(xL:xR,yL:yR);
        size(patch);
        patch=imresize(patch,0.2);
        dscrpt(i,:)=reshape((patch-mean2(patch))./std2(patch),1,64); 
    end
    
end