function [ red, green, blue ] = rgbSample( image, sampleIndices )
 
    R = image(:,:,1);
    red = R(sampleIndices);
    
    G = image(:,:,2);
    green = G(sampleIndices);
    
    B = image(:,:,3);
    blue = B(sampleIndices);
    
    
    
    
    
    
    
    


