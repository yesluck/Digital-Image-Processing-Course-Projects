function [ hdr ] = hdr( filenames, gR, gG, gB, weight, B )
    %% ��ȡ6���ع�Ȳ�ͬ��ͼ��
    numExposures = size(filenames,2);
    image = imread(filenames{1});
   
    hdr = zeros(size(image));
    sum = zeros(size(image));
    
    %% �ֱ��ȡ��6��ͼ�񲢽��д���
    for i=1:numExposures
        
        image = double(imread(filenames{i}));
        wij = weight(image + 1);        
        sum = sum + wij;
        
        m(:,:,1) = (gR(image(:,:,1) + 1) - B(1,i));
        m(:,:,2) = (gG(image(:,:,2) + 1) - B(1,i));
        m(:,:,3) = (gB(image(:,:,3) + 1) - B(1,i));
                
        %������վ�ϵ��о������һ�������ǡ�����(saturated)���ģ�������ֵΪ255������ô����֮ǰͼ��ľ��и����ع�ʱ�����Ϣ�ͱ�ò��ɿ���
        %����������ǣ��������ͼ����и������ع�ʱ�䣬����ֵ�����ԭ���ĸ��ߡ�Ȼ��ԭ��������ֵ�Ѿ��ﵽ����ߵ�255��
        %���Ǹ���Ӧ���ߵ�����ֵҲֻ����255����ʾ�����Ʊ���ɽϴ������Ϊ�˼򻯸÷����ļ��㣬ʹ��Ȩֵ�ͼ�Ȩ��͵ķ�ʽ������ЩӰ�졣
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
    
    %ʹ��Ȩֵ�ͼ�Ȩ��͵ķ�ʽ������ЩӰ�졣�䱾��������һ���ٳ���Щ�����͡������Ĥ��������HDR��������Щ���ֵ����g(z)-B������
    saturatedPixelIndices = find(hdr == 0);
    
    hdr(saturatedPixelIndices) = m(saturatedPixelIndices);
    
    sum(saturatedPixelIndices) = 1;
    
    % ������淶��
    hdr = hdr ./ sum;
    hdr = exp(hdr);
end