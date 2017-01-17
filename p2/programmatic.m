pkg load image

clear
format long e

function compressed_image = compress(rank, input_image)
    input_image = im2double(input_image);
    [U, S, V] = svd(input_image);
    S(rank + 1:end, :) = 0;
    S(:, rank + 1:end) = 0;
    compressed_image = U * S * V';
endfunction

function err = square_error(src, dst)
    err = sum(sum((src - dst).^2)) / (columns(src) * rows(src));
endfunction

source_image = "nature.jpg"
input_image = imread(source_image);
input_image = rgb2gray(input_image);
for rank = [10, 100, 500, 1000, 2000]
    compressed_image = compress(rank, input_image);
    compressed_path = strcat(num2str(rank), ".jpg")
    imwrite(compressed_image, compressed_path);
    err = square_error(input_image, compressed_image);
    printf("Error is %.73f", err)
endfor
