load('10-27-14.mat');
load('segY.mat');
segY = segY.';
net = FeedForwardNetwork();
net.learning_rate = .1;
net.addInputLayer(6,6);
net.addHiddenLayer(6,40);
net.addHiddenLayer(40,40);
net.addOutputLayer(40,1, 0, 0);

trials = 10;
error = zeros(trials,1);
for trial = 1:1000
   error_accum=0; 
   for i = 1:size(feats)
       error_accum = backpropagation(net, feats(i,:), segY(i,:));
   end
   error_accum = error_accum/size(feats,1);
   error(trial,1) = error_accum;
end

plot(error);