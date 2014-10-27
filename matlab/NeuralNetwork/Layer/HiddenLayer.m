classdef HiddenLayer < NeuralLayer
    %NerualLayer 
    %   Detailed explanation goes here
    
    properties
        layerType = 'hidden';
        numSynapses;
        numNeurons;
        
        upstream;
        downstream;
        
        Weights;%[inputs x neurons] the matrix of synaptic weights
        
        %The activation function computes this layers output vector
        activationfun;
        delta_activationfun;
        params_activationfun;
    end
    
    methods
        %NeuralLayer Constructor
        %input  S [2 x 1] size of the weight matrix
        %       A [a x 1] the activation function, may contain func. params
        function obj = HiddenLayer(S, A, u)
            obj@NeuralLayer(S,A)
            obj.upstream = u;
            obj.downstream = nan;
        end
    end
end