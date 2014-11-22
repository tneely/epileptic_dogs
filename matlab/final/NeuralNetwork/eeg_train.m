%{
    Trains EEG feature data on feedforward neural network
    
    INPUT
    X : a segments x features matrix of training data
    Y : a 1xsegments matrix indicating classes (1=preictal, 0 = interictal)
    trials : scalar, number of trials to run
    a : scalar, value for learning rate
    testX : optional segments x features matrix of test data
    testY : optional 1xsegments matrix indicating classes of test

    OUTPUT
    error : a 1xsegments vector of error per trial
%}

function [error, net, sens, fpr]= eeg_train(X, Y, trials, a, m, d, testX, testY)

    tic 
    
    net = FeedForwardNetwork();
    net.momentum = m; %typically .8-.9
    net.decay = d; %typicall .03 - .05
    [numSegs, numFeats] = size(X);

    pre_ratio = sum(Y)/numSegs;
    inter_rate = a*(pre_ratio);
    pre_rate = a*(1-pre_ratio);
    
    net.addInputLayer(numFeats,numFeats);
    hiddenNodes = floor(numFeats/2);
    %net.addHiddenLayer(numFeats, hiddenNodes);
    net.addOutputLayer(numFeats,1,0,0);
    
    error = zeros(trials,1);
    sens = zeros(trials,1);
    fpr = zeros(trials,1);
    
    for trial = 1:trials
        
        fprintf('Starting trial %d... ', trial)
        
        %randomize indices
        rand('twister', 0);
        indPerm = randperm(numSegs);
        
        accum_error = 0;
        
        %train
        for i = indPerm
            
            %set learning rate based on class
            if Y(1,i)
               net.learning_rate = pre_rate;
            else
               net.learning_rate = inter_rate;
            end
            
            accum_error = accum_error + backpropagation(net, X(i,:), Y(1,i));
        end
        
        error(trial) = accum_error / numSegs;
        
        %gives accuracy on test data over time
        if nargin == 8
            
           L = size(testY,2);
            
            predY = zeros(1,L);
            for i = 1:L
                predY(1,i) = round(net.predict(testX(i,:)));
            end

            diff = testY - predY;
            dist = histc(diff, -1:1); %-1 if false positive, 1 if miss
            sens(trial) = (sum(testY) - dist(3))/sum(testY);
            fpr(trial) = dist(1)/(L-sum(testY));
        end
        
        fprintf('done! \n')
        
    end
    
    toc
    
%     figure;
%     subplot(1,1,1);
%     plot(1:trials, error);
%     title('Gradient Descent');
%     ylabel('Least Squared Error');
%     xlabel('Trial');
    
end