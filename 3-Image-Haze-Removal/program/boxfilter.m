function imDst = boxfilter(imSrc, r)
    % ��������N = boxfilter(ones(20,30 ), r);���� ��һ�����ǣ�r+1��^2,����
    % ���º��������ε�����ÿ�����ӣ�r+1��������һ�����ӣ�r+1���Σ�Ȼ�󱣳ֲ���4���Ŷ�����ô�ɵ�
    %   BOXFILTER   O(1) time box filtering using cumulative sum
    %
    %   - Definition imDst(x, y)=sum(sum(imSrc(x-r:x+r,y-r:y+r)));
    %   - Running time independent of r; 
    %   - Equivalent to the function: colfilt(imSrc, [2*r+1, 2*r+1], 'sliding', @sum);
    %   - But much faster.

    [hei, wid] = size(imSrc); %��ȡ�ߴ�
    imDst = zeros(size(imSrc)); %Ԥ���ռ�

    %cumulative sum over Y axis
    imCum = cumsum(imSrc, 1);%�������������е��ۼ�ֵ �ѵ�һ�мӵ��ڶ��� Ȼ��ѵڶ��мӵ������� �����ۼ� �����1��ʾ�����ۼ� 2��ʾ�����ۼ�
    %difference over Y axis
    imDst(1:r+1, :) = imCum(1+r:2*r+1, :); %��imCum�ĵ�1+r��2*r+1�и�ֵ��imDst��1:r+1�� ����ȫΪ1��Դ����ͼ����� �����ֵ����1+r~2*r+1
    imDst(r+2:hei-r, :) = imCum(2*r+2:hei, :) - imCum(1:hei-2*r-1, :); %����ȫΪ1������ͼ����ԣ������ֵ����ȫΪ2*r+1
    imDst(hei-r+1:hei, :) = repmat(imCum(hei, :), [r, 1]) - imCum(hei-2*r:hei-r-1, :); %������imCum(hei, :)���[r, 1]ά 
    %repmat������imCum�ĵ�hei���������ݱ�� r�� 
    %1�е����飬���������ÿ��Ԫ�ض���hei����ɡ�����˵����Ľ�����ǰ�һ��imCum(hei, :)���r�и�imCum(hei, :)��
    %�����������һ�е�ֵ��ȥǰ���ֵ����imDst
    %cumulative sum over X axis
    imCum = cumsum(imDst, 2); %�����ڽ�imDst�ľ������ۼ�
    %difference over Y axis    �������и�ֵ
    imDst(:, 1:r+1) = imCum(:, 1+r:2*r+1);
    imDst(:, r+2:wid-r) = imCum(:, 2*r+2:wid) - imCum(:, 1:wid-2*r-1);
    imDst(:, wid-r+1:wid) = repmat(imCum(:, wid), [1, r]) - imCum(:, wid-2*r:wid-r-1);
end

