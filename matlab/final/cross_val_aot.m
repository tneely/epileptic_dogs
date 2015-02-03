%{
    Given training EEG data, preprocesses features and trains neural network
    over portions of the training set,while testing on ommited 
    portions. Give sensitivity and false positive rates OVER TIME.

    INPUT
    X : segsxfeatures matrix of all data
    Y : 1xsegs vector, 1 indicates preictal, 0 is interictal
    N : scalar, number of folds
    T : scalar, number of trials

    OUTPUT
    sensitivity : 1xtrials, sensitivity of predictions averaged over folds
    fpr : 1xtrials, false positive rate of predictions averaged over folds
%}

function [sensitivity, fpr] = cross_val_aot(X,Y,N,T) 

    [segs,feats] = size(X);
    numPre = sum(Y);
    numInt = segs - numPre;
    I = find(Y); %get indices of preictal segments
    
    %random index permutation
    rand('twister', 0);
    intPerm = randperm(numInt);
    prePerm = randperm(numPre);
    
    %quality measures
    sensitivity = 0;
    fpr = 0;
    
    for k = 0:(N-1)
        
        fprintf('Starting fold %d of %d... \n', k+1, N)
        
        intTest = intPerm([floor((numInt) / N * k + 1) : floor((numInt) / N * (k + 1))]);
        intTrain = intPerm;
        intTrain(intTest) = [];
        
        prePreTest = prePerm([floor(numPre / N * k + 1) : floor(numPre / N * (k + 1))]);
        preTest = I(prePreTest);
        preTrain = I;
        preTrain(prePreTest) = [];
        
        tester = [intTest, preTest];
        trainer = [intTrain, preTrain];
    
        [~,~,tsens,tfpr] = eeg_train(X(trainer,:),Y(1,trainer),T,.3,0.85,0.05,X(tester,:), Y(1,tester));

        sensitivity = sensitivity + tsens;
        fpr = fpr + tfpr;
        
    end
    
    sensitivity = sensitivity/N;
    fpr = fpr/N;
    
end