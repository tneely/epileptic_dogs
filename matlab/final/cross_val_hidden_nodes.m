%{
    Given training EEG data, preprocesses features and trains neural network
    over portions of the training set,while testing on ommited 
    portions.

    INPUT
    X : segsxfeatures matrix of all data
    Y : 1xsegs vector, 1 indicates preictal, 0 is interictal
    N : scalar, number of folds
    T : scalar, number of trials

    OUTPUT
    sensitivity : sensitivity of predictions averaged over folds
    fpr : false positive rate of predictions averaged over folds
%}

function [sensitivity, fpr] = cross_val_hidden_nodes(X,Y,N,T, feat_to_hid_ratio) 

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
    
        [error,net] = eeg_train_hidden_nodes(X(trainer,:),Y(1,trainer), feat_to_hid_ratio,T,.3,0.85,0.05);

        predY = [];
        L = length(tester);
        for i = 1:L
            predY = [predY, round(net.predict(X(tester(i),:)))];
        end

        diff = Y(1,tester) - predY;
        dist = histc(diff, -1:1); %-1 if false positive, 1 if miss
        sensitivity = sensitivity + (sum(Y(1,tester)) - dist(3))/Y(1,tester);
        fpr = fpr + dist(1)/(L-Y(1,tester));
        
    end
    
    sensitivity = sensitivity/N;
    fpr = fpr/N;
    
end