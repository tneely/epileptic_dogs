%{
    Generalized Magnitude Squared Coherence calculates a measure of overall
    coherence between all channels in segment (ChannelxTime)
%}

function gco = gmsc(X) 

    M = size(X,1); %number of channels
    Ex = zeros(M); %MxM matrix to hold all coherence vals
    
    for i = 1:M
        for j = 1:M
            Ex(i,j) = mscohere(X(i,:), X(j,:));
        end
    end
    
    gco = (1/(M-1)) * (max(eigs(Ex)) - 1);

end