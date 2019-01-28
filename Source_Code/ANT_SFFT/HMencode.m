function HMencode(lp_path_list)
default_path = pwd;
for act_lp = 1:length(lp_path_list)
    box_path = char(strcat('./',lp_path_list(act_lp),'_box','/'));
    box_cf_list = dir('./box_HM_cf/');
    for file_ind = 3:length(box_cf_list)
        filename = strcat('./box_HM_cf/',box_cf_list(file_ind).name);
        copyfile(filename,box_path);
    end
    sub_path = char(strcat('./',lp_path_list(act_lp),'_sub','/'));
    sub_cf_list = dir('./sub_HM_cf/');
    for file_ind = 3:length(sub_cf_list)
        filename = strcat('./sub_HM_cf/',sub_cf_list(file_ind).name);
        copyfile(filename,sub_path);
    end
    cd(box_path);
    delete('str2.bin');
    !run_encode.bat;
    cd(default_path);
    cd(sub_path);
    delete('str2.bin');
    !run_encode.bat;
    cd(default_path);
end