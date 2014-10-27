function D = makeD( N, delta_activity )
%derivatives computes the derivative matrix for matrix form backpropagation
%   input
%      layer the neural layer
%      input N [n x 1] the net inputs to each neuron
%   output
%       D [n x n] identity matrix of derivative of output

D = eye(size(N,1))*delta_activity(N);

end

