function [imgA,imgR,imgG,imgB]=GBAdjustion(img)

    [x,y,~]=size(img);
    
    imgR(:,:)=img(:,:,1);
    imgG(:,:)=img(:,:,2);
    imgB(:,:)=img(:,:,3);
    
    for i=1:x
        for j=1:y
            if(imgG(i,j)+imgB(i,j)>230 && imgG(i,j)+imgB(i,j)<400)
                imgR(i,j)=255;
                imgG(i,j)=255;
                imgB(i,j)=255;
            end
        end
    end
    
    imgA(:,:,1)=imgR(:,:);
    imgA(:,:,2)=imgG(:,:);
    imgA(:,:,3)=imgB(:,:);
    
end
