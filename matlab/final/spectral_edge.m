%{
    Defines spectral edge feature to be used in neural network from 
    given ChannelxFreq matrix segment. Output is 1xchannels.
%}

function sef = spectral_edge(X, f, p)
    
    chnls = size(X,1);
    sef = zeros(1,chnls);

    for i = 1:size(X,1);
        
        xNorm = X(i,:)./sum(X(i,:));
        xCum = cumsum(xNorm);
        [~, indx] = min(abs(xCum - p));
        
        sef(i) = f(indx); %in Hz
        
    end

end
