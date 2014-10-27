%%
%$\delta^{i} = D_iW_{i+1}\delta^{i + 1} if hidden layer$
%$\delta^{i} = D_lE if hidden layer$
function BPE = backproperror( input_layer, E )
%backproperror computes backpropagation error $\delta$
%   input
%           input_layer 
%           

BPE = backproperrorHelper(input_layer.downstream, E);
    
end

%%
%$\delta^{i} = D_iW_{i+1}\delta^{i + 1} if hidden layer$
%$\delta^{i} = D_lE if hidden layer$
function BPE = backproperrorHelper(layer, E)

%compute the derivative matrix
D = makeD(layer.N, layer.delta_activationfun);

%Base Case
if strcmp(layer.type, 'output')
    BPE = D*E;
else
    BPE = backproperrorHelper(layer.downstream, E);
    BPE = [D*layer.downstream.Weights*BPE(1); BPE];
end

end