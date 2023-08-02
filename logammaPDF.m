% Log-Gamma Distribution PDF
% Inputs: b, a - the two parameters of the corresponding Gamma distribution, e.g., as returned by fitdist(YOURDATA, 'Gamma')
% [In wikipedia's formulation, a is k (shape parameter) and b is theta (scale parameter)]
%            x - a vector of values at which the PDF value needs to be computed
%            lb (optional, e by default) - the base of the logarithm of the distribution
% Output: y - PDF evaluated at the values of x.
function y = logammaPDF(b, a, x, lb)

if nargin < 4
  % The analytical expression below is found in several papers on the Log-Gamma distribution:
  y = exp(a*x) .* exp(-exp(x)/b) / b^a / gamma(a);
else
  y = log(lb)*lb.^(a*x) .* exp(-1*lb.^x/b) / b^a / gamma(a);
end

