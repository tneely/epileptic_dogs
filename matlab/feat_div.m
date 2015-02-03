%{
    Breaks up input segments into N pieces to fit 
    memory contraints for feature generation.
%}

function feats = feat_div(X,freq,division,spec_edge,sig_pow,avg_pow)
    
    feats = [];
    m = size(X,3) / division;

    for i=1:division
        fprintf('Entering division %d: \n',i)
        feats = [feats; features(X(:,:,(m*(i-1)+1):(m*i)),freq,spec_edge,sig_pow,avg_pow)];
        fprintf('Division %d finished. \n',i)        
    end
    
end
        