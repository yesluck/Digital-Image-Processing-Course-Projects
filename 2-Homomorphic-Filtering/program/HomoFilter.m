function F=HomoFilter(img,h,l)

    img=double(img);

    [M,N]=size(img);
    img=img+1;
    lnimg=log(img);
    Fimg=fftshift(fft2(lnimg));
 
    Do=12;

    for u=1:M 
        for v=1:N  
            D(u,v)=sqrt((u-(M/2))^2+(v-(N/2))^2);
            H(u,v)=(h-l)*(1-exp(-D(u,v)^2/(Do^2)))+l;
        end                
    end
    hImg=Fimg.*H;
    Q=real(ifft2(fftshift(hImg)));
    Y=exp(Q);
    F=(Y-min(Y(:)))./(max(Y(:))-min(Y(:)))*255; 
    
end

