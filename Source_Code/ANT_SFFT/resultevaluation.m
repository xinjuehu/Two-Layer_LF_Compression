function [mean_Psnr,PsnrMatrix] = resultevaluation(path,block_num)
img_path_list = dir(strcat(path, '*.png'));
img_num = length(img_path_list);
img_num
img_matrix_row = sqrt(img_num);
test_img_name = img_path_list(1).name;
test_image = imread(strcat(path,test_img_name));
[H,W,C] = size(test_image);


raw_path = './crystal/';
raw_img_list = dir(strcat(raw_path,'*.png'));
raw_num = length(raw_img_list);
raw_matrix_row = sqrt(raw_num);
test_raw_name = raw_img_list(1).name;
test_raw = imread(strcat(raw_path,test_raw_name));
[Hr,Wr,Cr] = size(test_raw);

PsnrMatrix = zeros(block_num,block_num,img_matrix_row,img_matrix_row);

for j = 0:img_num-1
    img_name = img_path_list(j+1).name;
    image = imread(strcat(path,img_name));
    row = floor(j/img_matrix_row)+1;
    column = mod(j, img_matrix_row)+1;
    raw_ind = (row -1)*raw_matrix_row + (column - 1);
    ref_name = raw_img_list(raw_ind + 1).name;
    ref_image = imread(strcat(raw_path,ref_name));
    ref_image = ref_image(1:Hr/H:end, 1:Wr/W:end, :);
    block_size = H/block_num;
    for n1 = 0:block_num - 1
        for n2 = 0:block_num -1
            PsnrMatrix(n1+1,n2+1,row,column) = psnr(image(n1*block_size+1:(n1+1)*block_size,n2*block_size+1:(n2+1)*block_size, :), ref_image(n1*block_size+1:(n1+1)*block_size,n2*block_size+1:(n2+1)*block_size, :));
        end
    end
end

mean_Psnr = mean(mean(PsnrMatrix,3),4);
Max_V = max(max(mean_Psnr));
Min_V = min(min(mean_Psnr));
show_D = (mean_Psnr-Min_V)/(Max_V-Min_V);