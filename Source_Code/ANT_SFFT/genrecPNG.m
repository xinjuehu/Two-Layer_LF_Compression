function genrecPNG(lp,new_PNG_path)
raw_path = './crystal/';
ref_path = './sfft_crystal/';
raw_img_list = dir(strcat(raw_path,'*.png'));
ref_img_list = dir(strcat(ref_path,'*.png'));
raw_num = length(raw_img_list);
H = 512;
W = 512;

if exist(new_PNG_path)
    rmdir(new_PNG_path,'s');
end
mkdir(new_PNG_path);

for i = 1:raw_num
    img_name = raw_img_list(i).name;
    ref_name = ref_img_list(i).name;
    act_img = imread(strcat(raw_path,img_name));
    recover_FFT_Freq_R = fftshift(fft2(act_img(1:end,1:end,1)));
    recover_FFT_Freq_G = fftshift(fft2(act_img(1:end,1:end,2)));
    recover_FFT_Freq_B = fftshift(fft2(act_img(1:end,1:end,3)));
    th_value = [0,lp,1];
    filter_num = length(th_value)-1;
    mask_matrix = zeros(H,W);
    dia = sqrt(H^2+W^2)/2;
    H_mid = fix(H/2);
    W_mid = fix(W/2);
    for n = 1:H
        for m = 1:W
            d = sqrt((n-H_mid)^2+(m-W_mid)^2);
            for k = 1:length(th_value)-1
                if d>=th_value(k)*dia
                    mask_matrix(n,m) = mask_matrix(n,m) + 1;
                else
                    break;
                end
            end
        end
    end
    filter = (mask_matrix==1);
    rec_IMG_R = uint8(real(ifft2(ifftshift(recover_FFT_Freq_R.*filter))));
    rec_IMG_G = uint8(real(ifft2(ifftshift(recover_FFT_Freq_G.*filter))));
    rec_IMG_B = uint8(real(ifft2(ifftshift(recover_FFT_Freq_B.*filter))));
    new_PNG = uint8(zeros(H,W,3));
    new_PNG(:,:,1) = rec_IMG_R;
    new_PNG(:,:,2) = rec_IMG_G;
    new_PNG(:,:,3) = rec_IMG_B;
    new_PNG = uint8(new_PNG);
    file_name = strcat(new_PNG_path,ref_name);
    imwrite(new_PNG,file_name);
end
end