classdef InputLayer < NeuralLayer
    %Input Layer
    %   Detailed explanation goes here
    
    properties
        type = 'input';
        
        upstream = [];
        downstream = [];
        
        %The activation function computes this layers output vector
        activationFun;
        activationFunParams;
    end
    
    methods
        %NeuralLayer Constructor
        %input  S [2 x 1] size of the weight matrix
        %       A [a x 1] the activation function, may contain func. params
        function obj = InputLayer(n_in, n_neuron)
            obj@NeuralLayer(n_in, n_neuron);
        end
    end
end