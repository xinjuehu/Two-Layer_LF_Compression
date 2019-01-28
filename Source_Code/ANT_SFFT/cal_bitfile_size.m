function S = cal_bitfile_size(im_l)
yuv_path = strcat('generated.yuv');
fod = fopen(yuv_path,'wb');
row=512;col=512;
im_t_ycbcr = rgb2ycbcr(im_l);
im_t_y = im_t_ycbcr(:, :, 1);
im_t_cb = im_t_ycbcr(:, :, 2);
im_t_cr = im_t_ycbcr(:, :, 3);
im_t_cb = imresize(im_t_cb, [row/2, col/2], 'bicubic');
im_t_cr = imresize(im_t_cr, [row/2, col/2], 'bicubic');
for i1 = 1:row
    fwrite(fod,im_t_y(i1,:),'uint8');
end
for i1 = 1:row/2
    fwrite(fod,im_t_cb(i1,:),'uint8');
end
for i1 = 1:row/2
    fwrite(fod,im_t_cr(i1,:),'uint8');
end
fclose(fod);
!run_encode.bat;
D = dir('str2.bin');
delete('generated.yuv');
S = (D.bytes)/1024;