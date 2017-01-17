pkg load image

clear

function compressed_image = compress(rank, path)
    input_image = imread(path);
    input_image = rgb2gray(input_image);
    input_image = im2double(input_image);
    [U, S, V] = svd(input_image);
    S(rank + 1:end, :) = 0;
    S(:, rank + 1:end) = 0;
    compressed_image = U * S * V';
endfunction

source_image = input("Enter src image name: ", "s");
rank = input("Enter rank: ");
compressed_image = compress(rank, source_image);
compressed_path = input("Enter compressed filename: ", "s");
imwrite(compressed_image, compressed_path);
