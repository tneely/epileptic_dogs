classdef OutputLayer < NeuralLayer
    %NerualLayer 
    %   Detailed explanation goes here
    
    properties
        layerType = 'output';
        softmax;
        binary;
        numSynapses;
        numNeurons;
        
        upstream;
        downstream = nan;
        
        Weights;%[inputs x neurons] the matrix of synaptic weights
        prev_net_j;%for backpropogation
        
        %The activation function computes this layers output vector
        activationFun;
        activationFunParams;
    end
    
    methods
        %NeuralLayer Constructor
        %input  S [2 x 1] size of the weight matrix
        %       A [a x 1] the activation function, may contain func. params
        %       softmax true | false
        %           whether output must sum to one
        function obj = OutputLayer(S, A, u, smx, bin)
            obj@NeuralLayer(S,A);
            obj.upstream = u;
            obj.softmax = smx;
            obj.binary = bin;
        end
        
        %activate computes the output vector from the layer
        %input X [1 x numInputs] the input vector into each synapse
        %output Y [1 x neurons] the output vector from the layer
        %
        %uses net_j and activationFun
        %if output layer is using softmax, then normalize the output
        %if output layer is binary, then round the output to int after
        %softmax
        function Y = activate(X)
            Y = activate@NeuralNetwork(X);
            if obj.softmax
                Y = Y./norm(Y);
            end
            if obj.binary
                Y = round(Y);
            end
        end
    end
end
