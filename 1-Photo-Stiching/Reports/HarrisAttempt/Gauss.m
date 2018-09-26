%将图片化为灰度图并进行高斯滤波
function [gauss] = Gauss(img)

    %1、将RGB图像转化为灰度图(Convert RGB image or colormap to grayscale)
    %  并将灰度图转化为可以进行矩阵运算的双精度图(Convert image to double precision)
    gray=im2double(rgb2gray(img));
    
    %2、对图像进行高斯滤波
    gaussFilter=fspecial('gaussian',[7 7],8);   %gauss低通滤波器，用于高斯模糊。【参数待调】
    gauss=imfilter(gray,gaussFilter);
    
end