function E = leastsquares( Y, T )
%lastsquares computes the least squares error
%   input
%           Y [1 x m] output values
%           T [1 x m] target values
%   output
%           E [1 x m] m error terms

E = .5*(Y - T).^2;

end

