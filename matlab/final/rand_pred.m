%{
    Completely random class prediction.
    
    INPUT
    Y : a 1xsegments matrix indicating classes (1=preictal, 0 = interictal)
    trials : scalar, number of trials to run

    OUTPUT
    sens : sensitivity of predictions
    fpr : false positive rate of predictions
%}

function [sens, fpr] = rand_pred(Y, trials)

    numPre = sum(Y);
    total = length(Y);
    prob_pre = numPre/total;
    
    sens = 0;
    fpr = 0;
    
    for i = 1:trials
        
        predY = zeros(1,total);
        
        for j = 1:total
            if rand < prob_pre
                predY(1,j) = 1;
            end
        end
        
        diff = Y - predY;
        dist = histc(diff, -1:1); %-1 if false positive, 1 if miss
        sens = sens + (numPre - dist(3))/numPre;
        fpr = fpr + dist(1)/(total-numPre);
        
    end
    
    sens = sens / trials;
    fpr = fpr / trials;
    
end