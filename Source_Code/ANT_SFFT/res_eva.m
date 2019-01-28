function res_eva(lp_path_list)
load('ref_table.mat');
for act_lp = 1:length(lp_path_list)
    box_path = char(strcat('./',lp_path_list(act_lp),'_box','/'));
    D1 = dir(strcat(box_path,'str2.bin'));
    sub_path = char(strcat('./',lp_path_list(act_lp),'_sub','/'));
    D2 = dir(strcat(sub_path,'str2.bin'));
    ref_table(act_lp,5) = (D1.bytes+D2.bytes)/1024/1024;
    result_table = ref_table;
    save('result_table.mat','result_table');
end
