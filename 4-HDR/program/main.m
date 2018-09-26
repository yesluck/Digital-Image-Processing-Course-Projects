% -------------------------------------------------------------------------
%% ��һ����ͼ���ȡ(����readDir.m����)
[files, exposures] = readDir('pics/');
tmp = imread(files{1});         %��ȡ��ͬ�ع��ͼ���ͼ��
[X,Y,~]=size(tmp);
numPixels=X*Y;                  %���ص����
numExposures = size(files,2);   %��ͬ�ع��ͼ���������������Ŀ��ʹ����6�Ų�ͬ�ع�ȵ�ͼ��

%% �ڶ���������Ȩ�غ���(weighting function)(����weight.m����)
weights=zeros(256);
zmin=1;zmax=256;
for z=1:256
    if z <= 0.5 * (zmin + zmax)
        w = ((z - zmin) + 1); %+1��Ϊ�˷�ֹȨ�غ���ȡֵΪ0��
    else
        w = ((zmax - z) + 1);
    end
    weights(z) = w;
end

%% ����������6��ͼ���в���204���㲢����һ��������(����makeImageMatrix.m����)
[zR, zG, zB] = makeImageMatrix(files, numPixels);

%% ���Ĳ��������ع�Ⱦ��󣬼�¼�ع�ʱ�����Ȼ����
[zE,zN]=size(zR);   %�ڱ����в��������zE=204��ͼ�����zN=6
B = zeros(zE*zN, numExposures);
for i = 1:numExposures
    B(:,i) = log(exposures(i));
end

%% ���岽�������������g(����gsolve.m����)
l = 50;
gR=gsolve(zR, B, l, weights);
gG=gsolve(zG, B, l, weights);
gB=gsolve(zB, B, l, weights);

%% ������������HDR�㷨��á�����ͼ��(radiance map)��(����hdr.m����)
hdrMap = hdr(files, gR, gG, gB, weights, B);
luminance = 0.2125 * hdrMap(:,:,1) + 0.7154 * hdrMap(:,:,2) + 0.0721 * hdrMap(:,:,3);

%% ���߲�����ý��(����reinhardGlobal.m�������ο��˰��ֹ�ҵ��ѧMathias Eitz���ڵĴ��룬�ڲο������м���ע��)
% apply Reinhard local tonemapping operator to the hdr radiance map
%fprintf('Tonemapping - Reinhard local operator\n');
saturation = 0.6;
eps = 0.05;
phi = 8;
[ldrLocal, luminanceLocal, v, v1Final, sm ]  = reinhardLocal(hdrMap, saturation, eps, phi);

%% ����
imwrite(ldrLocal,'result.jpg');
fprintf('Finished!\n');