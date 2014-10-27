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
bpE = backpropError(input_layer, E); %array of backprop errors

i = size(bpE, 1);
lst_layer = ANN.output_layer;
while ~strcmp(last_layer.type, 'input')
    O = last_layer.O;
    delta_W = -a*bpE(i)*O;
    lst_layer.Weights = lst_layer.Weights + delta_W;
end

end
