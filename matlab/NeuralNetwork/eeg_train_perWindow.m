%{
    Trains EEG feature data on feedforward neural network
    
    INPUT
    X : a segments x features matrix of training data
    Y : a 1xsegments matrix indicating classes (1=preictal, 0 = interictal)
    trials : scalar, number of trials to run
    a : scalar, value for learning rate

    OUTPUT
    error : a 1xsegments vector of error per trial
%}

function [error, net ]= eeg_train_perWindow(X, Y, trials, windS, a, m, d)

    tic 
    
    net = FeedForwardNetwork();
    net.momentum = m; %typically .8-.9
    net.decay = d; %typicall .03 - .05
    [numSegs, numFeats] = size(X);
    windows = numFeats/windS;
    windows
    %normalize data
    for i = 1:numSegs
        X(i,:) = (X(i,:)-min(X(i,:)))/(max(X(i,:))-min(X(i,:)));
    end
    
    pre_ratio = sum(Y)/numSegs;
    inter_rate = a*(pre_ratio);
    pre_rate = a*(1-pre_ratio);
    
    net.addInputLayer(windS,windS);
    hiddenNodes = floor(windS/2);
    net.addHiddenLayer(windS, hiddenNodes);
    net.addOutputLayer(hiddenNodes,1,0,0);
    
    error = zeros(trials,1);
    
    for trial = 1:trials
        
        fprintf('Starting trial %d... ', trial)
        
        rand('twister', 0);
        indPerm = randperm(numSegs);
        
        accum_error = 0;
        
        for i = indPerm
            
            if Y(1,i)
               net.learning_rate = pre_rate;
            else
               net.learning_rate = inter_rate;
            end
            j = 1;
            for wind = 1:windows
                accum_error = accum_error + backpropagation(net, X(i,j:j + windS-1), Y(1,i));
                j = j + windS;
            end
        end
        
        error(trial) = accum_error / numSegs /windows;
        
        fprintf('done! \n')
        
    end
    
    toc
    
    figure;
    subplot(1,1,1);
    plot(1:trials, error);
    title('Gradient Descent');
    ylabel('Least Squared Error');
    xlabel('Trial');
    
end
