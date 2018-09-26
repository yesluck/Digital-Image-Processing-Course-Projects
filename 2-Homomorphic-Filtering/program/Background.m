function imgb=Background(imgR,imgG,imgB,E)

    imgbR=im2double(imgR).*~E;
    imgbG=im2double(imgG).*~E;
    imgbB=im2double(imgB).*~E;
    
    imgb(:,:,1)=imgbR(:,:);
    imgb(:,:,2)=imgbG(:,:);
    imgb(:,:,3)=imgbB(:,:);
    
end