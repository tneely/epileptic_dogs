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
    net.learning_rate = a;
    
    [numSegs, numFeats] = size(X);
    
    net.addInputLayer(numFeats,numFeats);
    net.addHiddenLayer(numFeats, hidden);
    net.addOutputLayer(hidden,1,0,0);
    
    error = zeros(trials,1);
    
    for trial = 1:trials
        
        fprintf('Starting trial %d... ', trial)
        
        accum_error = 0;
        
        for i = 1:numSegs
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