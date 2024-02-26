function result_3_cate = performance_3_cate(human_label,machine_label)

result_3_cate = nan(4,4);

result_3_cate(1,1) = sum(human_label == 1 & machine_label == 1);
result_3_cate(1,2) = sum(human_label == 1 & machine_label == 2);
result_3_cate(1,3) = sum(human_label == 1 & machine_label == 3);

result_3_cate(2,1) = sum(human_label == 2 & machine_label == 1);
result_3_cate(2,2) = sum(human_label == 2 & machine_label == 2);
result_3_cate(2,3) = sum(human_label == 2 & machine_label == 3);

result_3_cate(3,1) = sum(human_label == 3 & machine_label == 1);
result_3_cate(3,2) = sum(human_label == 3 & machine_label == 2);
result_3_cate(3,3) = sum(human_label == 3 & machine_label == 3);

result_3_cate(1,4) = sum(result_3_cate(1,1:3));
result_3_cate(2,4) = sum(result_3_cate(2,1:3));
result_3_cate(3,4) = sum(result_3_cate(3,1:3));

result_3_cate(4,1) = sum(result_3_cate(1:3,1));
result_3_cate(4,2) = sum(result_3_cate(1:3,2));
result_3_cate(4,3) = sum(result_3_cate(1:3,3));

result_3_cate(4,4) = sum(result_3_cate(4,1:3));

precision_of_turn = result_3_cate(1,1) / result_3_cate(4,1);
recall_of_turn = result_3_cate(1,1) / result_3_cate(1,4);

precision_of_forward = result_3_cate(2,2) / result_3_cate(4,2);
recall_of_forward = result_3_cate(2,2) / result_3_cate(2,4);

precision_of_reversal = result_3_cate(3,3) / result_3_cate(4,3);
recall_of_reversal = result_3_cate(3,3) / result_3_cate(3,4);

% Assuming precision and recall are calculated without multiplying by 100
fprintf("\n");

disp("In 3 categories:")

fprintf('Precision of Turn: %.2f%%\n', precision_of_turn * 100);
fprintf('Recall of Turn: %.2f%%\n', recall_of_turn * 100);

fprintf('Precision of Forward: %.2f%%\n', precision_of_forward * 100);
fprintf('Recall of Forward: %.2f%%\n', recall_of_forward * 100);

fprintf('Precision of Reversal: %.2f%%\n', precision_of_reversal * 100);
fprintf('Recall of Reversal: %.2f%%\n', recall_of_reversal * 100);

fprintf("\n");

end