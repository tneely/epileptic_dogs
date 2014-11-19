%{
    Breaks up input segments into N pieces to fit 
    memory contraints for feature generation.
%}

function feats = sing_feat_win(X,freq,windows,overlap,norm,spec_edge,sig_pow,avg_pow)
    
    %init and window division
    feats = [];
    pts = size(X,2);
    pts_per_win = floor(pts/(windows*(1-overlap)));
    step = floor(pts_per_win * (1-overlap));
    ind = 1;
    
    for i = 1:windows
        %fprintf('Starting window %d... \n',i)
        stop = ind+pts_per_win;
        
        %check to make sure we dont pass index range on last iteration
        if stop > pts
            stop = pts;
        end
        
        feats = [feats, sing_feats(X(:,ind:stop),freq,norm,spec_edge,sig_pow,avg_pow)];
        ind = ind + step;
        %fprintf('Window %d finished. \n',i) 
        %fprintf('\n')
    end     
    
end
        