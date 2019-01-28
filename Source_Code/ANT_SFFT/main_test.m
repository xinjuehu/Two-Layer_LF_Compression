function main_test(lp_path_list)
block_num = 1;
X = 1:length(lp_path_list);
Y = zeros(block_num,block_num,length(lp_path_list));
for i = 1:length(lp_path_list)
    act_path = char(strcat('./',lp_path_list(i),'_rec','/'));
    Y(:,:,i) = resultevaluation(act_path,block_num);
end
% figure;
% for n1 = 1:block_num
%     for n2 = 1:block_num
%         C = Y(n1,n2,:);
%         plot(X,C(:));
%         hold on;
%     end
% end
D = mean(mean(Y,1),2);
% figure,plot(X, D(:));