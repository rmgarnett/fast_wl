% WL_KERNEL computes the WL graph kernel between given graphs.
%
% This is an implementation of the Weisfeiler--Lehman graph kernel
% between labeled graphs. See the following paper for more
% information:
%
%   Shervashidze, N., Schweitzer, P. van Leeuwen, E.J., Mehlhorn, K.,
%   and Borgward, K.M. Weisfeiler--Lehman graph kernels. (2010).
%   Journal of Machine Learning Research 12(Sep):2539--2561.
%
% This implementation uses a fast hashing-based implementation to
% compute the Weisfeiler--Lehman graph transformation; see the
% following paper for more information:
%
%   Kersting, K., Mladenov, M., Garnett, R., and Grohe, M. Power
%   Iterated Color Refinement. (2014). AAAI Conference on Artificial
%   Intelligence (AAAI 2014).
%
% Usage:
%
%   K = wl_kernel(A, labels, graph_ind, num_iterations, varargin)
%
% Required inputs:
%
%                A: an (n x n) unweighted adjacency matrix for the
%                   desired graphs. This will typically be a
%                   block-diagonal matrix containing the adjacency
%                   matrices for each graph in each block. The
%                   graph_ind vector, defined below, indicates
%                   which graph each node belongs to.
%           labels: an (n x 1) vector of positive integer labels for
%                   each node in each graph
%        graph_ind: an (n x 1) vector indicating graph membership.
%                   Each value of graph_ind should be a positive
%                   integer indicating the ordinal number of the graph
%                   the corresponding node belongs to. Given an
%                   adjacency matrix A, a suitable vector can be found
%                   via, e.g.:
%
%                     [~, graph_ind] = graphconncomp(A, 'directed', false);
%
%   num_iterations: the number of iterations (graph transformations)
%                   to perform
%
% Optional inputs (specified as name/value pairs):
%
%   'base_kernel': a function handle to the base graph kernel to
%                  use. This kernel will be called as:
%
%                    K = base_kernel(A, labels, graph_ind),
%
%                  which should takes in A, labels, and graph_ind as
%                  defined above and should return a kernel of size
%                  (# graphs) x (# graphs).
%
%                  The default is @linear_label_graph_kernel.
%
% Outputs:
%
%   K: a (# graphs) x (# graphs) matrix containing the desired
%      graph kernel.
%
% See also WL_TRANSFORMATION, LINEAR_LABEL_GRAPH_KERNEL.

% Copyright (c) 2013--2014 Roman Garnett.

function K = wl_kernel(A, labels, graph_ind, num_iterations, varargin)

  options = inputParser;

  options.addOptional('base_kernel', ...
                      @(A, labels, graph_ind) ...
                      linear_label_graph_kernel(A, labels, graph_ind), ...
                      @(x) (isa(x, 'function_handle')));

  options.parse(varargin{:});
  options = options.Results;

  num_graphs = max(graph_ind);

  K = zeros(num_graphs);

  iteration = 0;
  while (true)
    K = K + options.base_kernel(A, labels, graph_ind);

    if (iteration == num_iterations)
      break;
    end

    labels = wl_transformation(A, labels);

    iteration = iteration + 1;
  end

end