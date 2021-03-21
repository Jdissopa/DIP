function [R]=ETHE(a,Threshold)
n0=10;
[r,c]=size(a);
len=r*c;
t=0;
s=0;
%% Edge detection using Sobel Operator
mask1=[1,0,-1;2,0,-2;1,0,-1];
mask2=[-1,-2,-1;0,0,0;1,2,1];
Gx=filter2(mask1,a,'same');
Gy=filter2(mask2,a,'same');
Gxy=(Gx.^2+Gy.^2).^0.5;
for i=1:r
    for j=1:c
        if(Gxy(i,j)<Threshold)
            b(i,j)=255;
            c1(i,j)=0;
            s=s+1;
        else
            b(i,j)=0;
            c1(i,j)=1;
            t=t+1;
        end
    end
end
%% Histogram Calculation
histogram=zeros(1,256);
for i=2:r-1
    for j=2:c-1
        if(c1(i,j)==1)
            min=255;max=0;
            for k=i-1:i+1
                for l=j-1:j+1
                    if a(k,l)<min
                        min=a(k,l);
                    end
                    
                    if a(k,l)>max
                        max=a(k,l);
                    end
                end
            end
            for p=min:max
                histogram(p+1)=histogram(p+1)+1;
            end
        end
    end
end
pdf=histogram./(sum(histogram));
cdf=zeros(1,256);
cdf(1)=pdf(1);
 
for i=2:256
    cdf(i)=cdf(i-1)+pdf(i);
end
map=(255*cdf);
%% Histogram Equalization
R=zeros(r,c);
for i=1:r
    for j=1:c
        R(i,j)=map(a(i,j)+1);
    end
end
end
