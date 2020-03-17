imageArray = cell(1,100);  
myFolder = 'C:\Users\ahmedelsayed\Desktop\year3\term2\ASS2_PR\MyPic';
     if ~isdir(myFolder)
        errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
        uiwait(warndlg(errorMessage));
        return;
     end
     filePattern = fullfile(myFolder, '*.bmp');
     jpegFiles = dir(filePattern);
     for k = 1:length(jpegFiles)
     baseFileName = jpegFiles(k).name;
     fullFileName = fullfile(myFolder, baseFileName);
     fprintf(1, 'Now reading %s\n', fullFileName);
     x = imread(fullFileName);
     imageArray{k} = ~x;
  end
save images.mat imageArray;