function time_taken = prob4(n)
    time_taken = linspace(0,0,size(n,2));

    for I = 1:size(n,2)
        sum_time_taken = 0.0;
        for J = 1:10
            sum_time_taken = sum_time_taken + measure_time(n(I));
        end
        time_taken(I) = sum_time_taken / 10;
    end
end

function taken_time = measure_time(n)
    sum = 0;
    tic
    for I = 1:n
        for J = 1:I
            sum = sum + 1;
        end
    end
    taken_time = toc;
end
