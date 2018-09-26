function [imgR,imgG,imgB]=ColorSeparate(img)

    imgR(:,:)=img(:,:,1);
    imgG(:,:)=img(:,:,2);
    imgB(:,:)=img(:,:,3);
    
end