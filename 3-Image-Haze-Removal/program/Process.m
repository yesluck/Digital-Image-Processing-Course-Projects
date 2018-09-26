function Process(img,filename)
    
    %������������ȥ��ɫɳ��ɫ
    imgb=Beforehand(img);
    imwrite(imgb,[filename 'b.jpg']);
    
    %����1:RGB��ͨ��ֱ��ͼ����
    img1=Fog1_RGB(imgb);
    imwrite(img1,[filename '1_RGB.jpg']);
    
    %����2:HSI�ռ�ֱ��ͼ����
    img2=Fog2_HSI(imgb);
    imwrite(img2,[filename '2_HSI.jpg']);
    
    %����3:̬ͬ�˲�
    img3=Fog3_Homo(imgb);
    imwrite(img3,[filename '3_Homo.jpg']);
    
    %����4���Աȶȵ���
    img4=uint8(Fog4_Adjust(imgb));
    imwrite(img4,[filename '4_Adjust.jpg']);
    
    %����5�������˲�
    img5=Fog5_GuidedFilter(imgb);
    imwrite(img5,[filename '5_GuidedFilter.jpg']);
    
    %����6����ԭɫ�����˲�
    img6=Fog6_RemoveHe(imgb);
    imwrite(img6,[filename '6_RemoveHe.jpg']);
    
end