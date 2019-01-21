function taken_time = prob1(size_of_n)
sum = 0;
tic
for I = 1:size_of_n
    sum = sum + 1;
end
taken_time = toc;
