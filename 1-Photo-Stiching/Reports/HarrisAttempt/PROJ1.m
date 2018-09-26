%综合作业1
function PROJ1
    
    %0、获取图片信息
    img1=imread('1.jpg');
    [height,width]=size(img1);
    img2=imread('2.jpg');
    %[height2,width2]=size(img2);
    img3=imread('3.jpg');
    %[height3,width3]=size(img3);
    
    %1、将图片化为灰度图并进行高斯滤波
    gauss1=Gauss(img1);
    gauss2=Gauss(img2);
    gauss3=Gauss(img3);

    %2、对高斯滤波后的图进行Harris角点提取(Interest PointDetection)，
    %   调整参数使：图1、3各提取30个点；图2左、右侧各提取30个点
    [x1,y1,value1]=HarrisCorners(gauss1,   0.596,1.000,   0.495,   0.1);
    [x2L,y2L,value2L]=HarrisCorners(gauss2,0.000,0.378,   0.449,   0.1);
    [x2R,y2R,value2R]=HarrisCorners(gauss2,0.505,1.000,   0.412,   0.1);
    [x3,y3,value3]=HarrisCorners(gauss3,   0.000,0.450,   0.485,   0.1);
    
    %3、求取关键点周边特征的描述(Feature Discriptor)
    [dscrpt1]=FeatureDiscriptor(gauss1,x1,y1);
    [dscrpt2L]=FeatureDiscriptor(gauss2,x2L,y2L);
    [dscrpt2R]=FeatureDiscriptor(gauss2,x2R,y2R);
    [dscrpt3]=FeatureDiscriptor(gauss3,x3,y3);
    
    %4、计算特征点两两之间的欧氏距离，按照距离比例由小到大排序。
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