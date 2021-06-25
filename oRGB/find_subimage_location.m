
function [x_start, x_end, y_start, y_end, z_start, z_end] = find_subimage_location(large_image, sub_image)
% reproduce your scenario
A = large_image; %randi(100, [30, 20, 10]);
B = sub_image; %A(20:30, 1:18, 4:end);
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
    x_start = subA1;
    x_end = subA1+sb1-1;
    y_start = subA2;
    y_end = subA2+sb2-1;
    z_start = subA3;
    z_end = subA3+sb3-1;
else
    x_start = 0;
    x_end = 0;
    y_start = 0;
    y_end = 0;
    z_start = 0;
    z_end = 0;
end

end