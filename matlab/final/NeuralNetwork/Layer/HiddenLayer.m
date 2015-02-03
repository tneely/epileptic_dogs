classdef HiddenLayer < NeuralLayer
    %HiddenLayer is a subclass of Neural Layer
    %   Hidden Layer pretty much does everythin that a Neural Layer does
    %   except when you ask it what it is, it says 'hidden'
    
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