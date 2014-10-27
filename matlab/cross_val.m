%{
    Given training EEG data, preprocesses features and trains neural network
    over portions of the training set,while testing on ommited 
    portions (?)
%}

function [sensitivity, fpr] = cross_val(train, N) 

    [segX, segY, freq] = read_segs(); 
    
    feats = features(segX, freq);
    I = find(segY); %get indices of preictal segments
    
    %random index permutation
    rand('twister', 0);
    tot = size(segX,3);
    pre = size(I,2);
    intPerm = randperm(tot-pre);
    prePerm = randperm(pre);
    
    %quality measures
    sensitivity = 0;
    fpr = 0;
    
    for k = 0:(N-1)
        
        intTest = intPerm([floor((tot-pre) / N * k + 1) : floor((tot-pre) / N * (k + 1))]);
        intTrain = intPerm;
        intTrain(intTest) = [];
        
        prePreTest = prePerm([floor(pre / N * k + 1) : floor(pre / N * (k + 1))]);
        preTest = I(prePreTest);
        preTrain = I;
        preTrain(prePreTest) = [];
        
        tester = intTest + preTest;
        trainer = intTrain + preTrain;
    
        weights = train(feats(trainer,:), segY(1,trainer));
        predY = predict(weights,feats(tester,:));
        diff = segY - predY;
        dist = histc(diff, -1:1); %-1 if false positive, 1 if miss
        sensitivity = sensitivity + dist(3);
        fpr = fpr + dist(1);
        
    end
    
    sensitivity = (pre-sensitivity)/pre;
    fpr = fpr / (tot-pre);
    
end