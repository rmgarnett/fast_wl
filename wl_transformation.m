% Perform the one-dimensional Weisfeiler--Lehman (WL) transformation
% on a labeled graph G using a fast perfect hash.
%
% Consider a node x in G, and let l(x) and N(x) represent the label of
% x and neighborhood of x, respectively.  Let p(i) represent the ith
% prime.  The hash for x is given by
%
%   h(x) = l(x) + \sum_{y \in N(x)} log(p(l(y)))
%
% It can be easily shown that, given two nodes (x, y) in V(G),
% h(x) = h(y) if and only if:
%
%   - l(x) = l(y)
%   - N(x) and N(y) contain the same labels with the same cardinality,
%
% that is, h(x) gives unique values to unique WL signatures.  The
% use of h(x) is much faster than the typical string hashes used
% for completing the WL transformation.
%
% function new_labels = wl_transformation(A, labels)
%
% inputs:
%        A: an unweighted adjacency matrix for G.  If possible, A
%           should be a sparse matrix; e.g., sparse(A > 0).
%   labels: a vector of integer node labels
%
% outputs:
%   new_labels: a vector containing the new compressed labels after
%               one step of the 1d WL transformation
%
% Copyright (c) Roman Garnett, 2013--2014

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

  [~, ~, new_labels] = unique(signatures);

end