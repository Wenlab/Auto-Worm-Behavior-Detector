function performance_2_cate(human_label,machine_label)

human_label(human_label == 1) = 200;
human_label(human_label == 3) = 200;
machine_label(machine_label == 1) = 200;
machine_label(machine_label == 3) = 200;

result_2_cate = nan(3,3);

result_2_cate(1,1) = sum(human_label == 2 & machine_label == 2);
result_2_cate(1,2) = sum(human_label == 2 & machine_label == 200);

result_2_cate(2,1) = sum(human_label == 200 & machine_label == 2);
result_2_cate(2,2) = sum(human_label == 200 & machine_label == 200);

result_2_cate(1,3) = sum(result_2_cate(1,1:2));
result_2_cate(2,3) = sum(result_2_cate(2,1:2));

result_2_cate(3,1) = sum(result_2_cate(1:2,1));
result_2_cate(3,2) = sum(result_2_cate(1:2,2));

result_2_cate(3,3) = sum(result_2_cate(3,1:2));

precision_of_forward = result_2_cate(1,1) / result_2_cate(3,1);
recall_of_forward = result_2_cate(1,1) / result_2_cate(1,3);

precision_of_reorientation = result_2_cate(2,2) / result_2_cate(3,2);
recall_of_reorientation = result_2_cate(2,2) / result_2_cate(2,3);

% Assuming precision and recall are calculated without multiplying by 100
fprintf("\n");

disp("In 2 categories:")

fprintf('Precision of Forward: %.2f%%\n', precision_of_forward * 100);
fprintf('Recall of Forward: %.2f%%\n', recall_of_forward * 100);

fprintf('Precision of Reorientation: %.2f%%\n', precision_of_reorientation * 100);
fprintf('Recall of Reorientation: %.2f%%\n', recall_of_reorientation * 100);

fprintf("\n");

end