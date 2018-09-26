function img6 = Fog6_RemoveHe(img)

    [h,w,~]=size(img);
    
    w0=0.7; 

    dark_I=zeros(h,w);
    for i=1:h                 
        for j=1:w
            dark_I(i,j)=min(img(i,j,:));%取每个点的像素为RGB分量中最低的那个通道的值
        end
    end

    Max_dark_channel=double(max(max(dark_I)));
    dark_channel=double(dark_I);
    t=1-w0*(dark_channel/Max_dark_channel);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I1=double(img);
    img6(:,:,1) = uint8((I1(:,:,1) - (1-t)*Max_dark_channel)./t);

    img6(:,:,2) = uint8((I1(:,:,2) - (1-t)*Max_dark_channel)./t);

    img6(:,:,3) =uint8((I1(:,:,3) - (1-t)*Max_dark_channel)./t);
end
