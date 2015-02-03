function D = makeD( Net, delta_activity )
%derivatives computes the derivative matrix for matrix form backpropagation
%   input
%      layer the neural layer
%      input Net [n x 1] the net inputs to each neuron
%   output
%       D [n x n] identity matrix of derivative of output
D = diag(delta_activity(Net));

end

