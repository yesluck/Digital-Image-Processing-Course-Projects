function [ zR, zG, zB ] = makeImageMatrix( filenames, numPixels )
    
    numExposures = size(filenames,2);

    numSamples = ceil(255*2 / (numExposures - 1)) * 2;  %��������������������6�Ų�ͬ�ع�ȵ�ͼ����Ҫ�Ĳ�����Ϊ204��
    
    %����һ���Ȳ����������������
    step = numPixels / numSamples;                      %����=�����ص���/�������ص���
    sampleIndices = floor((1:step:numPixels));
    sampleIndices = sampleIndices';
    
    %RGB��ͨ���ֱ���
    zR = zeros(numSamples, numExposures);
    zG = zeros(numSamples, numExposures);
    zB = zeros(numSamples, numExposures);
    
    %����ÿһ��ͼ��
    for i=1:numExposures
        
        image = imread(filenames{i});   %1����ȡͼ��

        [zRpoint, zGpoint, zBpoint] = rgbSample(image, sampleIndices); %2����ȡ�����㼰��RGB��Ϣ(����rgbSample.m����ͨ�����зֱ����)
        
        %������ͼ�Ĳ�������Ϣ����һ��������
        zR(:,i) = zRpoint;
        zG(:,i) = zGpoint;
        zB(:,i) = zBpoint;
    end
end