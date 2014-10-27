function Y = delta_logsigfun( N )
%delta_logsigFun an implementation of the dervative of  sigmoid function 
%                for ANNs
%   input:
%           N [inputs x neurons] column vectors of input to each neuron
%   output:
%           Y []

Y = sigfun(N).*(1 - sigfun(N));

end

