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
        
        function [] = InputLayer(S, A)
            obj.input_layer = InputLayer(S, A);
        end
        
        function [] = AddHiddenLayer(S, A)
            lst_layer = obj.input_layer;
            while ~isNaN(lst_layer.downstream)
                last_layer = last_layer.downstream;
            end
            %create a new hidden layer
            curr_layer = HiddenLayer(S, A, lst_layer);
            %new hidden layer is downstream from previous layer
            upstream_layer.downstream = curr_layer;
        end
        
        function [] = outputLayer(S, A, sft, bin)
            lst_layer = obj.input_layer;
            while ~isNaN(lst_layer.downstream)
                last_layer = last_layer.downstream;
            end
            obj.output_layer = OutputLayer(S, A, sft, bin);
            %output layer is downstream from previous layer
            upstreamLayer.downstream = obj.output_layer;
        end
        
        %predict compute network output
        %input X [1 x features]
        %output Y [1 x values]
        %uses a helper function
        function Y = predict(X)
            Y = predictHelper(X, obj.input_layer);
        end
        
        %predictHelper is the recursive helper to predict
        %input  X [1 x num upstream neurons]
        %       layer the current layer we are computing for
        %output Y [1 x values]
        function Y = predictHelper(X, layer)
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

