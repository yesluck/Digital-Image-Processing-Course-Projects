%��ͼƬ��Ϊ�Ҷ�ͼ�����и�˹�˲�
function [gauss] = Gauss(img)

    %1����RGBͼ��ת��Ϊ�Ҷ�ͼ(Convert RGB image or colormap to grayscale)
    %  �����Ҷ�ͼת��Ϊ���Խ��о��������˫����ͼ(Convert image to double precision)
    gray=im2double(rgb2gray(img));
    
    %2����ͼ����и�˹�˲�
    gaussFilter=fspecial('gaussian',[7 7],8);   %gauss��ͨ�˲��������ڸ�˹ģ����������������
    gauss=imfilter(gray,gaussFilter);
    
end