function img2 = Fog2_HSI(imgb)
    %% ͼƬ��ȡ����ͨ����ȡ
    [x,y,~]=size(imgb);[height,width,~]=size(imgb); 
    rgb=im2double(imgb);
    r=rgb(:,:,1);
    g=rgb(:,:,2);
    b=rgb(:,:,3);
    
    %% RGB->HSI
    %��H
    deno=sqrt((r-g).^2+(r-b).*(g-b));
    nomi=0.5*((r-g)+(r-b));
    theta=acos(nomi./deno);
    H=theta;
    H(b>g)=2*pi-H(b>g);
    %��S
    num=min(min(r,g),b);
    deno=r+g+b;
    S=1-3.*num./deno;
    for i=1:x
        for j=1:y
            if S(i,j)==0
                H(i,j)=0;
            end
        end
    end
    %��I
    I=(r+g+b)/3;
    
    %% ��Iͨ������ֱ��ͼ���⴦��
    %��һ����ͳ�Ƹ��Ҷȼ�������Ŀ����¼��PixelN����
    PixelN=zeros(1,256);
    for i=1:height
        for j=1:width
            I(i,j)=round(I(i,j)*255);
            PixelN((I(i,j)+1))=PixelN((I(i,j)+1))+1;
        end
    end
    %�ڶ�����������Ҷȼ��ֲ��ܶȲ���¼��PixelP����
    PixelP=zeros(1,256);
    for i=1:256
        PixelP(i)=PixelN(i)/(height*width);
    end
    %������������Ҷȼ��ۼƷֲ�����¼��PixelAccu����
    PixelAccu=zeros(1,256);
    for i=1:256
        if i==1
            PixelAccu(i)=PixelP(i);
        else
            PixelAccu(i)=PixelAccu(i-1)+PixelP(i);
        end
    end
    %���Ĳ������ۼƷֲ�ת��Ϊ0~255�ĻҶȼ�����¼��PixelDisc����
    PixelDisc=zeros(1,256);
    PixelDisc=uint8(256.*PixelAccu-0.5);
    %���岽������ԭ�Ҷ�ֵӳ��洢����ͼ����
    for i=1:height
        for j=1:width
            I(i,j)=PixelDisc(I(i,j));
            S(i,j)=3*S(i,j);
        end
    end
    
    %% HSI->RGB
    
    R=zeros(x,y);
    G=zeros(x,y);
    B=zeros(x,y);

    for i=1:x
        for j=1:y
            if ((0<=H(i,j))&&(H(i,j)<2*pi/3))
                B(i,j)=I(i,j).*(1-S(i,j));
                R(i,j)=I(i,j).*(1+S(i,j).*cos(H(i,j))./cos(pi/3-H(i,j)));
                G(i,j)=3*I(i,j)-(R(i,j)+B(i,j));
            else
                if (2*pi/3<=H(i,j))&&(H(i,j)<4*pi/3)
                    R(i,j)=I(i,j).*(1-S(i,j));
                    G(i,j)=I(i,j).*(1+S(i,j).*cos(H(i,j)-2*pi/3)./cos(pi-H(i,j)));
                    B(i,j)=3*I(i,j)-(R(i,j)+G(i,j));
                else
                    if (4*pi/3<=H(i,j))&&(H(i,j)<=2*pi)
                        G(i,j)=I(i,j).*(1-S(i,j));
                        B(i,j)=I(i,j).*(1+S(i,j).*cos(H(i,j)-4*pi/3)./cos(5*pi/3-H(i,j)));
                        R(i,j)=3*I(i,j)-(G(i,j)+B(i,j));
                    end
                end
            end
        end
    end
    
    img2=uint8(cat(3,R,G,B));
    