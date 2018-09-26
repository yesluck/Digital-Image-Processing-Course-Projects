function [ hdr ] = hdr( filenames, gR, gG, gB, weight, B )
    %% 读取6张曝光度不同的图像
    numExposures = size(filenames,2);
    image = imread(filenames{1});
   
    hdr = zeros(size(image));
    sum = zeros(size(image));
    
    %% 分别读取这6张图像并进行处理
    for i=1:numExposures
        
        image = double(imread(filenames{i}));
        wij = weight(image + 1);        
        sum = sum + wij;
        
        m(:,:,1) = (gR(image(:,:,1) + 1) - B(1,i));
        m(:,:,2) = (gG(image(:,:,2) + 1) - B(1,i));
        m(:,:,3) = (gB(image(:,:,3) + 1) - B(1,i));
                
        %根据网站上的研究，如果一个像素是“饱和(saturated)”的（即像素值为255），那么它和之前图像的具有更长曝光时间的信息就变得不可靠了
        %（个人理解是：如果这张图像具有更长的曝光时间，像素值将会比原来的更高。然而原来的像素值已经达到了最高的255，
        %则那个本应更高的像素值也只能以255来表示，这势必造成较大的误差）。为了简化该方法的计算，使用权值和加权求和的方式忽略这些影响。
        saturatedPixels = ones(size(image));    
        saturatedPixelsRed = find(image(:,:,1) == 255);
        saturatedPixelsGreen = find(image(:,:,2) == 255);
        saturatedPixelsBlue = find(image(:,:,3) == 255);
            
        pixels = size(image,1) * size(image,2);
 
        saturatedPixels(saturatedPixelsRed) = 0;
        saturatedPixels(saturatedPixelsRed + pixels) = 0;
        saturatedPixels(saturatedPixelsRed + 2*pixels) = 0;
           
        saturatedPixels(saturatedPixelsGreen) = 0;
        saturatedPixels(saturatedPixelsGreen + pixels) = 0;
        saturatedPixels(saturatedPixelsGreen + 2*pixels) = 0;
            
        saturatedPixels(saturatedPixelsBlue) = 0;
        saturatedPixels(saturatedPixelsBlue + pixels) = 0;
        saturatedPixels(saturatedPixelsBlue + 2*pixels) = 0;

        hdr = hdr + (wij .* m);
        hdr = hdr .* saturatedPixels;
        sum = sum .* saturatedPixels;
    end
    
    %使用权值和加权求和的方式忽略这些影响。其本质是生成一个刨除这些“饱和”点的掩膜，在最后的HDR处理中这些点的值将以g(z)-B来代替
    saturatedPixelIndices = find(hdr == 0);
    
    hdr(saturatedPixelIndices) = m(saturatedPixelIndices);
    
    sum(saturatedPixelIndices) = 1;
    
    % 求解结果规范化
    hdr = hdr ./ sum;
    hdr = exp(hdr);
end