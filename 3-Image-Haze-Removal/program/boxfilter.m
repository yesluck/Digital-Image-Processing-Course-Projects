function imDst = boxfilter(imSrc, r)
    % 利用输入N = boxfilter(ones(20,30 ), r);发现 第一个数是（r+1）^2,并且
    % 往下和往右依次递增，每次增加（r+1），而且一共增加（r+1）次，然后保持不变4个脚都是这么干的
    %   BOXFILTER   O(1) time box filtering using cumulative sum
    %
    %   - Definition imDst(x, y)=sum(sum(imSrc(x-r:x+r,y-r:y+r)));
    %   - Running time independent of r; 
    %   - Equivalent to the function: colfilt(imSrc, [2*r+1, 2*r+1], 'sliding', @sum);
    %   - But much faster.

    [hei, wid] = size(imSrc); %读取尺寸
    imDst = zeros(size(imSrc)); %预留空间

    %cumulative sum over Y axis
    imCum = cumsum(imSrc, 1);%计算这个数组各行的累加值 把第一行加到第二行 然后把第二行加到第三行 依次累加 后面的1表示按行累加 2表示按列累加
    %difference over Y axis
    imDst(1:r+1, :) = imCum(1+r:2*r+1, :); %把imCum的第1+r到2*r+1行赋值给imDst的1:r+1行 对于全为1的源输入图像而言 这里的值就是1+r~2*r+1
    imDst(r+2:hei-r, :) = imCum(2*r+2:hei, :) - imCum(1:hei-2*r-1, :); %对于全为1的输入图像而言，这里的值就是全为2*r+1
    imDst(hei-r+1:hei, :) = repmat(imCum(hei, :), [r, 1]) - imCum(hei-2*r:hei-r-1, :); %将矩阵imCum(hei, :)变成[r, 1]维 
    %repmat函数将imCum的第hei行这组数据变成 r行 
    %1列的数组，其中数组的每个元素都由hei行组成。比如说这里的结果就是把一行imCum(hei, :)变成r行个imCum(hei, :)。
    %这里利用最后一行的值减去前面的值赋给imDst
    %cumulative sum over X axis
    imCum = cumsum(imDst, 2); %这里在将imDst的矩阵按列累加
    %difference over Y axis    继续按列赋值
    imDst(:, 1:r+1) = imCum(:, 1+r:2*r+1);
    imDst(:, r+2:wid-r) = imCum(:, 2*r+2:wid) - imCum(:, 1:wid-2*r-1);
    imDst(:, wid-r+1:wid) = repmat(imCum(:, wid), [1, r]) - imCum(:, wid-2*r:wid-r-1);
end

