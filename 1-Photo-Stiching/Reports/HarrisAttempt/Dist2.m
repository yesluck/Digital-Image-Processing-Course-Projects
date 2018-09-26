%求取两点间欧氏距离
function d2 = Dist2(a,b)

    [heighta,widtha]=size(a);
    [heightb,widthb]=size(b);
     
    d2=(ones(heightb,1)*sum((a.^2)',1))'+ones(heighta,1)*sum((b.^2)',1)-2.*(a*(b'));

    if any(any(d2<0))
        d2(d2<0) = 0;
    end
    
end

