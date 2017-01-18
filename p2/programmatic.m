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
source_size = getfield(stat(source_image), "size");
input_image = rgb2gray(input_image);
err = [];
compression_ratio = [];
rank = [10, 199, 500, 1000, 2000];
for rank_item = [10, 100, 500, 1000, 2000]
    compressed_image = compress(rank_item, input_image);
    compressed_path = strcat(num2str(rank_item), ".jpg")
    imwrite(compressed_image, compressed_path);
    compressed_size = getfield(stat(compressed_path), "size");
    compression_ratio = [compressed_size / source_size, compression_ratio];
    err = [err, mean(meansq(input_image - compressed_image))];
endfor
plot(rank, compression_ratio)
%plot(rank, err)

