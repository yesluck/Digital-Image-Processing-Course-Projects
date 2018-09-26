function [ ldrPic, luminanceCompressed, v, v1Final, sm ] = reinhardLocal( hdr, saturation, eps, phi )
    luminanceMap = makeLuminanceMap(hdr);

    alpha = 1 / (2*sqrt(2));
    key = 0.18;
    
    v1 = zeros(size(luminanceMap,1), size(luminanceMap,2), 8);
    v = zeros(size(luminanceMap,1), size(luminanceMap,2), 8);

    for scale=1:(8+1)
        s = 1.6 ^ (scale-1);

        sigma = alpha * s;
        
        kernelRadius = ceil(2*sigma);
        kernelSize = 2*kernelRadius+1;
        
        gaussKernelHorizontal = fspecial('gaussian', [kernelSize 1], sigma);
        v1(:,:,scale) = conv2(luminanceMap, gaussKernelHorizontal, 'same');
        gaussKernelVertical = fspecial('gaussian', [1 kernelSize], sigma);
        v1(:,:,scale) = conv2(v1(:,:,scale), gaussKernelVertical, 'same');
    end
    
    for i = 1:8    
        v(:,:,i) = abs((v1(:,:,i)) - v1(:,:,i+1)) ./ ((2^phi)*key / (s^2) + v1(:,:,i));    
    end
    
        
    sm = zeros(size(v,1), size(v,2));
    
    for i=1:size(v,1)
        for j=1:size(v,2)
            for scale=1:size(v,3)
                if v(i,j,scale) > eps
                    if (scale == 1) 
                        sm(i,j) = 1;
                    end
                    if (scale > 1)
                        sm(i,j) = scale-1;
                    end
                    
                    break;
                end
            end
        end
    end
    
    idx = find(sm == 0);
    sm(idx) = 8;
      
    v1Final = zeros(size(v,1), size(v,2));

    for x=1:size(v1,1)
        for y=1:size(v1,2)
            v1Final(x,y) = v1(x,y,sm(x,y));
        end
    end
    
    luminanceCompressed = luminanceMap ./ (1 + v1Final);

    ldrPic = zeros(size(hdr));

    for i=1:3
        ldrPic(:,:,i) = ((hdr(:,:,i) ./ luminanceMap) .^ saturation) .* luminanceCompressed;
    end

    indices = find(ldrPic > 1);
    ldrPic(indices) = 1;  