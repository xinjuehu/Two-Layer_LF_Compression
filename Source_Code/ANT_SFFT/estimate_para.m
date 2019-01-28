function estimate_para(filter_threshold,edge_mask_threshold)
load('plot_result.mat');
psnr_delta = 26:1:100;
ref_table = zeros(1,4);
for i = 1:length(psnr_delta)-1
    matrix_1 = (plot_result(:,:,1)>psnr_delta(i)).*(plot_result(:,:,1)<psnr_delta(i+1));
    if ~isempty(find(matrix_1,1))
        remain = plot_result(:,:,2).*matrix_1;
        remain(remain==0)=nan;
        [row,col] = find(remain==min(min(remain)));
        row = row(1);
        col = col(1);
        ref_table(end+1,1) = plot_result(row,col,1);
        ref_table(end,2) = filter_threshold(row);
        ref_table(end,3) = edge_mask_threshold(col);
        ref_table(end,4) = plot_result(row,col,2)/1024;
    end
end
ref_table(1,:) = [];
save('ref_table.mat','ref_table');