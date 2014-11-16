function [ Y ] = logsigfun( N )
%logsigFun an implementation of the sigmoid function for ANNs
%   input:
%           N [inputs x neurons] column vectors of input to each neuron
%   output:
%           Y []

Y = sigfun(N, 1, 1, 0);

end

