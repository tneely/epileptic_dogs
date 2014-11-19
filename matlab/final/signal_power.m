%{
    Defines signal power of given wave feature as max value in range to be used in neural network from 
    given ChannelxFreq matrix segment. Output is 1xchannels.
%}

function wave = signal_power(X, range, f)

    chnls = size(X,1);
    wave = zeros(1,chnls);

    for i = 1:size(X,1); %for each channel
        
        [~, left] = min(abs(f - range(1)));
        [~, right] = min(abs(f - range(2)));
        
        wave(i) = max(X(i,left:right-1));
        
    end

end