function imgh = Advanced(imgh,edge,radiuM)

    imghR(:,:)=imgh(:,:,1);
    imghG(:,:)=imgh(:,:,2);
    imghB(:,:)=imgh(:,:,3);
    
    [x,y,~]=size(imgh);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %��һ�δ���������ɵĺڰ�ͼ��0.25��ǳɫ����
    
    imghb=im2bw(uint8(imgh),0.25); 
    se = strel('disk',4);          %���þ��ν����������ͣ�ʹ��Ե����
    imghb=imdilate(imghb,se);
    se = strel('disk',6);                   %����Բ�̽�����������
    imghb=imerode(imghb,se);
    se = strel('disk',6);                   %����Բ�̽�����������
    imghb=imerode(imghb,se);
    se = strel('disk',3);          %���þ��ν����������ͣ�ʹ��Ե����
    imghbe=imdilate(imghb,se);
    
    for i=1:x
        for j=1:y
            if(imghbe(i,j)==1 && j>150 && i<x-50 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50 && imgh(i,j-150,2)<100 &&imgh(i,j-150,3)<100)
                    imghR(i,j)=imgh(i,j-150,1);
                    imghG(i,j)=imgh(i,j-150,2);
                    imghB(i,j)=imgh(i,j-150,3);
                else
                    imghR(i,j)=imgh(i+50,j-150,1);
                    imghG(i,j)=imgh(i+50,j-150,2);
                    imghB(i,j)=imgh(i+50,j-150,3);
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�ڶ��δ������ж���̬ͬ�˲�
    
    imgh=HomoRGB(imghR,imghG,imghB,edge,0.8,0.6);  
    for i=1:x
        for j=1:y
            imgh(i,j,1)=imgh(i,j,1)*1.25/1.1/1.2;
            imgh(i,j,2)=imgh(i,j,2)*1.15/1.1/1.2;
            imgh(i,j,3)=imgh(i,j,3)*1.3/1.1/1.2;
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�����δ���������ɵĻҶ���65~85��Χ�ĵ�ǳɫ����
    
    imghg=rgb2gray(uint8(imgh));
    
    imghm=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imghg(i,j)>65 && imghg(i,j)<85)
                imghm(i,j)=1;
            end
        end
    end
    
    se = strel('disk',1);                   %����Բ�̽�����������
    imghm=imerode(imghm,se);
    se = strel('disk',radiuM);          %���þ��ν����������ͣ�ʹ��Ե����
    imghme=imdilate(imghm,se);
    
    for i=1:x
        for j=1:y
            if(imghme(i,j)==1 && j>150 && i<x-50 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50 && imgh(i,j-150,2)<100 &&imgh(i,j-150,3)<100)
                    imghR(i,j)=imgh(i,j-150,1)*0.78;
                    imghG(i,j)=imgh(i,j-150,2)*0.78;
                    imghB(i,j)=imgh(i,j-150,3)*0.78;
                else
                    imghR(i,j)=imgh(i+50,j-150,1)*0.78;
                    imghG(i,j)=imgh(i+50,j-150,2)*0.78;
                    imghB(i,j)=imgh(i+50,j-150,3)*0.78;
                end
            end
        end
    end
    
    imgh(:,:,1)=imghR(:,:);
    imgh(:,:,2)=imghG(:,:);
    imgh(:,:,3)=imghB(:,:);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %���Ĵδ���������ɵĻҶ���105~117��Χ�ĵ�ǳɫ����
    
    imghm=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imghg(i,j)>105 && imghg(i,j)<117)
                imghm(i,j)=1;
            end
        end
    end
    
    se = strel('disk',1);                   %����Բ�̽�����������
    imghm=imerode(imghm,se);
    se = strel('disk',5);          %���þ��ν����������ͣ�ʹ��Ե����
    imghme=imdilate(imghm,se);
    
    for i=1:x
        for j=1:y
            if(imghme(i,j)==1 && j>150 && i<x-50 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50 && imgh(i,j-150,2)<100 &&imgh(i,j-150,3)<100)
                    imghR(i,j)=imgh(i,j-150,1);
                    imghG(i,j)=imgh(i,j-150,2);
                    imghB(i,j)=imgh(i,j-150,3);
                else
                    imghR(i,j)=imgh(i+10,j-150,1);
                    imghG(i,j)=imgh(i+10,j-150,2);
                    imghB(i,j)=imgh(i+10,j-150,3);
                end
            end
        end
    end
    
    imgh(:,:,1)=imghR(:,:);
    imgh(:,:,2)=imghG(:,:);
    imgh(:,:,3)=imghB(:,:);
    
    for i=1:x
        for j=1:y
            imgh(i,j,1)=imgh(i,j,1)*1.4;
            imgh(i,j,2)=imgh(i,j,2)*1.5;
            imgh(i,j,3)=imgh(i,j,3)*1.4;
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %����δ���������ɵĻҶ���162~173��Χ�ĵ�ǳɫ����
    
    imgg=rgb2gray(uint8(imgh));
    
    imgz=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imgg(i,j)>162 && imgg(i,j)<173)
                imgz(i,j)=1;
            end
        end
    end
    
    se = strel('rectangle',[2 2]);          %���þ��ν����������ͣ�ʹ��Ե����
    imgz = imdilate(imgz,se);
    
    se = strel('disk',2);                   %����Բ�̽�����������
    imgz=imerode(imgz,se);
    
    se = strel('rectangle',[5 5]);          %���þ��ν����������ͣ�ʹ��Ե����
    imgz = imdilate(imgz,se);
    
    for i=1:x
        for j=1:y
            if(imgz(i,j)==1 && j>150 && i<x-50 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50/256 && imgh(i,j-150,2)<100/256 && imgh(i,j-150,3)<100/256)
                    imgh(i,j,1)=imgh(i,j-150,1);
                    imgh(i,j,2)=imgh(i,j-150,2);
                    imgh(i,j,3)=imgh(i,j-150,3);
                else
                    imgh(i,j,1)=imgh(i+50,j-150,1);
                    imgh(i,j,2)=imgh(i+50,j-150,2);
                    imgh(i,j,3)=imgh(i+50,j-150,3);
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�����δ���������ɵĻҶ���75~140��Χ�ĵ�ǳɫ����
    
    imgg=rgb2gray(uint8(imgh));
    
    imgz=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imgg(i,j)>75 && imgg(i,j)<140)
                imgz(i,j)=1;
            end
        end
    end
    
    se = strel('disk',2);                   %����Բ�̽�����������
    imgz=imerode(imgz,se);
    
    se = strel('disk',10);          %���þ��ν����������ͣ�ʹ��Ե����
    imgz = imdilate(imgz,se);
    
    for i=1:x
        for j=1:y
            if(imgz(i,j)==1 && j>150 && i<x-75 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50/256 && imgh(i,j-150,2)<100/256 && imgh(i,j-150,3)<100/256)
                    imgh(i,j,1)=imgh(i,j-150,1);
                    imgh(i,j,2)=imgh(i,j-150,2);
                    imgh(i,j,3)=imgh(i,j-150,3);
                else
                    imgh(i,j,1)=imgh(i+75,j-150,1);
                    imgh(i,j,2)=imgh(i+75,j-150,2);
                    imgh(i,j,3)=imgh(i+75,j-150,3);
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %���ߴδ���������ɵĻҶ���210���Ϸ�Χ�ĵ�ǳɫ����
    
    imgg=rgb2gray(uint8(imgh));
    
    imgz=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imgg(i,j)>210)
                imgz(i,j)=1;
            end
        end
    end
    for i=1:x
        for j=1:y
            if(imgz(i,j)==1 && j>150 && i<x-75 && j>2*y/3 && imgh(i,j+10,1)>0 && imgh(i,j+10,2)>0 &&imgh(i,j+10,3)>0)
                if(imgh(i,j-150,1)<50/256 && imgh(i,j-150,2)<100/256 && imgh(i,j-150,3)<100/256)
                    imgh(i,j,1)=imgh(i,j-150,1);
                    imgh(i,j,2)=imgh(i,j-150,2);
                    imgh(i,j,3)=imgh(i,j-150,3);
                else
                    imgh(i,j,1)=imgh(i+75,j-150,1);
                    imgh(i,j,2)=imgh(i+75,j-150,2);
                    imgh(i,j,3)=imgh(i+75,j-150,3);
                end
            end
        end
    end
    
end