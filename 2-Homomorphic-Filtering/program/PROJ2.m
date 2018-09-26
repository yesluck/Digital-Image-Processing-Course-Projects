function PROJ2
    
    img1=imread('000001.tif');
    img2=imread('000002.tif');
    img3=imread('000003.tif');
    img4=imread('000004.tif');
    img5=imread('000005.tif');
    img6=imread('000006.tif');
    img7=imread('000007.tif');
    img8=imread('000008.tif');
    img9=imread('000009.tif');
    img10=imread('000010.tif');
    
    Process(img1,1,1,4);
    Process(img2,2,1,6);
    Process(img3,3,1,7);
    Process(img4,4,0,6);
    Process(img5,5,1,6);
    Process(img6,6,1,7);
    Process(img7,7,1,5);
    Process(img8,8,1,6);
    Process(img9,9,1,6);
    Process(img10,10,1,6);
    
end