function E = backpropagation( ANN, X, T )
%backpropagation Summary of this function goes here
%   input   ANN
%           X
%           T
%   output none, but the network gets updated

Y = ANN.predict(X);
E = Error(T, Y);
input_layer = ANN.input_layer;
a = ANN.learning_rate;
m = ANN.momentum;
bpE = backproperror(input_layer, E); %array of backprop errors
%W       [inputs x neurons]
%O       [1 x inputs]
%bpE     [neurons x 1]
%delta_W [inputs x neurons]
i = size(bpE,2);
curr_layer = ANN.output_layer;
while ~strcmp(curr_layer.type, 'input')
    O = curr_layer.O; %Input to the layer

    d = bpE{i};%backprop error
    delta_W = -a.*d*O;
    curr_layer.Weights = curr_layer.Weights + delta_W.' + m.*curr_layer.MWeights;
    curr_layer.bias = curr_layer.bias - (a.*d).' + m.*curr_layer.Mbias;
    curr_layer.MWeights = delta_W.';
    curr_layer.Mbias = (a.*d).';
    
    curr_layer = curr_layer.upstream;
    i = i-1;
end
E = leastsquares(T, Y);
end
