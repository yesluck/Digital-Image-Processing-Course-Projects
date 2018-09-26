function g=gsolve(Z,B,l,w)
    n = 256;
    [ZX,ZY]=size(Z);
    A = zeros(ZX*ZY+n+1,n+ZX);
    b = zeros(ZX*ZY+n+1);

    %% Include the data-fitting equations
    k = 1;
    for i=1:ZX
        for j=1:ZY
            wij = w(Z(i,j)+1);
            A(k,Z(i,j)+1) = wij;
            A(k,n+i) = -wij;
            b(k,1) = wij * B(i,j);
            k=k+1;
        end
    end

    %% Fix the curve by setting its middle value to 0
    A(k,129) = 1;
    k=k+1;
    
    %% Include the smoothness equations
    for i=1:n-2
        A(k,i)=l*w(i+1);
        A(k,i+1)=-2*l*w(i+1);
        A(k,i+2)=l*w(i+1);
        k=k+1;
    end
    
    %% Solve the system using SVD
    x = A\b;
    g = x(1:n);