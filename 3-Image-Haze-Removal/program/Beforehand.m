function R = Beforehand(img)
    %% 图片读取与三通道提取
    imgd=double(img);	%转换为双精度
    [x,y,~]=size(imgd);	%读取尺寸
    R=imgd(:,:,1);      %分别提取三通道值
    G=imgd(:,:,2); 
    B=imgd(:,:,3);
    
    %% 计算三通道极值与极差
    Rmax=max(max(R));   %分别求取三个通道的最大值
    Gmax=max(max(G));
    Bmax=max(max(B));
    Rmin=min(min(R));	%分别求取三个通道的最小值
    Gmin=min(min(G));
    Bmin=min(min(B));
    Rr=Rmax-Rmin;       %分别求取三个通道的极差
    Gr=Gmax-Gmin;
    Br=Bmax-Bmin;
    
    %% 计算明暗度
    Retinex1=RetinexCalculate(R, 10);
    Retinex2=RetinexCalculate(G, 10);
    Retinex3=RetinexCalculate(B, 10);
    
    %% 对比度拉伸得到新图像
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