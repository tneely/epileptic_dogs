%{
    Defines spectral edge feature to be used in neural network from 
    given ChannelxTime matrix segment. 
%}

function sef = spectral_edge(X, f, p)

    sef = 0; %zeros(size(X,1), 1);

    for i = 1:size(X,1);
        
        xNorm = X(i,:)./sum(X(i,:));
        xCum = cumsum(xNorm);
        [~, indx] = min(abs(xCum - p));
        
        %sef(i) = f(indx);
        sef = sef + f(indx);
        
    end
    
    sef = sef / size(X,1); %avg of all channels

end
