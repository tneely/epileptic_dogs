classdef FeedForwardNetwork < handle
    %FeedForwardNetwork inplementation of a feedforward network
    %   Detailed explanation goes here
    
    properties
        name;
        type = 'ffn';
        
        input_layer = nan; %inputlayer
        output_layer = nan; %outputlayer
        
    end
    
    methods
        function obj = FeedForwardNetwork()
        end
        
        function obj = addInputLayer(obj, n_in, n_neurons)
            obj.input_layer = InputLayer(n_in, n_neurons);
        end
        
        function [] = addHiddenLayer(obj, n_in, n_neurons)
            last_layer = obj.input_layer;
            while ~isequal(last_layer.downstream, [])
                last_layer = last_layer.downstream;
            end
            %create a new hidden layer
            curr_layer = HiddenLayer( n_in, n_neurons, last_layer);
            %new hidden layer is downstream from previous layer
            curr_layer.upstream.downstream = curr_layer;
        end
        
        function [] = addOutputLayer(obj, n_in, n_neurons, sft, bin)
            last_layer = obj.input_layer;
            while ~isequal(last_layer.downstream, [])
                last_layer = last_layer.downstream;
            end
            obj.output_layer = OutputLayer(n_in, n_neurons, last_layer, ...
                sft, bin);
            %output layer is downstream from previous layer
            obj.output_layer.upstream.downstream = obj.output_layer;
        end
        
        %predict compute network output
        %input X [1 x features]
        %output Y [1 x values]
        %uses a helper function
        function Y = predict(obj, X)
            Y = obj.predictHelper(X, obj.input_layer);
        end
        
        %predictHelper is the recursive helper to predict
        %input  X [1 x num upstream neurons]
        %       layer the current layer we are computing for
        %output Y [1 x values]
        function Y = predictHelper(obj, X, layer)
            %Base Case: output layer
            if strcmp(layer.type, 'output')
                Y = layer.activation(X);
            %Recursive Case: non output layer
            else
                X = layer.activation(X);
                Y = predictHelper(X, layer.downstream);
            end
        end
        
    end
    
end

