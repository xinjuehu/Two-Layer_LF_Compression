function generate_YUV(img_path)

yuv_path = strcat(img_path, 'generated.yuv');
img_list = dir(strcat(img_path,'*.png'));
fod = fopen(yuv_path,'wb');
row=512;col=512;
frames = length(img_list);

for frame = 1:frames
    img_name = img_list(frame).name;
    im_l = imread(strcat(img_path,img_name));
    im_t_ycbcr = rgb2ycbcr(im_l);
    im_t_y = im_t_ycbcr(:, :, 1);
    im_t_cb = im_t_ycbcr(:, :, 2);
    im_t_cr = im_t_ycbcr(:, :, 3);
    im_t_cb = imresize(im_t_cb, [row/2, col/2], 'bicubic');
    im_t_cr = imresize(im_t_cr, [row/2, col/2], 'bicubic');
    for i1 = 1:row 
       fwrite(fod,im_t_y(i1,:),'uint8');  %??????
    end
    for i1 = 1:row/2
       fwrite(fod,im_t_cb(i1,:),'uint8');  
    end
    for i1 = 1:row/2
       fwrite(fod,im_t_cr(i1,:),'uint8'); 
    end
end
fclose(fod);
