function img5 = Fog5_GuidedFilter(img)

    img=double(img)/255; %转换为双精度便于计算

    p = img; %引导图像 一般直接取输入的图像

    r = 96; %窗口大小
    eps = 0.1^2;

    q = zeros(size(img)); %输出图像 这里提前预留存储空间 加快运行速度

    q(:, :, 1) = guidedfilter(img(:, :, 1), p(:, :, 1), r, eps); %对第一个通道进行引导滤波
    q(:, :, 2) = guidedfilter(img(:, :, 2), p(:, :, 2), r, eps); %对第二个通道进行引导滤波
    q(:, :, 3) = guidedfilter(img(:, :, 3), p(:, :, 3), r, eps); %对第三个通道进行引导滤波
    img5 = (img - q) * 5 + q;
    
end