fast_wl
=======

A fast MATLAB implementation of the one-dimensional Weisfeiler--Lehman
graph transformation and associated kernel. See the following paper
for further information:
> Shervashidze, N., Schweitzer, P. van Leeuwen, E.J., Mehlhorn, K.,
> and Borgward, K.M. "Weisfeiler-Lehman graph kernels." (2010).
> Journal of Machine Learning Research 12(Sep):2539--2561.

This implementation uses a fast perfect hash for performing the
transformation. Consider a node ![x in G][1], and let ![l(x)][2] and
![N(x)][3] represent the label of ![x][4] and neighborhood of ![x][4],
respectively.  Let ![p(i)][5] represent the ith prime.  The hash for
![x][4] is given by

![h(x) = l(x) + \sum_{y \in N(x)} log(p(l(y)))][6]

It can be easily shown that, given two nodes ![(x, y) in V(G)][7],
![h(x) = h(y)][8] if and only if:

- ![l(x) = l(y)][9]
- ![N(x)][3] and ![N(y)][10] contain the same labels with the same
  cardinality,

that is, ![h(x)][11] gives unique values to unique WL signatures.  The
use of ![h(x)][11] is much faster than the typical string hashes used
for completing the WL transformation.

Usage
-----

See the help for `wl_transformation.m` for usage information.

[1]: http://latex.codecogs.com/svg.latex?x%20%5Cin%20V%28G%29
[2]: http://latex.codecogs.com/svg.latex?l%28x%29
[3]: http://latex.codecogs.com/svg.latex?N%28x%29
[4]: http://latex.codecogs.com/svg.latex?x
[5]: http://latex.codecogs.com/svg.latex?p%28i%29
[6]: http://latex.codecogs.com/svg.latex?h%28x%29%20%3D%20l%28x%29%20%2B%20%5Csum_%7By%20%5Cin%20N%28x%29%7D%20%5Clog%28p%28l%28y%29%29%29
[7]: http://latex.codecogs.com/svg.latex?x%2C%20y%20%5Cin%20V%28G%29
[8]: http://latex.codecogs.com/svg.latex?h%28x%29%20%3D%20h%28y%29
[9]: http://latex.codecogs.com/svg.latex?l%28x%29%3Dl%28y%29
[10]: http://latex.codecogs.com/svg.latex?N%28y%29
[11]: http://latex.codecogs.com/svg.latex?h%28x%29
