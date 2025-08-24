function [y_out] = vhdl_approximate_tanh_design(x)
%  y_out = 1-(2./(power(2,((2.625)*x))+1));
y_out = tanh(x);
end
