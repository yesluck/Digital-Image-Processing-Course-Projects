function PROJ1

    %读取三张图片及其尺寸大小
    img1= imread('1.jpg');
    img2= imread('2.jpg');
    img3= imread('3.jpg');
    [M,N,~]=size(img1);
    
    %分离三张图片的RGB值，并根据各图曝光度进行微调
    img1r(:,:)=img1(:,:,1)-15;
    img1g(:,:)=img1(:,:,2)-21;
    img1b(:,:)=img1(:,:,3)-21;
    
    img2r(:,:)=img2(:,:,1);
    img2g(:,:)=img2(:,:,2);
    img2b(:,:)=img2(:,:,3);
    
    img3r(:,:)=min(img3(:,:,1)+9,255);
    img3g(:,:)=min(img3(:,:,2)+6,255);
    img3b(:,:)=min(img3(:,:,3)+11,255);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %图片1与图片2的拼接

    dot=[2032,845;2593,806;2051,1869;2638,1870];    %选取想让它成为矩形的四个点，在图中以主楼左侧的窗户四角为基准点
    w=round(sqrt((dot(1,1)-dot(2,1))^2+(dot(1,2)-dot(2,2))^2));	%从原四边形获得新矩形宽
    h=round(sqrt((dot(1,1)-dot(3,1))^2+(dot(1,2)-dot(3,2))^2));	%从原四边形获得新矩形高
    
    %控制点坐标
    x=[dot(1,1) dot(2,1) dot(3,1) dot(4,1)];
    y=[dot(1,2) dot(2,2) dot(3,2) dot(4,2)];
    %对应点坐标
    X=[dot(1,1) dot(1,1)+w dot(1,1) dot(1,1)+w];
    Y=[dot(1,2) dot(1,2) dot(1,2)+h dot(1,2)+h];     
    
    %根据仿射变换原理设置求解rot矩阵
    B=[X(1) Y(1) X(2) Y(2) X(3) Y(3) X(4) Y(4)]';
    A=[x(1) y(1) 1 0 0 0 -X(1)*x(1) -X(1)*y(1);             
       0 0 0 x(1) y(1) 1 -Y(1)*x(1) -Y(1)*y(1);
       x(2) y(2) 1 0 0 0 -X(2)*x(2) -X(2)*y(2);
       0 0 0 x(2) y(2) 1 -Y(2)*x(2) -Y(2)*y(2);
       x(3) y(3) 1 0 0 0 -X(3)*x(3) -X(3)*y(3);
       0 0 0 x(3) y(3) 1 -Y(3)*x(3) -Y(3)*y(3);
       x(4) y(4) 1 0 0 0 -X(4)*x(4) -X(4)*y(4);
       0 0 0 x(4) y(4) 1 -Y(4)*x(4) -Y(4)*y(4)];
    fa=A\B;	%[a b c d e f g h]矩阵
    a=fa(1);b=fa(2);c=fa(3);
    d=fa(4);e=fa(5);f=fa(6);
    g=fa(7);h=fa(8);
    rot=[a b c;
         d e f;
         g h 1];    %求取变换矩阵

    LU=rot*[1 1 1]'/(g*1+h*1+1);  %变换后图像左上点
    RU=rot*[M 1 1]'/(g*M+h*1+1);  %变换后图像右上点
    LD=rot*[1 N 1]'/(g*1+h*N+1);  %变换后图像左下点
    RD=rot*[M N 1]'/(g*M+h*N+1);  %变换后图像右下点

    height=round(max([LU(2) RU(2) LD(2) RD(2)])-min([LU(2) RU(2) LD(2) RD(2)]));    %变换后图像的高度
    length=round(max([LU(1) RU(1) LD(1) RD(1)])-min([LU(1) RU(1) LD(1) RD(1)]));	%变换后图像的宽度
    imgn=zeros(length,height);

    delta_x=round(abs(min([LU(1) RU(1) LD(1) RD(1)])));	%取得x方向的负轴超出的偏移量
    delta_y=round(abs(min([LU(2) RU(2) LD(2) RD(2)])));	%取得y方向的负轴超出的偏移量
    inv_rot=inv(rot);   %变换矩阵的逆矩阵

    %插值寻点
    for i = 1-delta_x:length-delta_x
        for j = 1-delta_y:height-delta_y
            pix=inv_rot*[i j 1]';       %求原图像中坐标
            pix=inv([g*pix(1)-1 h*pix(1);g*pix(2) h*pix(2)-1])*[-pix(1) -pix(2)]';
            if pix(1)>=0.5 && pix(2)>=0.5 && pix(1)<=M && pix(2)<=N
                %最近邻插值
                imgnr(i+delta_x,j+delta_y)=img1r(round(pix(1)),round(pix(2)));
                imgng(i+delta_x,j+delta_y)=img1g(round(pix(1)),round(pix(2)));
                imgnb(i+delta_x,j+delta_y)=img1b(round(pix(1)),round(pix(2)));
            end  
        end
    end
    
    %RGB通道合成为一张彩色图imgn
    imgn(:,:,1)=imgnr(:,:);
    imgn(:,:,2)=imgng(:,:);
    imgn(:,:,3)=imgnb(:,:);
    
    imgn1=imrotate(imgn,-3,'bilinear','Loose'); %根据图片方向，进行旋转变换。此处使用Matlab函数，使之顺时针旋转3°
    imgn2=imresize(imgn1,0.85,'bilinear');      %根据图1、图2比例关系，进行放缩变换。此处使用Matlab函数，使之缩小为原图的0.85倍
    
    %根据拼接对应点关系，将图1、图2汇总至一张新图中
    for i=1:2722
        for j=1:2260
            for k=1:3
                img12(i,j,k)=imgn2(i,j,k);
            end
        end
    end
    for i=434:2881
        for j=2261:5440
            for k=1:3
                img12(i,j,k)=img2(i-433,j-2176,k);
            end
        end
    end
    
    %显示并保存图1、图2拼接结果
    figure;
    imshow(uint8(img12));
    imwrite(uint8(img12),'1&2.jpg');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %图片1、图片2的拼接结果 和 图片3 的拼接

    dot=[914,101;1548,47;938,605;1547,571]; %选取想让它成为矩形的四个点，在图中以主楼右侧的窗户四角为基准点
    w=round(sqrt((dot(1,1)-dot(2,1))^2+(dot(1,2)-dot(2,2))^2));     %从原四边形获得新矩形宽
    h=round(sqrt((dot(1,1)-dot(3,1))^2+(dot(1,2)-dot(3,2))^2));     %从原四边形获得新矩形高
    
    %控制点坐标
    x=[dot(1,1) dot(2,1) dot(3,1) dot(4,1)];
    y=[dot(1,2) dot(2,2) dot(3,2) dot(4,2)];
    %对应点坐标
    X=[dot(1,1) dot(1,1)+w dot(1,1) dot(1,1)+w];
    Y=[dot(1,2) dot(1,2) dot(1,2)+h dot(1,2)+h];    
    
    %根据仿射变换原理设置求解rot矩阵
    B=[X(1) Y(1) X(2) Y(2) X(3) Y(3) X(4) Y(4)]';
    A=[x(1) y(1) 1 0 0 0 -X(1)*x(1) -X(1)*y(1);             
       0 0 0 x(1) y(1) 1 -Y(1)*x(1) -Y(1)*y(1);
       x(2) y(2) 1 0 0 0 -X(2)*x(2) -X(2)*y(2);
       0 0 0 x(2) y(2) 1 -Y(2)*x(2) -Y(2)*y(2);
       x(3) y(3) 1 0 0 0 -X(3)*x(3) -X(3)*y(3);
       0 0 0 x(3) y(3) 1 -Y(3)*x(3) -Y(3)*y(3);
       x(4) y(4) 1 0 0 0 -X(4)*x(4) -X(4)*y(4);
       0 0 0 x(4) y(4) 1 -Y(4)*x(4) -Y(4)*y(4)];
    fa=A\B;	%[a b c d e f g h]矩阵
    a=fa(1);b=fa(2);c=fa(3);
    d=fa(4);e=fa(5);f=fa(6);
    g=fa(7);h=fa(8);
    rot=[a b c;
         d e f;
         g h 1];	%求取变换矩阵

    LU=rot*[1 1 1]'/(g*1+h*1+1);  %变换后图像左上点
    RU=rot*[M 1 1]'/(g*M+h*1+1);  %变换后图像右上点
    LD=rot*[1 N 1]'/(g*1+h*N+1);  %变换后图像左下点
    RD=rot*[M N 1]'/(g*M+h*N+1);  %变换后图像右下点

    height=round(max([LU(2) RU(2) LD(2) RD(2)])-min([LU(2) RU(2) LD(2) RD(2)]));	%变换后图像的高度
    length=round(max([LU(1) RU(1) LD(1) RD(1)])-min([LU(1) RU(1) LD(1) RD(1)]));	%变换后图像的宽度
    imgm=zeros(length,height-1);

    delta_x=round(abs(min([LU(1) RU(1) LD(1) RD(1)])));	%取得x方向的负轴超出的偏移量
    delta_y=round(abs(min([LU(2) RU(2) LD(2) RD(2)])));	%取得y方向的负轴超出的偏移量
    inv_rot=inv(rot);   %变换矩阵的逆矩阵

    %插值寻点
    for i = 1-delta_x:length-delta_x
        for j = 1-delta_y:height-delta_y
            pix=inv_rot*[i j 1]';	%求原图像中坐标
            pix=inv([g*pix(1)-1 h*pix(1);g*pix(2) h*pix(2)-1])*[-pix(1) -pix(2)]';
            %最近邻插值
            if pix(1)>=0.5 && pix(2)>=0.5 && pix(1)<=M && pix(2)<=N
                imgmr(i+delta_x,j+delta_y)=img3r(round(pix(1)),round(pix(2)));
                imgmg(i+delta_x,j+delta_y)=img3g(round(pix(1)),round(pix(2)));
                imgmb(i+delta_x,j+delta_y)=img3b(round(pix(1)),round(pix(2)));
            end  
        end
    end
    
    %RGB通道合成为一张彩色图imgm
    imgm(:,:,1)=imgmr(:,:);
    imgm(:,:,2)=imgmg(:,:);
    imgm(:,:,3)=imgmb(:,:);

    img3=imresize(imgm,1.077,'bilinear');   %根据图1、图2比例关系，进行放缩变换。此处使用Matlab函数，使之放大为原图的1.077倍
    
    %根据拼接对应点关系，将图1、图2汇总至一张新图中
    for i=586:3466
        for j=1:5292
            for k=1:3
                img123(i,j,k)=img12(i-585,j,k);
            end
        end
    end
    for i=1:3317
        for j=5293:8245
            for k=1:3
                img123(i,j,k)=img3(i,j-3835,k);
            end
        end
    end
    
    %显示并保存最终拼接结果
    figure;
    imshow(uint8(img123));
    imwrite(uint8(img123),'1&2&3.jpg');
    end
    