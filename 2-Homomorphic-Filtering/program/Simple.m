function imgs = Simple(imgR,imgG,imgB,E)

    [x,y,~]=size(imgR);

    imgbR=im2double(imgR).*E;
    imgbG=im2double(imgG).*E;
    imgbB=im2double(imgB).*E;
    
    imgs(:,:,1)=imgbR(:,:);
    imgs(:,:,2)=imgbG(:,:);
    imgs(:,:,3)=imgbB(:,:);
    
    imgb=im2bw(imgs,0.8); 
    
    for i=1:x
        for j=1:y
            if(imgb(i,j)==1 && j>150 && i<x-75 && j>2*y/3 && imgs(i,j+10,1)>0 && imgs(i,j+10,2)>0 &&imgs(i,j+10,3)>0)
                if(imgs(i,j-150,1)<50/256 && imgs(i,j-150,2)<100/256 && imgs(i,j-150,3)<100/256)
                    imgs(i,j,1)=imgs(i,j-150,1);
                    imgs(i,j,2)=imgs(i,j-150,2);
                    imgs(i,j,3)=imgs(i,j-150,3);
                else
                    imgs(i,j,1)=imgs(i+75,j-150,1);
                    imgs(i,j,2)=imgs(i+75,j-150,2);
                    imgs(i,j,3)=imgs(i+75,j-150,3);
                end
            end
        end
    end
    
end