function imge=HomoRGB(imgR,imgG,imgB,E,h,l)

    imghR=HomoFilter(imgR,h,l);
    imghG=HomoFilter(imgG,h,l);
    imghB=HomoFilter(imgB,h,l);
    
    imgeR=imghR.*E;
    imgeG=imghG.*E;
    imgeB=imghB.*E;
    
    imge(:,:,1)=imgeR(:,:);
    imge(:,:,2)=imgeG(:,:);
    imge(:,:,3)=imgeB(:,:);
    
end
