% Define the target size for the images
targetSize = [240, 320]; % [Height, Width]

% Folder containing the images (update this to your folder path)
imageFolder = 'Z:\Vijayakumar\MATLAB\Coe_Converter\ANUPimage2coe'; % Path to your folder

% Create a subfolder to save resized images
outputFolder = fullfile(imageFolder, 'resized_images');
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

% Get a list of all image files in the folder
imageFiles = dir(fullfile(imageFolder, '*.*'));
validExtensions = {'.jpg', '.jpeg', '.png', '.bmp', '.tif'};

% Loop through each file
for k = 1:length(imageFiles)
    [~, ~, ext] = fileparts(imageFiles(k).name);
    if ismember(lower(ext), validExtensions)
        % Read the image
        inputFile = fullfile(imageFolder, imageFiles(k).name);
        img = imread(inputFile);

        % Resize the image
        resizedImg = imresize(img, targetSize);
        

        % Save the resized image to the output folder
        outputFile = fullfile(outputFolder, imageFiles(k).name);
        imwrite(resizedImg, outputFile);

        % Display progress
        fprintf('Resized and saved: %s\n', imageFiles(k).name);
    end
end

disp('All images have been resized and saved.');
