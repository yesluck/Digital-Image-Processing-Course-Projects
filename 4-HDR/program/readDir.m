function [filenames, exposures] = readDir(dirName)
    
    %读取文件并储存信息
    filelist = dir(dirName);
    for i = 3:size(filelist,1)
        filenames{i-2} = strcat(dirName,filelist(i).name);
    end

    %根据文件名获取曝光时间信息
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

    % 将图片信息根据曝光时间降序排列
    [exposures indices] = sort(exposures);
    filenames = filenames(indices);
    exposures = exposures(end:-1:1);
    filenames = filenames(end:-1:1);