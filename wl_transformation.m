function new_labels = wl_transformation(A, labels)

  % the ith entry is equal to the 2^(i-1)'th prime
  primes_arguments_required = [2, 3, 7, 19, 53, 131, 311, 719, 1619, ...
                      3671, 8161, 17863, 38873, 84017, 180503, 386093, ...
                      821641, 1742537, 3681131, 7754077, 16290047];

  num_labels = max(labels);

  % generate enough primes to have one for each label in the graph
  primes_argument = primes_argument_required(ceil(log2(num_labels)) + 1);
  p = primes(primes_argument);
  log_primes = log(p(1:num_labels));

  [from, to] = find(A);

  signatures = labels + accumarray(from, log_primes(labels(to)));

  [~, ~, new_labels] = unique(signatures);

end