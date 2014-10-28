load('10-27-14.mat');
load('segY.mat');

net = FeedForwardNetwork();
net.learning_rate = .2;
net.addInputLayer(6,6);
net.addHiddenLayer(6,40);
net.addOutputLayer(40,1, 1, 0);

backpropagation(net, feats(1,:), 1)
%trials = 10
%for trial = 1:10
%   ave_error=0; 
%    %iterate over corpus
%    for 
        
%end