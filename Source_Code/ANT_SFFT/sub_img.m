function sub_img(lp_path_list,sub_threshold)
raw_path = './crystal/';
ref_path = './sfft_crystal/';
raw_img_list = dir(strcat(raw_path,'*.png'));
ref_img_list = dir(strcat(ref_path,'*.png'));
for act_lp = 1:length(lp_path_list)
    lp_img_path = char(strcat('./',lp_path_list(act_lp),'/'));
    sub_img_path = char(strcat('./',lp_path_list(act_lp),'_sub','/'));
    if exist(sub_img_path)
        rmdir(sub_img_path,'s');
    end
    mkdir(sub_img_path);
    lp_img_list = dir(strcat(lp_img_path,'*.png'));
    if (length(raw_img_list)~=length(lp_img_list))
        error('image nuber error');
    end
    for i = 1:length(raw_img_list)
        img_name = raw_img_list(i).name;
        lp_img_name = ref_img_list(i).name;
        raw = imread(strcat(raw_path,img_name));
        strcat(raw_path,img_name)
        lp = imread(strcat(lp_img_path,lp_img_name));
        strcat(lp_img_path,lp_img_name)
        sub = int8(double(raw)- double(lp));
        threshold_mask = int16(abs(sub)>sub_threshold(act_lp));
        shift_sub = int16(sub).*threshold_mask+127;
        shift_sub = uint8(shift_sub);
        file_name = strcat(sub_img_path,lp_img_name);
        imwrite(shift_sub,file_name);      
    end
    generate_YUV(sub_img_path);
end
end