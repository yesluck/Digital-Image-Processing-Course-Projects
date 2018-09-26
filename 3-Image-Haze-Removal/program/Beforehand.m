function R = Beforehand(img)
    %% ͼƬ��ȡ����ͨ����ȡ
    imgd=double(img);	%ת��Ϊ˫����
    [x,y,~]=size(imgd);	%��ȡ�ߴ�
    R=imgd(:,:,1);      %�ֱ���ȡ��ͨ��ֵ
    G=imgd(:,:,2); 
    B=imgd(:,:,3);
    
    %% ������ͨ����ֵ�뼫��
    Rmax=max(max(R));   %�ֱ���ȡ����ͨ�������ֵ
    Gmax=max(max(G));
    Bmax=max(max(B));
    Rmin=min(min(R));	%�ֱ���ȡ����ͨ������Сֵ
    Gmin=min(min(G));
    Bmin=min(min(B));
    Rr=Rmax-Rmin;       %�ֱ���ȡ����ͨ���ļ���
    Gr=Gmax-Gmin;
    Br=Bmax-Bmin;
    
    %% ����������
    Retinex1=RetinexCalculate(R, 10);
    Retinex2=RetinexCalculate(G, 10);
    Retinex3=RetinexCalculate(B, 10);
    
    %% �Աȶ�����õ���ͼ��
    f=zeros(x,y,3);
    for i=1:x
        for j=1:y
            f(i,j,1)=(Retinex1(i,j)-Rmin)*255/Rr;
            f(i,j,2)=(Retinex2(i,j)-Gmin)*255/Gr;
            f(i,j,3)=(Retinex3(i,j)-Bmin)*255/Br;
        end
    end
    R = uint8(f);
end