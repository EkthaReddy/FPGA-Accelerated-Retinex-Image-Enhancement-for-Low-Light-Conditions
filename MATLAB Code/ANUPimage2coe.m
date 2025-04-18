% Image to text conversion

% Read the image from the file
[filename, pathname] = uigetfile('*.png;*.bmp;*.tif;*.jpg;*.pgm', 'Pick an image file');
img = imread(filename);
img = imresize((img), [256 256]);
[row, col, p] = size(img);

% If the image is RGB, convert it to grayscale
if p == 3
    img = rgb2gray(img);
end

% Add noise to a specific region
rectImg = img(2:80, 2:80);
rectImg = imnoise(rectImg, 'salt & pepper', 0.02);
img(2:80, 2:80) = rectImg;

% Image transpose
imgTrans = img';

% 1D conversion
img1D = imgTrans(:);

% Normalize to 12 bits (values between 0 and 4095)
img12 = uint16(img1D); % Ensure 16-bit representation
img12 = bitshift(img12, -4); % Reduce to 12 bits (0–4095)

% Convert decimal values to binary (12 bits)
imgBin = dec2bin(img12, 12); % Binary strings with 12 bits

% Open the file to write binary data
fid = fopen('inputBinary.coe', 'wt');

% Write the COE file header
fprintf(fid, 'memory_initialization_radix=2;\n');
fprintf(fid, 'memory_initialization_vector=\n');

% Write binary values to the file
for i = 1:length(imgBin)
    fprintf(fid, '%s', imgBin(i, :)); % Write each binary string
    if i == length(imgBin)
        fprintf(fid, ';\n'); % End of the file
    else
        fprintf(fid, ',\n'); % Add a comma and newline between values
    end
end

% Close the file
fclose(fid);

disp('Binary COE file generated as inputBinary.coe');
