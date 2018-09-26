% -------------------------------------------------------------------------
%% 第一步：图像读取(调用readDir.m函数)
[files, exposures] = readDir('pics/');
tmp = imread(files{1});         %读取不同曝光度图像的图像集
[X,Y,~]=size(tmp);
numPixels=X*Y;                  %像素点个数
numExposures = size(files,2);   %不同曝光度图像的数量，本次项目中使用了6张不同曝光度的图像

%% 第二步：计算权重函数(weighting function)(调用weight.m函数)
weights=zeros(256);
zmin=1;zmax=256;
for z=1:256
    if z <= 0.5 * (zmin + zmax)
        w = ((z - zmin) + 1); %+1是为了防止权重函数取值为0，
    else
        w = ((zmax - z) + 1);
    end
    weights(z) = w;
end

%% 第三步：从6张图像中采样204个点并记入一个矩阵中(调用makeImageMatrix.m函数)
[zR, zG, zB] = makeImageMatrix(files, numPixels);

%% 第四步：建立曝光度矩阵，记录曝光时间的自然对数
[zE,zN]=size(zR);   %在本题中采样点个数zE=204，图像个数zN=6
B = zeros(zE*zN, numExposures);
for i = 1:numExposures
    B(:,i) = log(exposures(i));
end

%% 第五步：求解特征函数g(调用gsolve.m函数)
l = 50;
gR=gsolve(zR, B, l, weights);
gG=gsolve(zG, B, l, weights);
gB=gsolve(zB, B, l, weights);

%% 第六步：运用HDR算法获得“光亮图谱(radiance map)”(调用hdr.m函数)
hdrMap = hdr(files, gR, gG, gB, weights, B);
luminance = 0.2125 * hdrMap(:,:,1) + 0.7154 * hdrMap(:,:,2) + 0.0721 * hdrMap(:,:,3);

%% 第七步：获得结果(调用reinhardGlobal.m函数，参考了柏林工业大学Mathias Eitz教授的代码，在参考文献中加以注明)
% apply Reinhard local tonemapping operator to the hdr radiance map
%fprintf('Tonemapping - Reinhard local operator\n');
saturation = 0.6;
eps = 0.05;
phi = 8;
[ldrLocal, luminanceLocal, v, v1Final, sm ]  = reinhardLocal(hdrMap, saturation, eps, phi);

%% 保存
imwrite(ldrLocal,'result.jpg');
fprintf('Finished!\n');