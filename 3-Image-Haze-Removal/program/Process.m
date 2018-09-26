function Process(img,filename)
    
    %初步操作：除去霾色沙尘色
    imgb=Beforehand(img);
    imwrite(imgb,[filename 'b.jpg']);
    
    %方法1:RGB三通道直方图均衡
    img1=Fog1_RGB(imgb);
    imwrite(img1,[filename '1_RGB.jpg']);
    
    %方法2:HSI空间直方图均衡
    img2=Fog2_HSI(imgb);
    imwrite(img2,[filename '2_HSI.jpg']);
    
    %方法3:同态滤波
    img3=Fog3_Homo(imgb);
    imwrite(img3,[filename '3_Homo.jpg']);
    
    %方法4：对比度调整
    img4=uint8(Fog4_Adjust(imgb));
    imwrite(img4,[filename '4_Adjust.jpg']);
    
    %方法5：引导滤波
    img5=Fog5_GuidedFilter(imgb);
    imwrite(img5,[filename '5_GuidedFilter.jpg']);
    
    %方法6：暗原色先验滤波
    img6=Fog6_RemoveHe(imgb);
    imwrite(img6,[filename '6_RemoveHe.jpg']);
    
end