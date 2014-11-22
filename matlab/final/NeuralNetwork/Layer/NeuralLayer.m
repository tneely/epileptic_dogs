classdef(Abstract) NeuralLayer < handle
    %NerualLayer 
    %   Detailed explanation goes here
    
    properties (Abstract)
        type;%input | hidden | output
    end
    
    properties
        numSynapses;
        numNeurons;
        
        upstream = [];
        downstream = [];
        
        MWeights; %momentum weights of last trial
        Mbias; %momentum bias of last trial
        
        bias;
        Weights;%[inputs x neurons] the matrix of synaptic weights
        O;%[1 x input] the last input vector for backpropogation
        N;%[1 x neuron] array of netj for backpropogation
        
        %The activation function computes this layers output vector
        activationfun = @logsigfun;
        delta_activationfun = @delta_logsigfun;
        params_activationfun;
    end
    
    methods
        %NeuralLayer Constructor
        %input  S [2 x 1] size of the weight matrix
        %       A [a x 1] the activation function, may contain func. params
        function obj = NeuralLayer(n_in, n_neuron)            
            obj.numSynapses = n_in;
            obj.numNeurons = n_neuron;
            
            %obj.activationfun = act;      
            %obj.params_activationfun = dact;
            
            obj.Weights = (rand(obj.numSynapses, obj.numNeurons)-.5)*2;
            obj.bias = (rand(1, obj.numNeurons)-6.25)*2;
            
            obj.MWeights = 0.*obj.Weights;
            obj.Mbias = 0.*obj.bias;
        end
        
        %activate computes the output vector from the layer
        %input X [1 x numInputs] the input vector into each synapse
        %output Y [1 x neurons] the output vector from the layer
        %
        %uses net_j and activationFun
        function Y = activate(obj, X)
            obj.O = X;
            obj.N = obj.Net(obj.O) + obj.bias;
            Y = logsigfun(obj.N);
        end
        
        %net_j computes input vector for the layer
        %input X [1 x inputs] the input vector into each synapse
        %output [1 x neurons] the summed input into each neuron
        function N = Net(obj, O)
            N = O*obj.Weights;
        end
        
        %predictHelper is the recursive helper to predict
        %input  X [1 x num upstream neurons]
        %       layer the current layer we are computing for
        %output Y [1 x values]
        function Y = predictHelper(obj, X)
            %Base Case: output layer
            if strcmp(obj.type, 'output')
                Y = obj.activate(X);
            %Recursive Case: non output layer
            else
                X = obj.activate(X);
                Y = obj.downstream.predictHelper(X);
            end
        end
    end
    
        
end