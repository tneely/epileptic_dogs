%{
    Defines effective correlation dimension feature to be used in neural network from 
    given ChannelxTime matrix segment. 
%}

function D = efd(X) 

    function C = corrSum(r,X)
        
        N = size(X,1); %total channels
        inner = 0;
        
        for i = 1:N-1
            
            for j = i+1:N
                inner = inner + heaviside(r - norm(X(i,:) - X(j,:), Inf)); %max norm
            end
            
        end  
        
        C = 1/(N*(N-1)) * inner;
    end

    r = sym('r');
    D = limit(log(corrSum(r,X))/log(r), r, 0, 'right');

end