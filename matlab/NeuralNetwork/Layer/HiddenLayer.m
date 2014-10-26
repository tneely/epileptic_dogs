classdef HiddenLayer < NeuralLayer
    %NerualLayer 
    %   Detailed explanation goes here
    
    properties
        layerType = 'hidden';
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
        function obj = HiddenLayer(S, A)
            obj@NeuralLayer(S,A)
        end
    end
end