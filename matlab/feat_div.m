%{
    Breaks up input segments into N pieces to fit 
    memory contraints for feature generation.
%}

function feats = feat_div(X,freq,division,windows,overlap,spec_edge,sig_pow,avg_pow)
    
    tic
    
    %init and division
    feats = [];
    m = size(X,3) / division;
    pts = size(X,2);
    pts_per_win = floor(pts/(windows*(1-overlap)));
    step = floor(pts_per_win * (1-overlap));

    for i=1:division
        fprintf('Entering division %d: \n',i)
        ind = 1;
        win_feats = []
        for j = 1:windows
            fprintf('Window %d... \n',j)
            win_feats = [win_feats, features(X(:,ind:ind+pts_per_win,(m*(i-1)+1):(m*i)),freq,spec_edge,sig_pow,avg_pow)];
            ind = ind + step;
        end
        
        feats = [feats, win_feats];
        
        fprintf('Division %d finished. \n',i)        
    end
    
    fprintf('\n');
    toc
    
end
        