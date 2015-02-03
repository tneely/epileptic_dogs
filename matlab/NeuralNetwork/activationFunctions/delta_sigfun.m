function [ Y ] = delta_sigfun( N )
%delta_sigFun an implementation of the sigmoid function for ANNs
%   input:
%           N [1 x neurons] summed input for every neuron
%   output:
%           Y [1 x neurons] the output from every neuron

Y = sigfun(N)*(1 - sigfun(N));

end
