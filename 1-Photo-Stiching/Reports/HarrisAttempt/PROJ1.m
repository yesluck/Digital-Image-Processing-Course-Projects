%�ۺ���ҵ1
function PROJ1
    
    %0����ȡͼƬ��Ϣ
    img1=imread('1.jpg');
    [height,width]=size(img1);
    img2=imread('2.jpg');
    %[height2,width2]=size(img2);
    img3=imread('3.jpg');
    %[height3,width3]=size(img3);
    
    %1����ͼƬ��Ϊ�Ҷ�ͼ�����и�˹�˲�
    gauss1=Gauss(img1);
    gauss2=Gauss(img2);
    gauss3=Gauss(img3);

    %2���Ը�˹�˲����ͼ����Harris�ǵ���ȡ(Interest PointDetection)��
    %   ��������ʹ��ͼ1��3����ȡ30���㣻ͼ2���Ҳ����ȡ30����
    [x1,y1,value1]=HarrisCorners(gauss1,   0.596,1.000,   0.495,   0.1);
    [x2L,y2L,value2L]=HarrisCorners(gauss2,0.000,0.378,   0.449,   0.1);
    [x2R,y2R,value2R]=HarrisCorners(gauss2,0.505,1.000,   0.412,   0.1);
    [x3,y3,value3]=HarrisCorners(gauss3,   0.000,0.450,   0.485,   0.1);
    
    %3����ȡ�ؼ����ܱ�����������(Feature Discriptor)
    [dscrpt1]=FeatureDiscriptor(gauss1,x1,y1);
    [dscrpt2L]=FeatureDiscriptor(gauss2,x2L,y2L);
    [dscrpt2R]=FeatureDiscriptor(gauss2,x2R,y2R);
    [dscrpt3]=FeatureDiscriptor(gauss3,x3,y3);
    
    %4����������������֮���ŷ�Ͼ��룬���վ��������С��������
    distA=Dist2(dscrpt1,dscrpt2L);
    [ndistA,indexA]=sort(distA,2);
    ratioA=ndistA(:,1)./ndistA(:,2);
    idxA=ratioA<0.5;
    x1=x1(idxA);
    y1=y1(idxA);
    x2L=x2L(idxA);
    y2L=y2L(idxA);
    npointsA=length(x1)
    
    distB=Dist2(dscrpt3,dscrpt2R);
    [ndistB,indexB]=sort(distB,2);
    ratioB=ndistB(:,1)./ndistB(:,2);
    idxB=ratioB<0.5;
    x3=x3(idxB);
    y3=y3(idxB);
    x2R=x2R(idxB);
    y2R=y2R(idxB);
    npointsB=length(x3)
    
    figure,imshow(img1);  
    hold on;  
    plot(y1,x1,'r+');
    figure,imshow(img2);  
    hold on;  
    plot(y2L,x2L,'r+');
    figure,imshow(img2);  
    hold on;  
    plot(y2R,x2R,'r+');
    figure,imshow(img3);  
    hold on;  
    plot(y3,x3,'r+');
    %end
end