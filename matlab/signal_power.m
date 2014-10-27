%{
    Defines signal power of given wave feature as max value in range to be used in neural network from 
    given ChannelxTime matrix segment. 
%}

function wave = signal_power(X, range, f)

    wave = 0;
    
    for i = 1:size(X,1);
        
        [~, left] = min(abs(f - range(1)));
        [~, right] = min(abs(f - range(2)));
        
        wave = wave + max(X(i,left:right-1));
        
    end
    
    wave = wave / size(X,1);

end