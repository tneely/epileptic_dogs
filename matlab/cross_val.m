%{
    Given training EEG data, preprocesses features and trains neural network
    over portions of the training set,while testing on ommited 
    portions (?)
%}

function [sensitivity, fpr] = cross_val(X,Y,N) 

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
        
        intTest = intPerm([floor((numInt) / N * k + 1) : floor((numInt) / N * (k + 1))]);
        intTrain = intPerm;
        intTrain(intTest) = [];
        
        prePreTest = prePerm([floor(numPre / N * k + 1) : floor(numPre / N * (k + 1))]);
        preTest = I(prePreTest);
        preTrain = I;
        preTrain(prePreTest) = [];
        
        tester = [intTest, preTest];
        trainer = [intTrain, preTrain];
    
        [error,net] = eeg_train(X(trainer,:),Y(1,trainer),500,.3,0.85,0.05);

        predY = [];
        for i = 1:length(tester)
            predY = [predY, net.predict(X(tester(i),:))];
        end

        diff = Y(1,tester) - predY;
        dist = histc(diff, -1:1); %-1 if false positive, 1 if miss
        sensitivity = sensitivity + (numPre - dist(3))/numPre;
        fpr = fpr + dist(1)/numInt;
        
    end
    
    sensitivity = sensitivity/N;
    fpr = fpr/N;
    
end