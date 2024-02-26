function check_error(T)

n_behavior = size(T,1);
for i = 1:n_behavior - 1
    if T{i,2} ~= T{i + 1,1} - 1
        error("The end frame of this behavior is not the start frame of the next behavior minus 1");
    end
end

end