%{
    Given training EEG data, preprocesses features and trains neural network
    over portions of the training set,while testing on ommited 
    portions (?)
%}

function cross_val(train, N) 

    [segX, segY, freq] = read_segs(); 
    
    I = find(segY); %get indices of preictal segments
    
    %random index permutation
    rand('twister', 0);
    [tot,  ~] = size(segX);
    [pre,  ~] = size(I);
    intPerm = randperm(tot-pre);
    prePerm = randperm(pre);
    
    sensitivity = 0;
    fpr = 0;
    
    for k = 0:(N-1)
        
        intTest = intPerm([floor(m / N * k + 1) : floor(m / N * (k + 1))]);
        intTrain = intPerm;
        intTrain([floor(m / N * k + 1) : floor(m / N * (k + 1))]) = [];
        
        prePreTest = prePerm([floor(m / N * k + 1) : floor(m / N * (k + 1))]);
        preTrain = prePerm;
        preTrain([floor(m / N * k + 1) : floor(m / N * (k + 1))]) = [];
        
        preTest = I(prePreTest);
        preTrain = 
    
        theta = q5_train(X(indx_other,:), Y(indx_other,:), l, mode);
        pred_Y = q5_predict(theta,X(temp_test,:),mode);
        current_error = current_error + q5_mse(pred_Y, Y(temp_test,:));
        
    end
    
end