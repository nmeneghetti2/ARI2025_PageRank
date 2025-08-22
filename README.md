# PageRank
## Intruduction
This is an implementation of the CUR_Trans and $T^2$-Approx algorithms proposed in the paper “Efficient and Accurate PageRank Approximation on Large Graphs” published in the 2025 Proceedings of the ACM on Management of Data, and includes the competitors which are sampling-based PageRank estimations.

## Contents
> CUR.py: The algorithm CUR-Trans proposed in this paper and its variant SVD-Trans.
> T2.py:  The algorithm $T^2$-Approx proposed in this paper.
> Competitors.py: The comparison algorithm in this paper.
> Poster.pdf: Display poster of main paper content
> Supplementary Material.pdf: Proofs and experiments not included in the paper due to limited page.

## Required environment
> Since the source code of the competitors are not available, we have implemented all the competitors. Specifically, algorithms DSPI and LPRAP compute PageRank values based on graph operations. They are implemented using  Networkit (10.1). Algorithms ApproxRank, SVD-Trans, CUR-Trans, and $T^2$-Approx perform matrix iterations. They are implemented using  NumPy (1.20.1) and SciPy (1.8.1).
All experiments are running on a machine with 4 Intel Xeon E7-4830 CPUs (56 cores, 2.0 GHz) and 2 TB main memory with Python (3.8.8). 

## Dataset
> We conduct evaluations on three real large graph datasets, Friendster and Orkut and UKDomain. These dataset can be download at:
Friendster: http://konect.cc/networks/friendster/
Orkut: http://konect.cc/networks/orkut-groupmemberships/
UKDomain: http://konect.cc/networks/dimacs10-uk-2007-05/

## Proposed algorithms
### CUR_Trans

```bash
# args[1]: source code file name
# args[2]: algorithm name
# args[3]: graph path
# args[4]: output path
# args[5]: sampling ratio of col
# args[6]: the number of nodes in the graph
# args[7]: sampling ratio of row
python CUR.py CUR_Trans /your_graph_path /your_output_path 0.1 1000 0.1
```

### $T^2$-Approx

```bash
# args[1]: source code file name
# args[2]: graph path
# args[3]: output path
# args[4]: sampling ratio
python T2.py /your_graph_path /your_output_path 0.1
```

### Other variants of CUR_Trans and $T^2$-Approx 

> $T^2$-Approx involve sampling operations on the transition matrix $T$, and we can use different sampling distributions. If you want to sample from matrix using a different sampling probability distribution, you need to uncomment the code below.

``` python
# Step I: Calculate the distribution we want. We propose four widely used distributions on matrix smapling.

# (1)F-norm of column and row (widely used and applied in our paper):
col_sums = A.power(2).sum(axis=0)
row_sums = A.power(2).sum(axis=1)
p = np.multiply(col_sums, row_sums)
probabilities = p / sum(p)

# (2)F-norm of column: 
# total_sums = A.power(2).sum()
# col_sums = A.power(2).sum(axis=0)
# col_distribution = col_sums / total_sums

# (3)F-norm of row: 
# total_sums = A.power(2).sum()
# row_sums = A.power(2).sum(axis=1)
# row_distribution = row_sums / total_sums

# (4)uniform distribution.

# Step II: Use different distributions.
# (1)F-norm of column and row:
sampled_index = np.random.choice(A.shape[1], size=c, replace=False, p=probabilities)

# (2)F-norm of column: 
# sampled_index = np.random.choice(A.shape[1], size=c, replace=False, p=col_distribution)

# (3)F-norm of row: 
# sampled_index = np.random.choice(A.shape[1], size=c, replace=False, p=row_distribution)

# (4)uniform distribution:
# sampled_index = np.random.choice(A.shape[1], size=c, replace=False, p=None)
```

> The low-rank approximation algorithm used in CUR_Trans and the Monte Carlo matrix multiplication algorithm used in $T^2$-Approx both recommend scaling each sampled element to obtain better approximation results. However, this is not applicable to the PageRank scenario, as detailed in the paper. Nevertheless, this project provides scaling operations for others to test and study. If you need to scale the sampled elements, you need to uncomment the following code.

``` python
# # Scaling each element in R.
# for i in range(R.shape[0]):
#     start_idx = R.indptr[i]
#     end_idx = R.indptr[i + 1]
#     for j in range(start_idx, end_idx):
#         col_idx = R.indices[j]
#         value = R.data[j]
#         R[i, col_idx] = value / row_distribution[sampled_row_index[i]]
#
# # Scaling each element in C.
# C = sp.sparse.csc_array(C)
# for j in range(C.shape[1]):
#     start_idx = C.indptr[j]
#     end_idx = C.indptr[j + 1]
#     for i in range(start_idx, end_idx):
#         row_idx = C.indices[i]
#         value = C.data[i]
#         C[row_idx, j] = value / col_distribution[sampled_col_index[j]]
```

> CUR-Trans use CUR low rank approximation method to get a smaller iteration matrix of transition matrix $T$ for PageRank, and other low rank approximation methods can replace CUR. We provide SVD as an example and propose SVD-Trans.

``` bash
# args[1]: algorithm name
# args[2]: graph path
# args[3]: output path
# args[4]: sampling ratio of col
# args[5]: the number of nodes in the graph
python CUR.py SVD_Trans /your_graph_path /your_output_path 0.1 1000
```

## Competitors 

``` bash
# args[1]: source code file name
# args[2]: algorithm name
# args[3]: graph path
# args[4]: output path

# Use Networkit to calculate the PageRank of the original graph as the ground truth of the experiment.
python Competitors.py GroundTruth /your_graph_path /your_output_path

# --------------------competitors in the paper

# DSPI：
# args[5]: alpha,
# args[6]: theta, alpha and theta together determine the sampling probability of elements.
python Competitors.py DSPI /your_graph_path /your_output_path 0.1 0.1

# ApproxRank:
# args[5]: sampling_ratio, 
# args[6]: node_num, the number of vertices in the subgraph.
python Competitors.py ApproxRank /your_graph_path /your_output_path 0.1 1000

# LPRAP：
# args[5]:sampling_num, the number of vertices in the subgraph.
# args[6]:edges_ration, the sampling ratio of edges.
# args[7]:T, purning threshold.
python Competitors.py LPRAP /your_graph_path /your_output_path 100 0.1 0.1

# ---------------------- other competitors

# LocalPR: LPRAP is an optimized version of LocalPR, so the article only compares LPRAP and not LocalPR. 
# args[5]: sampling_num, the number of vertices in the subgraph.
# args[6]: edges ration, the sampling ratio of edges.
python Competitors.py LocalPR /your_graph_path /your_output_path 100 0.1

# PER_PR: DSPI performs biased sampling on the elements in the matrix, and we have also implemented a uniform sampling version.
# args[5]: theta, the sampling ratio of sparsifying edge
python Competitors.py PER_PR /your_graph_path /your_output_path 0.1
```
