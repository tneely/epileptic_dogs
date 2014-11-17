%{
    Trains EEG feature data on feedforward neural network
    
    INPUT
    X : a segments x features matrix of training data
    Y : a 1xsegments matrix indicating classes (1=preictal, 0 = interictal)
    trials : scalar, number of trials to run
    a : scalar, value for learning rate
    hidden : scalar, indicates number of hidden layers

    OUTPUT
    error : a 1xsegments vector of error per trial
%}

function error = eeg_train(X, Y, trials, a, hidden)

    net = FeedForwardNetwork();
    
    [numSegs, numFeats] = size(X);
    
    pre_ratio = sum(Y)/numSegs;
    inter_rate = a*(pre_ratio);
    pre_rate = a*(1-pre_ratio);
    
    net.addInputLayer(numFeats,numFeats);
    net.addHiddenLayer(numFeats, hidden);
    net.addOutputLayer(hidden,1,0,1);
    
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
            
            accum_error = accum_error + backpropagation(net, X(i,:), Y(1,i));
        end
        
        error(trial) = accum_error / numSegs;
        
        fprintf('done! \n')
        
    end
    
    figure;
    subplot(1,1,1);
    plot(1:trials, error);
    title('Gradient Descent');
    ylabel('Least Squared Error');
    xlabel('Trial');
    
end