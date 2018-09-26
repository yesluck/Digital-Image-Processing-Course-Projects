%��ȡ�ؼ����ܱ�����������
function [dscrpt] = FeactureDiscriptor(img,x,y)

    %1����ͼ����и�˹�˲�
    gaussFilter=fspecial('gaussian',5,7);   %gauss��ͨ�˲��������ڸ�˹ģ����������������
    gauss=imfilter(img,gaussFilter,'replicate','same');

    %2��ȡ40x40���ص����򡣽������򽵲�����8x8�Ĵ�С������һ��64ά��������
    points=length(x)
    descrpt=zeros(points,64);
    for i=1:points
        xL=x(i)-20;
        xR=x(i)+19;
        yL=y(i)-20;
        yR=y(i)+19;
        patch=gauss(xL:xR,yL:yR);
        size(patch);
        patch=imresize(patch,0.2);
        dscrpt(i,:)=reshape((patch-mean2(patch))./std2(patch),1,64); 
    end
    
end