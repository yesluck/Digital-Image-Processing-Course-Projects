function img4 = Fog4_Adjust(img)

    [X,Y,~]=size(img);
    
    img4=zeros(X,Y,3);
    for i=1:3
        imgl(:,:)=img(:,:,i);
        K = imadjust(imgl,[0.3 0.95],[0 0.8]);	%��ָ���Ҷȷ�Χ����ͼ����ǿ����
        img4(:,:,i)=K(:,:);
    end
end