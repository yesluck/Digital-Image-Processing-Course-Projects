function PROJ1

    %��ȡ����ͼƬ����ߴ��С
    img1= imread('1.jpg');
    img2= imread('2.jpg');
    img3= imread('3.jpg');
    [M,N,~]=size(img1);
    
    %��������ͼƬ��RGBֵ�������ݸ�ͼ�ع�Ƚ���΢��
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
    %ͼƬ1��ͼƬ2��ƴ��

    dot=[2032,845;2593,806;2051,1869;2638,1870];    %ѡȡ��������Ϊ���ε��ĸ��㣬��ͼ������¥���Ĵ����Ľ�Ϊ��׼��
    w=round(sqrt((dot(1,1)-dot(2,1))^2+(dot(1,2)-dot(2,2))^2));	%��ԭ�ı��λ���¾��ο�
    h=round(sqrt((dot(1,1)-dot(3,1))^2+(dot(1,2)-dot(3,2))^2));	%��ԭ�ı��λ���¾��θ�
    
    %���Ƶ�����
    x=[dot(1,1) dot(2,1) dot(3,1) dot(4,1)];
    y=[dot(1,2) dot(2,2) dot(3,2) dot(4,2)];
    %��Ӧ������
    X=[dot(1,1) dot(1,1)+w dot(1,1) dot(1,1)+w];
    Y=[dot(1,2) dot(1,2) dot(1,2)+h dot(1,2)+h];     
    
    %���ݷ���任ԭ���������rot����
    B=[X(1) Y(1) X(2) Y(2) X(3) Y(3) X(4) Y(4)]';
    A=[x(1) y(1) 1 0 0 0 -X(1)*x(1) -X(1)*y(1);             
       0 0 0 x(1) y(1) 1 -Y(1)*x(1) -Y(1)*y(1);
       x(2) y(2) 1 0 0 0 -X(2)*x(2) -X(2)*y(2);
       0 0 0 x(2) y(2) 1 -Y(2)*x(2) -Y(2)*y(2);
       x(3) y(3) 1 0 0 0 -X(3)*x(3) -X(3)*y(3);
       0 0 0 x(3) y(3) 1 -Y(3)*x(3) -Y(3)*y(3);
       x(4) y(4) 1 0 0 0 -X(4)*x(4) -X(4)*y(4);
       0 0 0 x(4) y(4) 1 -Y(4)*x(4) -Y(4)*y(4)];
    fa=A\B;	%[a b c d e f g h]����
    a=fa(1);b=fa(2);c=fa(3);
    d=fa(4);e=fa(5);f=fa(6);
    g=fa(7);h=fa(8);
    rot=[a b c;
         d e f;
         g h 1];    %��ȡ�任����

    LU=rot*[1 1 1]'/(g*1+h*1+1);  %�任��ͼ�����ϵ�
    RU=rot*[M 1 1]'/(g*M+h*1+1);  %�任��ͼ�����ϵ�
    LD=rot*[1 N 1]'/(g*1+h*N+1);  %�任��ͼ�����µ�
    RD=rot*[M N 1]'/(g*M+h*N+1);  %�任��ͼ�����µ�

    height=round(max([LU(2) RU(2) LD(2) RD(2)])-min([LU(2) RU(2) LD(2) RD(2)]));    %�任��ͼ��ĸ߶�
    length=round(max([LU(1) RU(1) LD(1) RD(1)])-min([LU(1) RU(1) LD(1) RD(1)]));	%�任��ͼ��Ŀ��
    imgn=zeros(length,height);

    delta_x=round(abs(min([LU(1) RU(1) LD(1) RD(1)])));	%ȡ��x����ĸ��ᳬ����ƫ����
    delta_y=round(abs(min([LU(2) RU(2) LD(2) RD(2)])));	%ȡ��y����ĸ��ᳬ����ƫ����
    inv_rot=inv(rot);   %�任����������

    %��ֵѰ��
    for i = 1-delta_x:length-delta_x
        for j = 1-delta_y:height-delta_y
            pix=inv_rot*[i j 1]';       %��ԭͼ��������
            pix=inv([g*pix(1)-1 h*pix(1);g*pix(2) h*pix(2)-1])*[-pix(1) -pix(2)]';
            if pix(1)>=0.5 && pix(2)>=0.5 && pix(1)<=M && pix(2)<=N
                %����ڲ�ֵ
                imgnr(i+delta_x,j+delta_y)=img1r(round(pix(1)),round(pix(2)));
                imgng(i+delta_x,j+delta_y)=img1g(round(pix(1)),round(pix(2)));
                imgnb(i+delta_x,j+delta_y)=img1b(round(pix(1)),round(pix(2)));
            end  
        end
    end
    
    %RGBͨ���ϳ�Ϊһ�Ų�ɫͼimgn
    imgn(:,:,1)=imgnr(:,:);
    imgn(:,:,2)=imgng(:,:);
    imgn(:,:,3)=imgnb(:,:);
    
    imgn1=imrotate(imgn,-3,'bilinear','Loose'); %����ͼƬ���򣬽�����ת�任���˴�ʹ��Matlab������ʹ֮˳ʱ����ת3��
    imgn2=imresize(imgn1,0.85,'bilinear');      %����ͼ1��ͼ2������ϵ�����з����任���˴�ʹ��Matlab������ʹ֮��СΪԭͼ��0.85��
    
    %����ƴ�Ӷ�Ӧ���ϵ����ͼ1��ͼ2������һ����ͼ��
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
    
    %��ʾ������ͼ1��ͼ2ƴ�ӽ��
    figure;
    imshow(uint8(img12));
    imwrite(uint8(img12),'1&2.jpg');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %ͼƬ1��ͼƬ2��ƴ�ӽ�� �� ͼƬ3 ��ƴ��

    dot=[914,101;1548,47;938,605;1547,571]; %ѡȡ��������Ϊ���ε��ĸ��㣬��ͼ������¥�Ҳ�Ĵ����Ľ�Ϊ��׼��
    w=round(sqrt((dot(1,1)-dot(2,1))^2+(dot(1,2)-dot(2,2))^2));     %��ԭ�ı��λ���¾��ο�
    h=round(sqrt((dot(1,1)-dot(3,1))^2+(dot(1,2)-dot(3,2))^2));     %��ԭ�ı��λ���¾��θ�
    
    %���Ƶ�����
    x=[dot(1,1) dot(2,1) dot(3,1) dot(4,1)];
    y=[dot(1,2) dot(2,2) dot(3,2) dot(4,2)];
    %��Ӧ������
    X=[dot(1,1) dot(1,1)+w dot(1,1) dot(1,1)+w];
    Y=[dot(1,2) dot(1,2) dot(1,2)+h dot(1,2)+h];    
    
    %���ݷ���任ԭ���������rot����
    B=[X(1) Y(1) X(2) Y(2) X(3) Y(3) X(4) Y(4)]';
    A=[x(1) y(1) 1 0 0 0 -X(1)*x(1) -X(1)*y(1);             
       0 0 0 x(1) y(1) 1 -Y(1)*x(1) -Y(1)*y(1);
       x(2) y(2) 1 0 0 0 -X(2)*x(2) -X(2)*y(2);
       0 0 0 x(2) y(2) 1 -Y(2)*x(2) -Y(2)*y(2);
       x(3) y(3) 1 0 0 0 -X(3)*x(3) -X(3)*y(3);
       0 0 0 x(3) y(3) 1 -Y(3)*x(3) -Y(3)*y(3);
       x(4) y(4) 1 0 0 0 -X(4)*x(4) -X(4)*y(4);
       0 0 0 x(4) y(4) 1 -Y(4)*x(4) -Y(4)*y(4)];
    fa=A\B;	%[a b c d e f g h]����
    a=fa(1);b=fa(2);c=fa(3);
    d=fa(4);e=fa(5);f=fa(6);
    g=fa(7);h=fa(8);
    rot=[a b c;
         d e f;
         g h 1];	%��ȡ�任����

    LU=rot*[1 1 1]'/(g*1+h*1+1);  %�任��ͼ�����ϵ�
    RU=rot*[M 1 1]'/(g*M+h*1+1);  %�任��ͼ�����ϵ�
    LD=rot*[1 N 1]'/(g*1+h*N+1);  %�任��ͼ�����µ�
    RD=rot*[M N 1]'/(g*M+h*N+1);  %�任��ͼ�����µ�

    height=round(max([LU(2) RU(2) LD(2) RD(2)])-min([LU(2) RU(2) LD(2) RD(2)]));	%�任��ͼ��ĸ߶�
    length=round(max([LU(1) RU(1) LD(1) RD(1)])-min([LU(1) RU(1) LD(1) RD(1)]));	%�任��ͼ��Ŀ��
    imgm=zeros(length,height-1);

    delta_x=round(abs(min([LU(1) RU(1) LD(1) RD(1)])));	%ȡ��x����ĸ��ᳬ����ƫ����
    delta_y=round(abs(min([LU(2) RU(2) LD(2) RD(2)])));	%ȡ��y����ĸ��ᳬ����ƫ����
    inv_rot=inv(rot);   %�任����������

    %��ֵѰ��
    for i = 1-delta_x:length-delta_x
        for j = 1-delta_y:height-delta_y
            pix=inv_rot*[i j 1]';	%��ԭͼ��������
            pix=inv([g*pix(1)-1 h*pix(1);g*pix(2) h*pix(2)-1])*[-pix(1) -pix(2)]';
            %����ڲ�ֵ
            if pix(1)>=0.5 && pix(2)>=0.5 && pix(1)<=M && pix(2)<=N
                imgmr(i+delta_x,j+delta_y)=img3r(round(pix(1)),round(pix(2)));
                imgmg(i+delta_x,j+delta_y)=img3g(round(pix(1)),round(pix(2)));
                imgmb(i+delta_x,j+delta_y)=img3b(round(pix(1)),round(pix(2)));
            end  
        end
    end
    
    %RGBͨ���ϳ�Ϊһ�Ų�ɫͼimgm
    imgm(:,:,1)=imgmr(:,:);
    imgm(:,:,2)=imgmg(:,:);
    imgm(:,:,3)=imgmb(:,:);

    img3=imresize(imgm,1.077,'bilinear');   %����ͼ1��ͼ2������ϵ�����з����任���˴�ʹ��Matlab������ʹ֮�Ŵ�Ϊԭͼ��1.077��
    
    %����ƴ�Ӷ�Ӧ���ϵ����ͼ1��ͼ2������һ����ͼ��
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
    
    %��ʾ����������ƴ�ӽ��
    figure;
    imshow(uint8(img123));
    imwrite(uint8(img123),'1&2&3.jpg');
    end
    