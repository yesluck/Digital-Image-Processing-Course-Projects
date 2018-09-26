%��ͼƬ����Harris�ǵ���ȡ
function [x,y,value] = HarrisCorners(img,widthRangeL,widthRangeR,heightRange,t)

    %img=imread('gauss1.jpg');
    [height,width]=size(img);

    %1������ͼ��������x��y����������ݶ�Ix��Iy
    sobelFilter=fspecial('sobel');  %sobel�˲���,���ڱ�Ե��ȡ������ͼ���ڸ����������ȵ��ݶ�
    Ix=imfilter(img,sobelFilter,'replicate','same');    %x���������ݶ�
    Iy=imfilter(img,sobelFilter','replicate','same');   %y���������ݶ�
    
    %2�����M����ƫ�������󣩸�Ԫ�ص�ֵ
    Ix2=Ix.^2;
    Iy2=Iy.^2;
    IxIy=Ix.*Iy;
    
    %3����M�����Ԫ�ؽ��и�˹�˲���Ϊ��������һЩ����Ҫ�Ĺ������͹�𣬵õ��µľ���M
    gaussFilter=fspecial('gaussian',[5 5],1);   %gauss��ͨ�˲��������ڸ�˹ģ����������������
    Ix2Gauss=imfilter(Ix2,gaussFilter);
    Iy2Gauss=imfilter(Iy2,gaussFilter);
    IxIyGauss=imfilter(IxIy,gaussFilter);
    
    %4������M�����Ӧÿ�����صĽǵ���Ӧ����R
    R=(Ix2Gauss.*Iy2Gauss-IxIyGauss.^2)./(Ix2Gauss+Iy2Gauss);
    
    %5����ȡR�����ֵ��������Ч��ֵ
    Rmax=0;
    for i=1:height  
        for j=1:width  
            if (R(i,j)>Rmax)
                Rmax=R(i,j); 
            end
        end
    end
    Rt=t*Rmax;    %��ѡ�ǵ���ֵ������������
    
    %6��ɸѡ�ǵ㣺ɾ��С����ֵ�Ľǵ㡢ɾ��45*25�����ڷǼ���ǵ㣬ʣ��ǵ�ΪHarris�ǵ�
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
    
    %7�����ǽǵ�ĵ㴫��������
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
    
    
    