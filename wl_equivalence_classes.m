% WL_EQUIVALENCE_CLASSES computes 1d WL "color classses" for a graph.
%
% Given an (optionally labeled) graph G, this computes the
% Weisfeiler--Lehman equivalence classes of the nodes of G by
% iterating the one-dimensional Weisfeiler--Lehman graph
% transformation until stability is reached.
%
% This implementation uses a fast hashing-based implementation to
% compute the Weisfeiler--Lehman graph transformation; see the
% following paper for more information:
%
%   Kersting, K., Mladenov, M., Garnett, R., and Grohe, M. Power
%   Iterated Color Refinement. (2014). AAAI Conference on Artificial
%   Intelligence (AAAI 2014).
%
% This implementation supports an initial labeling of the nodes; the
% traditional color refinement algorithm begins by labeling each node
% with the same initial color. Omitting the "labels" argument acheives
% this behavior.
%
% Usage:
%
%   equivalence_classes = wl_equivalence_classes(A, labels)
%
% Inputs:
%
%        A: an (n x n) unweighted adjacency matrix for the desired
%           graph.
%   labels: (optional) an (n x 1) vector of positive integer labels
%           for each node in the graph (default: ones(n, 1))
%
% Outputs:
%
%   equivalence_classes: a vector of the color classes for each node in
%                        the graph.
%
% See also WL_TRANSFORMATION.

% Copyright (c) 2014 Roman Garnett.

function equivalence_classes = wl_equivalence_classes(A, labels)

  % if no labels given, use initially equal labels
  if (nargin < 2)
    labels = ones(size(A, 1), 1);
  end

  equivalence_classes = zeros(size(labels));

  % iterate WL transformation until stability
  while (any(labels ~= equivalence_classes))
    equivalence_classes = labels;
    labels = wl_transformation(A, labels);
  end

end