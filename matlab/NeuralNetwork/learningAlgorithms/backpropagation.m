function E = backpropagation( ANN, X, T )
%backpropagation Summary of this function goes here
%   input   ANN
%           X
%           T
%   output none, but the network gets updated

Y = ANN.predict(X);
E = Error(Y, T);
input_layer = ANN.input_layer;
a = ANN.learning_rate;
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
    delta_W = -a*d*O;
    delta_W
    curr_layer.Weights = curr_layer.Weights + delta_W.';
    curr_layer = curr_layer.upstream;
    i = i-1;
end
E = leastsquares(Y, T);
end
