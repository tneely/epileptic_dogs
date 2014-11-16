load('11-9-14.mat');
load('segY.mat');
segY = segY.';
net = FeedForwardNetwork();
net.learning_rate = .1;

numFeatures = size(feats, 2);

net.addInputLayer(numFeatures,numFeatures);
net.addHiddenLayer(numFeatures,40);
net.addHiddenLayer(40,40);
net.addOutputLayer(40,1, 0, 0);

trials = 10;
error = zeros(trials,1);
for trial = 1:trials
   error_accum=0; 
   for i = 1:size(feats)
       error_accum = backpropagation(net, feats(i,:), segY(i,:));
   end
   error_accum = error_accum/size(feats,1);
   error(trial,1) = error_accum;
end

plot(error);