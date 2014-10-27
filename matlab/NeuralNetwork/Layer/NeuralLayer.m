classdef(Abstract) NeuralLayer < Handle
    %NerualLayer 
    %   Detailed explanation goes here
    
    properties (Abstract)
        layerType;%input | hidden | output
    end
    
    properties
        numSynapses;
        numNeurons;
        
        Weights;%[inputs x neurons] the matrix of synaptic weights
        O;%[1 x input] the last input vector for backpropogation
        N;%[1 x neuron] array of netj for backpropogation
        
        %The activation function computes this layers output vector
        activationfun;
        delta_activationfun
        params_activationfun;
    end
    
    methods
        %NeuralLayer Constructor
        %input  S [2 x 1] size of the weight matrix
        %       A [a x 1] the activation function, may contain func. params
        function obj = NeuralLayer(S, A)
            obj.activationFun = A(1);      
            obj.activationFunParams = A(2);
            if size(A) > 2
                obj.params_activationfun = A(3);
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
            obj.O = X;
            obj.N = Net(X);
            obj.prev_net_j = obj.N;
            Y = obj.activationFun(obj.N, obj.activationFunParams);
        end
        
        %net_j computes input vector for the layer
        %input X [1 x numInputs] the input vector into each synapse
        %output [1 x neurons] the summed input into each neuron
        function N = Net(X)
            N = X*obj.Weights;
        end
        
    end
    
    methods (Static)
        function W = seedWeights(S)
            W = rand(S(1), S(2));
        end
    end
    
        
end