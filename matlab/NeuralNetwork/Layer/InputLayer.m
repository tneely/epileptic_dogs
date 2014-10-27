classdef InputLayer < NeuralLayer
    %Input Layer
    %   Detailed explanation goes here
    
    properties
        type = 'input';
        
    end
    
    methods
        %NeuralLayer Constructor
        %input  S [2 x 1] size of the weight matrix
        %       A [a x 1] the activation function, may contain func. params
        function obj = InputLayer(n_in, n_neuron)
            obj@NeuralLayer(n_in, n_neuron);
            obj.Weights = [];
        end
        
        function Y = activate(obj, X)
            Y = obj.activationfun(X);
        end
    end
end