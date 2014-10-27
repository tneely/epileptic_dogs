function [ Y ] = sigfun( N )
%logsigFun an implementation of the sigmoid function for ANNs
%   input:
%           N [1 x neurons] summed input for every neuron
%           P [3 x 1] parameters for the sigmoid function
%   output:
%           Y [1 x neurons] the output from every neuron
c1 = 1;
c2 = 1;
c3 = 0;

if nargin == 2
    c1 = P(1);
    c2 = P(2);
    c3 = P(3);
end

Y = c1./(1 + exp(-c2*N) ) - c3;

end

