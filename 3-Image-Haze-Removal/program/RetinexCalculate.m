function Retinex = RetinexCalculate(L, nIterations)   %迭代函数

    global RR OP NP Maximum     %全局变量
    
    RR = L;
    Maximum = max(L(:));        %求最大值                           
    [nrows, ncols] = size(L);

    shift = 2^(fix(log2(min(nrows, ncols)))-1);        % fix 向零靠拢取整 log2是以2为底的对数
    OP = Maximum*ones(nrows, ncols);                    

    while (abs(shift) >= 1)
       for i = 1:nIterations
          CompareWith(0, shift);                     % 选择一部分列进行操作   按列选择块相减
          CompareWith(shift, 0);                     % 选择一部分行进行操作   按行选择块相减
       end
       shift = -shift/2;                               
    end
    
    Retinex = NP;
end