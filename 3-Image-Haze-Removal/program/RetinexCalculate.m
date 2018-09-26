function Retinex = RetinexCalculate(L, nIterations)   %��������

    global RR OP NP Maximum     %ȫ�ֱ���
    
    RR = L;
    Maximum = max(L(:));        %�����ֵ                           
    [nrows, ncols] = size(L);

    shift = 2^(fix(log2(min(nrows, ncols)))-1);        % fix ���㿿£ȡ�� log2����2Ϊ�׵Ķ���
    OP = Maximum*ones(nrows, ncols);                    

    while (abs(shift) >= 1)
       for i = 1:nIterations
          CompareWith(0, shift);                     % ѡ��һ�����н��в���   ����ѡ������
          CompareWith(shift, 0);                     % ѡ��һ�����н��в���   ����ѡ������
       end
       shift = -shift/2;                               
    end
    
    Retinex = NP;
end