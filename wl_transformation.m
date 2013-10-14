function new_labels = wl_transformation(A, labels)

  log_primes = log(primes(1e4));

  [from, to] = find(A);

  signatures = labels + accumarray(from, log_primes(labels(to)));

  [~, ~, new_labels] = unique(signatures);

end