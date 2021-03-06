% LUSOLT Sparse LU solver for A'x=b
% USAGE
%   x=lusolt(ALU,b);
% INPUTS
%   ALU      : cell array containing factorization of A
%                obtained from luget
%   b        : dense matrix (n x m)
% OUTPUT
%   x        : dense matrix (n x m)
%
% To solve A'x=b use
%   ALU=luget(A); x=lusolt(ALU,b);
% Note that this is basically equivalent to x=(b'/A)' except that the latter
% refines x using iterative refinement. To accomplish this one could use
%   ALU=luget(A); x=lusolt(ALU,b); x=x+lusolt(ALU,b-A'*x);  
%
% see luget for description of ALU
function x=lusolt(ALU,b)
if ~isa(ALU,'cell')
  error('ALU must be a cell array: use luget to define ALU')
end
m=length(ALU);
switch m
      case 2
        x=(b'/ALU{2})/ALU{1};
      case 3
        x=((b'/ALU{2})/ALU{1})*ALU{3};
      case 4
        x=(((b'/ALU{4})/ALU{2})/ALU{1})*ALU{3};
      otherwise
        error('LU information is not properly specified')
end
x=x';