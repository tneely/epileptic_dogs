classdef (Abstract) NeuralNetwork
    %NeuralNetwork This is an abstract implementation of a 
    %   Detailed explanation goes here
    
    properties (Abstract)
        layers;
        errorFunction;
    end
    
    methods (Abstract)
        train(inputs, targets);
        test(inputs);
    end
    
end

