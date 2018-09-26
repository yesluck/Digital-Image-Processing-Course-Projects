function Process(img,num,type,radiuM)
    
    [imgoR,imgoG,imgoB]=ColorSeparate(img);

    [img1,imgR,imgG,imgB]=GBAdjustion(img);
    
    edge=CannyEdge(img1,type);
    
    imgb=Background(imgoR,imgoG,imgoB,edge);
    imwrite(imgb,[int2str(num),'background.jpg']);
    
    imgs=Simple(imgoR,imgoG,imgoB,edge);
    imwrite(imgs,[int2str(num),'simple.jpg']);
    
    imgc=Color(imgoR,imgoG,imgoB,edge);
    imwrite(imgc,[int2str(num),'color.jpg']);
        
    imgh=HomoRGB(imgoR,imgoG,imgoB,edge,1.35,0.5);
    imwrite(uint8(imgh),[int2str(num),'homo.jpg']);
    
    [imgr,imgrb]=RidBGRFilter(imgR,imgG,imgB,edge);
    imwrite(imgr,[int2str(num),'rid.jpg']);
    imwrite(imgrb,[int2str(num),'ridbw.jpg']);

    imga=Advanced(imgh,edge,radiuM);
    imwrite(uint8(imga),[int2str(num),'advanced.jpg']);
    
end