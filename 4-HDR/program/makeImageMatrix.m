function [ zR, zG, zB ] = makeImageMatrix( filenames, numPixels )
    
    numExposures = size(filenames,2);

    numSamples = ceil(255*2 / (numExposures - 1)) * 2;  %建立采样点向量：对于6张不同曝光度的图像，需要的采样点为204个
    
    %建立一个等步长的随机采样矩阵
    step = numPixels / numSamples;                      %步长=总像素点数/采样像素点数
    sampleIndices = floor((1:step:numPixels));
    sampleIndices = sampleIndices';
    
    %RGB三通道分别处理
    zR = zeros(numSamples, numExposures);
    zG = zeros(numSamples, numExposures);
    zB = zeros(numSamples, numExposures);
    
    %对于每一张图像
    for i=1:numExposures
        
        image = imread(filenames{i});   %1、读取图像

        [zRpoint, zGpoint, zBpoint] = rgbSample(image, sampleIndices); %2、获取采样点及其RGB信息(调用rgbSample.m对三通道进行分别采样)
        
        %将各张图的采样点信息记入一个矩阵中
        zR(:,i) = zRpoint;
        zG(:,i) = zGpoint;
        zB(:,i) = zBpoint;
    end
end