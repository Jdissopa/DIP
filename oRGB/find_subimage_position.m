%clear;clc
clc
% reproduce your scenario
A = image010; %randi(100, [30, 20, 10]);
B = original; %A(20:30, 1:18, 4:end);
% counter-case verification
% B(end)=200;
% speed up
lenA = numel(A);
[sa1,sa2,sa3] = size(A);
[sb1,sb2,sb3] = size(B);
% a cumbersome method
eqflag = 0;
counterA = 1;
while (counterA <= lenA)
    if A(counterA) == B(1)
        [subA1,subA2,subA3] = ind2sub([sa1,sa2,sa3],counterA);
        if ( (subA1+sb1-1)<=sa1 ) && ( (subA2+sb2-1)<=sa2 ) ...
                && ( (subA3+sb3-1)<=sa3 ) && isequal( B, ...
            A(subA1+(1:sb1)-1,subA2+(1:sb2)-1,subA3+(1:sb3)-1) )
            eqflag = 1;
            break;
        end
    end
    counterA = counterA + 1;
end
if eqflag
    fprintf('found matching starting at A(%d, %d, %d).\n', ...
        subA1, subA2, subA3);
    fprintf('matching region A(%d:%d, %d:%d, %d:%d).\n', ...
        subA1, subA1+sb1-1, subA2, subA2+sb2-1, subA3, subA3+sb3-1);
else
    fprintf('no matching found.\n');
end
clearvars sa* lenA counterA
% --------------
% a parallel way
[sa1,sa2,sa3] = size(A);
match_first = find(A==B(1));
[m1,m2,m3] = ind2sub([sa1,sa2,sa3],match_first);
region_first_ind = intersect( intersect(find(m1+sb1-1<=sa1), ...
    find(m2+sb2-1<=sa2)),find(m3+sb3-1<=sa3)); % array size issue
region_first = num2cell( [m1(region_first_ind),m2(region_first_ind),...
    m3(region_first_ind)], 2);
region = cellfun(@(v) [v;v+[sb1,sb2,sb3]-1], region_first, ...
    'UniformOutput', false);
region_match = cellfun(@(v) isequal(A(v(1):v(2), v(3):v(4), v(5):v(6)),...
    B), region, 'UniformOutput', false);
match = cell2mat(region([region_match{:}]));
if ~isempty(match)
    fprintf('found matching starting at A(%d, %d, %d).\n', ...
        match(1), match(3), match(5));
    fprintf('matching region A(%d:%d, %d:%d, %d:%d).\n', ...
        match(1), match(2), match(3), match(4), match(5), match(6));
else
    fprintf('no matching found.\n');
end