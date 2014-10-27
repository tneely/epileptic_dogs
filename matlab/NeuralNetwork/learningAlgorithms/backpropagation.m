function E = backpropagation( ANN, X, T )
%backpropagation Summary of this function goes here
%   input   ANN
%           X
%           T
%   output none, but the network gets updated

Y = ANN.predict(X);
E = leastsquares(Y, T);

input_layer = ANN.input_layer;
a = ANN.learning_rate;
bpE = backproperror(input_layer, E); %array of backprop errors

%W       [inputs x neurons]
%O       [1 x inputs]
%bpE     [neurons x 1]
%delta_W [inputs x neurons]
i = size(bpE,2);
last_layer = ANN.output_layer;
while ~strcmp(last_layer.type, 'input')
    O = last_layer.O;
    d = bpE{i};%backprop error
    delta_W = -a*d*O;
    last_layer.Weights = last_layer.Weights + delta_W.';
    last_layer = last_layer.upstream;
    i = i-1;
end

end
