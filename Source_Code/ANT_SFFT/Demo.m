function Demo
%%%%%%%
%The smaller the filter_interval and edge_mask_interval = 5, the longer the program runs, and the more encoding scheme can be output to meet the different PSNR quality requirements.
filter_interval = 0.1;
edge_mask_interval = 5;
%%%%%%%

filter_threshold = [0:filter_interval:1];
edge_mask_threshold = [0:edge_mask_interval:50];
test_sheme(filter_threshold,edge_mask_threshold);
estimate_para(filter_threshold,edge_mask_threshold);
load('ref_table.mat');
num = size(ref_table);
num= num(1);
sub_threshold = zeros(1,num);
lp_threshold = zeros(1,num);
for i =1:num
    lp_path_list{i} = num2str(ref_table(i,1));
    lp_threshold(i) = ref_table(i,2);
    sub_threshold(i) = ref_table(i,3);
    new_img_path = char(strcat('./',lp_path_list(i),'/'));
    genrecPNG(ref_table(i,2),new_img_path);

end
sub_img(lp_path_list,sub_threshold);
boxsample(lp_path_list);
HMencode(lp_path_list);
recgen(lp_path_list, lp_threshold);
main_test(lp_path_list);
res_eva(lp_path_list);