function [ Y ] = sigfun( N, c1, c2, c3 )
%logsigFun an implementation of the sigmoid function for ANNs
%   input:
%           N [1 x neurons] summed input for every neuron
%           P [3 x 1] parameters for the sigmoid function
%   output:
%           Y [1 x neurons] the output from every neuron
Y = c1./(1 + exp(-c2*N) ) - c3;

end

