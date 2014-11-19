function E = leastsquares( T, Y )
%lastsquares computes the least squares error
%   input
%           Y [1 x m] output values
%           T [1 x m] target values
%   output
%           E [m x 1] m error terms

E = (.5*(T - Y).^2).';
end

