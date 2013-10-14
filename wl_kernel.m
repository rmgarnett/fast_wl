function K = wl_kernel(A, labels, graph_ind, num_iterations, varargin)

  options = inputParser;

  options.addOptional('base_kernel', ...
                      @(counts) (counts * counts'), ...
                      @(x) (isa(x, 'function_handle')));

  options.parse(varargin{:});
  options = options.Results;

  num_graphs = max(graph_ind);

  K = zeros(num_graphs);

  iteration = 0;
  while (true)
    counts = accumarray([graph_ind, labels], 1);

    K = K + base_kernel(counts);

    if (iteration == num_iterations)
      break;
    end

    labels = wl_transformation(A, labels);
  end

end