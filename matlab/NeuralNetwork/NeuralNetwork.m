classdef (Abstract) NeuralNetwork < Handle
    %NeuralNetwork This is an abstract implementation of a 
    %   Detailed explanation goes here
    
    properties (Abstract)
        type;
    end
    
    properties
        layers;
        errorFun;
    end
    
    methods (Abstract)
        train(inputs, targets);
        test(inputs);
    end
    
    methods
        function set.errorFun(obj, value)
            obj.errorFun = value;
        end
    end
    
end

