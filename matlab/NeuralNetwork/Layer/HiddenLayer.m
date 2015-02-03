classdef HiddenLayer < NeuralLayer
    %NerualLayer 
    %   Detailed explanation goes here
    
    properties
        type = 'hidden';
        
    end
    
    methods
        %NeuralLayer Constructor
        %input  S [2 x 1] size of the weight matrix
        %       A [a x 1] the activation function, may contain func. params
        function obj = HiddenLayer(n_in, n_neurons, u)
            obj@NeuralLayer(n_in, n_neurons)
            obj.upstream = u;
        end
    end
end