function CompareWith(s_row, s_col)      %���������

    global RR IP OP NP Maximum
    
    IP = OP;	% ��ֵ
    if (s_row + s_col > 0)
       IP((s_row+1):end, (s_col+1):end) = OP(1:(end-s_row), 1:(end-s_col)) + ...   % �ұߵĿ��ȥ��ߵĿ� ����ֵ���ұ߿��λ��    
       RR((s_row+1):end, (s_col+1):end) - RR(1:(end-s_row), 1:(end-s_col));
    else
       IP(1:(end+s_row), 1:(end+s_col)) = OP((1-s_row):end, (1-s_col):end) + ...   
       RR(1:(end+s_row),1:(end+s_col)) - RR((1-s_row):end, (1-s_col):end);
    end
    IP(IP > Maximum) = Maximum;        % �þ������������ֵ��С�ڻ����Maximum             
    NP = (IP + OP)/2;                  % ȡƽ��ֵ,����ֵ����ip��op֮��                
    OP = NP;
end