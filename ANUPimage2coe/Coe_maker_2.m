% Read the .coe file
inputFile = 'image.coe';
fileID = fopen(inputFile, 'r');
data = textscan(fileID, '%s', 'Delimiter', '\n');
fclose(fileID);

% Extract binary data lines
dataLines = data{1};
binaryLines = dataLines(3:end); % Skip header lines

% Remove trailing semicolons and commas
binaryLines = strrep(binaryLines, ';', '');
binaryLines = strrep(binaryLines, ',', '');

% Convert binary strings to decimal values
COLOR_bin = bin2dec(binaryLines);

% Extract RGB components
R = bitshift(COLOR_bin, -8);       % Upper 4 bits
G = bitand(bitshift(COLOR_bin, -4), 15); % Middle 4 bits
B = bitand(COLOR_bin, 15);         % Lower 4 bits

% Scale back to 8-bit range
R = uint8(R * 255 / 15);
G = uint8(G * 255 / 15);
B = uint8(B * 255 / 15);

% Reconstruct the image
reconstructedImage = cat(3, R, G, B);

% Display the reconstructed image
imshow(reconstructedImage);
title('Reconstructed Image');
