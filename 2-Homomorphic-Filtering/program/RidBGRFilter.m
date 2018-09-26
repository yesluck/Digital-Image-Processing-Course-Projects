function [imgf,imgfb] = RidBGRFilter(imgR,imgG,imgB,E)
    
    bg32=blkproc(imgR,[3,3],'min(x(:))');
    bg256=imresize(bg32,[584,890],'bicubic');
    imgrR=im2double(imgR-bg256);

    bg32=blkproc(imgG,[4,4],'min(x(:))');
    bg256=imresize(bg32,[584,890],'bicubic');
    imgrG=im2double(imgG-bg256);
    
    bg32=blkproc(imgB,[5,5],'min(x(:))');
    bg256=imresize(bg32,[584,890],'bicubic');
    imgrB=im2double(imgB-bg256);

    imgfR=imgrR.*E;
    imgfG=imgrG.*E;
    imgfB=imgrB.*E;
    
    imgf(:,:,1)=imgfR(:,:);
    imgf(:,:,2)=imgfG(:,:);
    imgf(:,:,3)=imgfB(:,:);
    
    imgfb=im2bw(imgf,0.3);
      
end