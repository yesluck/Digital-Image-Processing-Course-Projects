function CompareWith(s_row, s_col)      %块操作函数

    global RR IP OP NP Maximum
    
    IP = OP;	% 初值
    if (s_row + s_col > 0)
       IP((s_row+1):end, (s_col+1):end) = OP(1:(end-s_row), 1:(end-s_col)) + ...   % 右边的块减去左边的块 并赋值给右边块的位置    
       RR((s_row+1):end, (s_col+1):end) - RR(1:(end-s_row), 1:(end-s_col));
    else
       IP(1:(end+s_row), 1:(end+s_col)) = OP((1-s_row):end, (1-s_col):end) + ...   
       RR(1:(end+s_row),1:(end+s_col)) - RR((1-s_row):end, (1-s_col):end);
    end
    IP(IP > Maximum) = Maximum;        % 让矩阵里面的所有值都小于或等于Maximum             
    NP = (IP + OP)/2;                  % 取平均值,导致值会在ip和op之间                
    OP = NP;
end