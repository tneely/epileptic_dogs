%%
%$\delta^{i} = D_iW_{i+1}\delta^{i + 1} if hidden layer$
%$\delta^{i} = D_lE if hidden layer$
function BPE = backproperror( input_layer, E )
%backproperror computes backpropagation error $\delta$
%   input
%           input_layer 
%           

BPE = backproperrorHelper(input_layer.downstream, E, 1);
    
end

%%
%$\delta^{i} = D_iW_{i+1}\delta^{i + 1} if hidden layer$
%$\delta^{i} = D_lE if hidden layer$
function BPE = backproperrorHelper(layer, E, i)

%compute the derivative
D = makeD(layer.N, layer.delta_activationfun);

%Base Case
if strcmp(layer.type, 'output')
    BPE{i} = (E).';
else
    BPE = backproperrorHelper(layer.downstream, E, i + 1);
    size(layer.downstream.Weights)
    size(D)
    BPE{i} = (D*layer.downstream.Weights*BPE{i+1});
end

end