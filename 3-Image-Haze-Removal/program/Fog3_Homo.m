function img3 = Fog3_Homo(imgb)

    rgb=im2double(imgb);
    [X,Y,~]=size(rgb);

    %% 对三通道依次进行滤波
    img3=zeros(X,Y,3);
	for i=1:3
        S=double(rgb(:,:,i));
        [M,N]=size(S);
        
        FS=fft2(S);
        
        %% 设置滤波器
        D0=250;
        
        F=zeros(M,N);
        for k=1:M
            for j=1:N
                F(k,j)=exp(-((k-M/2)^2+(j-N/2)^2)/(2*D0^2));
           end
        end
        FF=fft2(double(F));
        
        FL=FS.*FF;
        L=double(ifft2(FL));
        
        G=log(S+1)-log(L+1);
        G=exp(G);

        G=(G-min(min(G)))/(max(max(G))-min(min(G)));
        G=adapthisteq(G);
        img3(:,:,i)=G;
	end
end