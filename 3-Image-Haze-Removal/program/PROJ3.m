function PROJ3

    filename1='fog';
    filename2='cs';
    filename3='tam';
    filename4='gulangyu';
    filename5='xiamen';
    filename6='ssh';
    filename7='ndmz';
    filename8='lj';
    filename9='exm';
    filename10='xtl';

    img1=imread([filename1 '.jpg']);
    img2=imread([filename2 '.jpg']);
    img3=imread([filename3 '.jpg']);
    img4=imread([filename4 '.jpg']);
    img5=imread([filename5 '.jpg']);
    img6=imread([filename6 '.jpg']);
    img7=imread([filename7 '.jpg']);
    img8=imread([filename8 '.jpg']);
    img9=imread([filename9 '.jpg']);
    img10=imread([filename10 '.jpg']);
    
    Process(img1,filename1);
    Process(img2,filename2);
    Process(img3,filename3);
    Process(img4,filename4);
    Process(img5,filename5);
    Process(img6,filename6);
    Process(img7,filename7);
    Process(img8,filename8);
    Process(img9,filename9);
    Process(img10,filename10);