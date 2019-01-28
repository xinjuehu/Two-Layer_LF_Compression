function boxsample(lp_path_list)
for act_lp = 1:length(lp_path_list)
    lp_img_path = char(strcat('./',lp_path_list(act_lp),'/'));
    box_img_path = char(strcat('./',lp_path_list(act_lp),'_box','/'));
    if exist(box_img_path)
        rmdir(box_img_path,'s');
    end
    mkdir(box_img_path);
    sample_indix = [0, 0, 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0, 9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 0, 16, 1, 0, 1, 1, 1, 15, 1, 16, 2, 0, 2, 2, 2, 14, 2, 16, 3, 0, 3, 3, 3, 13, 3, 16, 4, 0, 4, 4, 4, 12, 4, 16, 5, 0, 5, 5, 5, 11, 5, 16, 6, 0, 6, 6, 6, 10, 6, 16, 7, 0, 7, 7, 7, 9, 7, 16, 8, 0, 8, 8, 8, 16, 9, 0, 9, 7, 9, 9, 9, 16, 10, 0, 10, 6, 10, 10, 10, 16, 11, 0, 11, 5, 11, 11, 11, 16, 12, 0, 12, 4, 12, 12, 12, 16, 13, 0, 13, 3, 13, 13, 13, 16, 14, 0, 14, 2, 14, 14, 14, 16, 15, 0, 15, 1, 15, 15, 15, 16, 16, 0, 16, 1, 16, 2, 16, 3, 16, 4, 16, 5, 16, 6, 16, 7, 16, 8, 16, 9, 16, 10, 16, 11, 16, 12, 16, 13, 16, 14, 16, 15, 16, 16];
    for nl = 1:(length(sample_indix)/2)
        row_ind = sample_indix(2*nl-1);
        col_ind = sample_indix(2*nl);
        filename = strcat(lp_img_path,'result_',num2str(row_ind,'%02d'),'_',num2str(col_ind,'%02d'),'.png');
        movefile(filename,box_img_path)
    end
    generate_YUV(box_img_path);
end