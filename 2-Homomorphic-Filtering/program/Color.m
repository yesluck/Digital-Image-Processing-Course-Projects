function img = Color(imgR,imgG,imgB,E)

    [x,y,~]=size(imgR);

    imgR=im2double(imgR).*E;
    imgG=im2double(imgG).*E;
    imgB=im2double(imgB).*E;
    
    img(:,:,1)=imgR(:,:);
    img(:,:,2)=imgG(:,:);
    img(:,:,3)=imgB(:,:);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %��һ�δ���������ɵĺڰ�ͼ��0.75�İ�ɫ����
    
    imgb=im2bw(img,0.75); 

    se = strel('disk',4);
    imgb=imerode(imgb,se);
    se = strel('disk',3);
    imge=imdilate(imgb,se);

    for i=1:x
        for j=1:y
            if(imge(i,j)==1 && j>150 && i<x-50 && j>2*y/3)
                if(img(i,j-150,1)<100/256 && img(i,j-150,2)<100/256 &&img(i,j-150,3)<100/256)
                    img(i,j,1)=img(i,j-150,1)*1.25;
                    img(i,j,2)=img(i,j-150,2)*1.25;
                    img(i,j,3)=img(i,j-150,3)*1.25;
                else
                    img(i,j,1)=img(i+50,j-150,1)*1.25;
                    img(i,j,2)=img(i+50,j-150,2)*1.25;
                    img(i,j,3)=img(i+50,j-150,3)*1.25;
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�ڶ��δ�����ԻҶ�ֵ��0.5~0.7�İ�ɫ����
    
    imgg=rgb2gray(img);
    imgz=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imgg(i,j)>0.5 && imgg(i,j)<0.7)
                imgz(i,j)=1;
            end
        end
    end
    
    se = strel('disk',1);                   %����Բ�̽�����������
    imgz=imerode(imgz,se);
    se = strel('disk',3);          %���þ��ν����������ͣ�ʹ��Ե����
    imge=imdilate(imgz,se);
    
    for i=1:x
        for j=1:y
            if(imge(i,j)==1 && j>150 && i<x-50 && j>2*y/3)
                if(img(i,j-150,1)<100/256 && img(i,j-150,2)<100/256 &&img(i,j-150,3)<100/256)
                    img(i,j,1)=img(i,j-150,1)*1.25;
                    img(i,j,2)=img(i,j-150,2)*1.25;
                    img(i,j,3)=img(i,j-150,3)*1.25;
                else
                    img(i,j,1)=img(i+50,j-150,1)*1.25;
                    img(i,j,2)=img(i+50,j-150,2)*1.25;
                    img(i,j,3)=img(i+50,j-150,3)*1.25;
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %���Ĵδ���������ɵĺڰ�ͼ��0.7�İ�ɫ����
    
    imgb=im2bw(img,0.7); 
    
    BW1 = edge(imgb,'canny');               %����canny��Ե���
    BW2 = bwareaopen(BW1,160,8);            %������ͨ���㷨������С����
    
    se = strel('rectangle',[4 4]);          %���þ��ν����������ͣ�ʹ��Ե����
    I = imdilate(BW2,se);  
    Icomp=imgb-I;
    se = strel('rectangle',[3 3]);          %���þ��ν����������ͣ�ʹ��Ե����
    Icomp = imdilate(Icomp,se);
    
    for i=1:x
        for j=1:y
            if(Icomp(i,j)==1 && j>150 && i<x-50 && j>2*y/3)
                if(img(i,j-150,1)<100/256 && img(i,j-150,2)<100/256 &&img(i,j-150,3)<100/256)
                    img(i,j,1)=img(i,j-150,1)*1.25;
                    img(i,j,2)=img(i,j-150,2)*1.25;
                    img(i,j,3)=img(i,j-150,3)*1.25;
                else
                    img(i,j,1)=img(i+50,j-150,1)*1.25;
                    img(i,j,2)=img(i+50,j-150,2)*1.25;
                    img(i,j,3)=img(i+50,j-150,3)*1.25;
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %���Ĵδ�����ԻҶ�ֵ��0.35~0.5�İ�ɫ����
    
    imgg=rgb2gray(img);
    imgz=zeros(x,y);
    for i=1:x
        for j=1:y
            if(imgg(i,j)>0.35 && imgg(i,j)<0.5)
                imgz(i,j)=1;
            end
        end
    end
    
    se = strel('rectangle',[2 2]);          %���þ��ν����������ͣ�ʹ��Ե����
    imgz = imdilate(imgz,se);
    
    se = strel('disk',3);                   %����Բ�̽�����������
    imgz=imerode(imgz,se);
    
    se = strel('rectangle',[4 4]);          %���þ��ν����������ͣ�ʹ��Ե����
    imgz = imdilate(imgz,se);
    
    for i=1:x
        for j=1:y
            if(imgz(i,j)==1 && j>150 && i<x-50 && j>2*y/3)
                if(img(i,j-150,1)<100/256 && img(i,j-150,2)<100/256 &&img(i,j-150,3)<100/256)
                    img(i,j,1)=img(i,j-150,1)*1.25;
                    img(i,j,2)=img(i,j-150,2)*1.25;
                    img(i,j,3)=img(i,j-150,3)*1.25;
                else
                    img(i,j,1)=img(i+50,j-150,1)*1.25;
                    img(i,j,2)=img(i+50,j-150,2)*1.25;
                    img(i,j,3)=img(i+50,j-150,3)*1.25;
                end
            end
        end
    end
    
end