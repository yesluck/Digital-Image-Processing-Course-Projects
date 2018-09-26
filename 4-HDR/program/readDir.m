function [filenames, exposures] = readDir(dirName)
    
    %��ȡ�ļ���������Ϣ
    filelist = dir(dirName);
    for i = 3:size(filelist,1)
        filenames{i-2} = strcat(dirName,filelist(i).name);
    end

    %�����ļ�����ȡ�ع�ʱ����Ϣ
    i = 1; 
    for filename = filenames
        filename = filename{1};
        [s f] = regexp(filename, '(\d+)');
        nominator = filename(s(1):f(1));
        denominator = filename(s(2):f(2));
        exposure = str2num(nominator) / str2num(denominator);
        exposures(i) = exposure;
        i = i + 1;
    end

    % ��ͼƬ��Ϣ�����ع�ʱ�併������
    [exposures indices] = sort(exposures);
    filenames = filenames(indices);
    exposures = exposures(end:-1:1);
    filenames = filenames(end:-1:1);