function img5 = Fog5_GuidedFilter(img)

    img=double(img)/255; %ת��Ϊ˫���ȱ��ڼ���

    p = img; %����ͼ�� һ��ֱ��ȡ�����ͼ��

    r = 96; %���ڴ�С
    eps = 0.1^2;

    q = zeros(size(img)); %���ͼ�� ������ǰԤ���洢�ռ� �ӿ������ٶ�

    q(:, :, 1) = guidedfilter(img(:, :, 1), p(:, :, 1), r, eps); %�Ե�һ��ͨ�����������˲�
    q(:, :, 2) = guidedfilter(img(:, :, 2), p(:, :, 2), r, eps); %�Եڶ���ͨ�����������˲�
    q(:, :, 3) = guidedfilter(img(:, :, 3), p(:, :, 3), r, eps); %�Ե�����ͨ�����������˲�
    img5 = (img - q) * 5 + q;
    
end