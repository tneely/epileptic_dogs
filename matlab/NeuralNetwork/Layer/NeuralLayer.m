classdef NeuralLayer
    %NerualLayer 
    %   Detailed explanation goes here
    
    properties
        numSynapses;
        numNeurons;
        
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
        function obj = NeuralLayer(S, A)
            obj.activationFun = A(1);
            if size(A) > 1
                obj.activationFunParams = A(2);
            end
            
            obj.numSynapses = S(1);
            obj.numNeurons = S(2);
            
            obj.Weights = seedWeights(S);
        end
        
        %activate computes the output vector from the layer
        %input X [1 x numInputs] the input vector into each synapse
        %output Y [1 x neurons] the output vector from the layer
        %
        %uses net_j and activationFun
        function Y = activate(X)
            N = net_j(X);
            obj.prev_net_j = N;
            Y = obj.activationFun(N, obj.activationFunParams);
        end
        
        %net_j computes input vector for the layer
        %input X [1 x numInputs] the input vector into each synapse
        %output [1 x neurons] the summed input into each neuron
        function N = net_j(X)
            N = X*obj.Weights;
        end
        
    end
    
    methods (Static)
        function W = seedWeights(S)
            W = rand(S(1), S(2));
        end
    end
    
        
end