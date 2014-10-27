%{
    Breaks up input segments into N pieces to fit 
    memory contraints
%}

function feats = feat_div(X,freq,N)
    
    feats = [];
    m = size(X,3) / N;

    for i=1:N
        
        feats = [feats; features(X(:,:,(m*(i-1)+1):(m*i)),freq)];
        
    end
    
end
        