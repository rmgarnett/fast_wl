% LINEAR_LABEL_GRAPH_KERNEL simple kernel between labeled graphs.
%
% This is an implementation of a simple kernel between labeled
% graphs for use as a base kernel in, e.g., wl_kernel.
%
% Given two labeled graphs G_1 and G_2, we define
%
%   K(G_1, G_2) = \sum_i N_i(G_1) * N_i(G_2),
%
% where the sum ranges over the labels and N_i(G) is the number of
% nodes in G with label i.
%
% Usage:
%
%   K = linear_label_graph_kernel(~, labels, graph_ind)
%
% Inputs:
%
%      labels: an (n x 1) vector of positive integer labels for each
%              node in each graph
%   graph_ind: an (n x 1) vector indicating graph membership. Each
%              value of graph_ind should be a positive integer
%              indicating the ordinal number of the graph the
%              corresponding node belongs to. Given an adjacency
%              matrix A, a suitable vector can be found via, e.g.:
%
%                [~, graph_ind] = graphconncomp(A, 'directed', false);
%
% Outputs:
%
%   K: a (# graphs) x (# graphs) matrix containing the desired
%      graph kernel.
%
% See also WL_KERNEL.

% Copyright (c) 2013--2014 Roman Garnett.

function K = linear_label_graph_kernel(~, labels, graph_ind)

  counts = accumarray([graph_ind, labels], 1);

  K = counts * counts';

end