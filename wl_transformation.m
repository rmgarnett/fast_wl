% WL_TRANSFORMATION computes the 1d WL transformation on a labeled graph.
%
% This is an implementation of the one-dimensional Weisfeiler--Lehman
% (WL) transformation on a labeled graph G using a fast perfect hash;
% for more details, see
%
%   Kersting, K., Mladenov, M., Garnett, R., and Grohe, M. Power
%   Iterated Color Refinement. (2014). AAAI Conference on Artificial
%   Intelligence (AAAI 2014).
%
% Consider a node x in G, and let l(x) and N(x) represent the label of
% x and neighborhood of x, respectively. Let p(i) represent the ith
% prime. The hash for x is given by
%
%   h(x) = l(x) + \sum_{y \in N(x)} log(p(l(y)))
%
% It can be easily shown that, given two nodes (x, y) in V(G),
% h(x) = h(y) if and only if:
%
%   - l(x) = l(y)
%   - N(x) and N(y) contain the same labels with the same cardinality,
%
% that is, h(x) gives unique values to unique WL signatures. The use
% of h(x) is much faster than the typical string hashes used for
% completing the WL transformation.
%
% Usage:
%
%   new_labels = wl_transformation(A, labels)
%
% Inputs:
%
%        A: an unweighted adjacency matrix for G. If possible, A
%           should be a sparse matrix; e.g., sparse(A > 0).
%   labels: a vector of integer node labels
%
% Outputs:
%
%   new_labels: a vector containing the new compressed labels after
%               one step of the 1d WL transformation
%
% See also WL_KERNEL.

% Copyright (c) 2013--2014 Roman Garnett.

function new_labels = wl_transformation(A, labels)

  % the ith entry is equal to the 2^(i-1)'th prime
  primes_arguments_required = [2, 3, 7, 19, 53, 131, 311, 719, 1619, ...
                      3671, 8161, 17863, 38873, 84017, 180503, 386093, ...
                      821641, 1742537, 3681131, 7754077, 16290047];

  num_labels = max(labels);

  % generate enough primes to have one for each label in the graph
  primes_argument = primes_arguments_required(ceil(log2(num_labels)) + 1);
  p = primes(primes_argument);
  log_primes = log(p(1:num_labels))';

  signatures = labels + A * log_primes(labels);

  % ignore differences beyond the 10th decimal place
  signatures = round(signatures * 1e10);

  % map signatures to integers counting from 1
  [~, ~, new_labels] = unique(signatures);

end