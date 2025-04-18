% Read the image
I = imread('onion.png');
imshow(I);

% Extract RED, GREEN, and BLUE components
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

% Convert to double for normalization
R = double(R);
G = double(G);
B = double(B);

% Scale the values to fit within 4 bits (0–15)
R = round(R * 15 / 255); % Normalize to range 0–15
G = round(G * 15 / 255); % Normalize to range 0–15
B = round(B * 15 / 255); % Normalize to range 0–15

% Ensure values are in the range of 0–15
R = min(max(R, 0), 15);
G = min(max(G, 0), 15);
B = min(max(B, 0), 15);

% Convert to hexadecimal (1-digit hex for 4 bits)
R_hex = dec2hex(R, 1); % Convert to 1-digit hexadecimal
G_hex = dec2hex(G, 1);
B_hex = dec2hex(B, 1);

% Combine R, G, B hex values into a single 12-bit binary value
COLOR_hex = strcat(R_hex, G_hex, B_hex);

% Convert the combined hex to binary representation
COLOR_bin = cellstr(dec2bin(hex2dec(COLOR_hex), 12)); % 12-bit binary strings

% Write to file in binary format
outputFile = 'image.coe';
fileID = fopen(outputFile, 'w');
fprintf(fileID, 'memory_initialization_radix=2;\n');
fprintf(fileID, 'memory_initialization_vector=\n');

for i = 1:numel(COLOR_bin)-1
    fprintf(fileID, '%s,\n', COLOR_bin{i});
end
fprintf(fileID, '%s,', COLOR_bin{end});
fclose(fileID);

disp('File written successfully.');
