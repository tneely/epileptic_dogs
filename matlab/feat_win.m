%{
    Breaks up input segments into N pieces to fit 
    memory contraints for feature generation.
%}

function feats = feat_win(X,freq,windows,overlap,spec_edge,sig_pow,avg_pow)
    
    %init and window division
    feats = [];
    pts = size(X,2);
    pts_per_win = floor(pts/(windows*(1-overlap)));
    step = floor(pts_per_win * (1-overlap));
    ind = 1;
    
    for i = 1:windows
        fprintf('Starting window %d... \n',i)
        feats = [feats, features(X(:,ind:ind+pts_per_win,:),freq,spec_edge,sig_pow,avg_pow)];
        ind = ind + step;
        fprintf('Window %d finished. \n',i) 
        fprintf('\n')
    end     
    
end
        