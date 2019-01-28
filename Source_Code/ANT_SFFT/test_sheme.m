function test_sheme(filter_threshold,edge_mask_threshold)
x= [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9];
y=[299,384,430,459,478,490,495,492,492];
y2=polyfit(x,y,7);
% filter_threshold = [0:0.02:0.2];
% edge_mask_threshold = [0:1:50];
plot_result = zeros(length(filter_threshold),length(edge_mask_threshold),2);
load('test_material.mat')
for xx1 = 1:length(filter_threshold)
    for xx2 = 1:length(edge_mask_threshold)
        th_value = [0,filter_threshold(xx1),1];
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
        lp_IMG = uint8(zeros(H,W,3));
        lp_IMG(:,:,1) = uint8(real(ifft2(ifftshift(raw_FFT_R.*filter))));
        lp_IMG(:,:,2) = uint8(real(ifft2(ifftshift(raw_FFT_G.*filter))));
        lp_IMG(:,:,3) = uint8(real(ifft2(ifftshift(raw_FFT_B.*filter))));
        sub_IMG = double(int8(double(raw_img) - double(lp_IMG)));
        threshold_mask = double(abs(sub_IMG)>edge_mask_threshold(xx2));
        sub_IMG = double(sub_IMG.*threshold_mask);
        shift_sub_IMG = uint8(sub_IMG + 127);
        size_sub = cal_bitfile_size(shift_sub_IMG);
        rec_IMG = uint8(zeros(H,W,3));
        rec_IMG(:,:,1) = uint8(real(ifft2(ifftshift(rec_FFT_R.*filter))));
        rec_IMG(:,:,2) = uint8(real(ifft2(ifftshift(rec_FFT_G.*filter))));
        rec_IMG(:,:,3) = uint8(real(ifft2(ifftshift(rec_FFT_B.*filter))));
        size_rec = cal_bitfile_size(lp_IMG);
        inv_shift_sub = double(shift_sub_IMG) - 127;
        syn_IMG = uint8(double(rec_IMG) + inv_shift_sub);
        plot_result(xx1,xx2,1) = psnr(syn_IMG,raw_img);  
        plot_result(xx1,xx2,2) = (289*size_sub)+93*(size_rec);
        [filter_threshold(xx1),edge_mask_threshold(xx2),plot_result(xx1,xx2,2)/1000,plot_result(xx1,xx2,1)]
    end
end
save('plot_result.mat','plot_result');




