function K = wl_kernel(A, labels, graph_ind, num_iterations, varargin)

  options = inputParser;

  options.addOptional('base_kernel', ...
                      @(A, labels, graph_ind) ...
                      linear_label_count_kernel(A, labels, graph_ind) ...
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