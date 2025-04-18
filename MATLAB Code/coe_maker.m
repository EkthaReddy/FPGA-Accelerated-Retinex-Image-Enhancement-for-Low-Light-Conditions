% MATLAB code to generate a .coe file from an RGB image with 12-bit data in binary

% Read the input image (RGB)
imagePath = 'kids.png'; % Replace with your image file
img = imread(imagePath);

% Check if the image is RGB
if size(img, 3) ~= 3
    error('The input image must be an RGB image.');
end

% Extract the R, G, B channels
R = img(:, :, 1); % Red channel
G = img(:, :, 2); % Green channel
B = img(:, :, 3); % Blue channel

% Normalize each channel to 4 bits (values between 0 and 15)
R4 = bitshift(uint16(R), -4); % Reduce to 4 bits
G4 = bitshift(uint16(G), -4); % Reduce to 4 bits
B4 = bitshift(uint16(B), -4); % Reduce to 4 bits

% Combine the channels into a 12-bit value (R[11:8], B[7:4], G[3:0])
img12 = bitshift(R4, 8) + bitshift(B4, 4) + G4;

% Open the .coe file for writing
outputFile = 'image_data_rgb_binary.coe';
fileID = fopen(outputFile, 'w');

% Write COE file header
fprintf(fileID, 'memory_initialization_radix=2;\n');
fprintf(fileID, 'memory_initialization_vector=\n');

% Write pixel data to the COE file
[row, col, ~] = size(img);
for i = 1:row
    for j = 1:col
        % Convert each 12-bit value to binary string
        binaryValue = dec2bin(img12(i, j), 12); % 12-bit binary string
        fprintf(fileID, '%s', binaryValue); % Write the binary string
        if i == row && j == col
            fprintf(fileID, ';\n'); % End of file
        else
            fprintf(fileID, ',\n'); % Separate with a comma
        end
    end
end

% Close the file
fclose(fileID);

disp(['Binary COE file generated: ', outputFile]);
