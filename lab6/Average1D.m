function g = Average1D(f, w)
% f is input signals
% w is window
    N = numel(f);
    m = numel(w);
    m = floor(m/2);
    f = double(f);
    g = f;
    
    for i=1+m:N-m
        x = f(i-m:i+m);
        g(i) = sum(x.*w);
    end
    
    figure, plot(1:N, g, '--r');
    hold on
    plot(1:N, f);
end