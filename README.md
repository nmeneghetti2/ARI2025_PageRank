# PageRank
## Intruduction
This is an implementation of the CUR_Trans and $T^2$-Approx algorithms proposed in the paper “Efficient and Accurate PageRank Approximation on Large Graphs” published in the 2025 Proceedings of the ACM on Management of Data, and includes the competitors which are sampling-based PageRank estimations.

## Required environment


## Propose algorithms CUR_Trans and $T^2$-Approx
### SVD-Trans & CUR_Trans

> base command

```bash
# args[1]: algorithm name
# args[2]: graph path
# args[3]: output path
# args[4]: sampling ratio
# args[5]: the number of nodes in the graph
# --args[6]: If you use algorithm CUR_Trans, you also need a row sampling ratio parameter
python SVD_Trans /your_graph_path /your_output_path 0.1 1000
python CUR_Trans /your_graph_path /your_output_path 0.1 1000 0.1
```



### $T^2$-Approx

> base command

```bash
# args[1]: graph path
# args[2]: output path
# args[3]: sampling ratio
python T2.py /your_graph_path /your_output_path 0.1
```



>  If you want to sample from matrix using a different sampling probability distribution, you need to uncomment the code below.

``` python
# Calculate p-distribution (using row and column f paradigms)
col_sums = A.power(2).sum(axis=0)
row_sums = A.power(2).sum(axis=1)
p = np.multiply(col_sums, row_sums)
probabilities = p / sum(p)

# column f paradigms
# total_sums = A.power(2).sum()
# col_sums = A.power(2).sum(axis=0)
# col_distribution = col_sums / total_sums

# row f paradigms
# total_sums = A.power(2).sum()
# row_sums = A.power(2).sum(axis=1)
# row_distribution = row_sums / total_sums



# using row and column f paradigms
sampled_index = np.random.choice(A.shape[1], size=c, replace=False, p=probabilities)
# # column f paradigms
# sampled_index = np.random.choice(A.shape[1], size=c, replace=False, p=col_distribution)
# # row f paradigms
# sampled_index = np.random.choice(A.shape[1], size=c, replace=False, p=row_distribution)
# # uniform distribution
# sampled_index = np.random.choice(A.shape[1], size=c, replace=False, p=None)
```



> If you need to scale the sampled elements, you need to uncomment the following code.

``` python
## TODO If you want to do Scaling, you need the following code
# probabilities = np.sqrt(probabilities * c)
# # row traversal
# for i in range(R.shape[0]):
#     start_idx = R.indptr[i]
#     end_idx = R.indptr[i + 1]
#     for j in range(start_idx, end_idx):
#         col_idx = R.indices[j]
#         value = R.data[j]
#         R[i, col_idx] = value / probabilities[sampled_index[i]]
#
# # col traversal
# for j in range(C.shape[1]):
#     start_idx = C.indptr[j]
#     end_idx = C.indptr[j + 1]
#     for i in range(start_idx, end_idx):
#         row_idx = C.indices[i]
#         value = C.data[i]
#         C[row_idx, j] = value / probabilities[sampled_index[j]]
```



## Competitors 

> base command

``` bash
# Use Networkit to calculate the PageRank of the original graph for the ground truth of the experiment
python Competitors.py GroundTruth /your_graph_path /your_output_path

# Edge Random Sampling: The fourth parameter, theta, represents the random threshold
python Competitors.py PER_PR /your_graph_path /your_output_path 0.1

# DSPI：args[4]: alpha; args[5]: theta
python Competitors.py PER_PR /your_graph_path /your_output_path 0.1 0.1

# ApproxRank: args[4]: sampling ratio; args[5]: the number of nodes in the graph
python Competitors.py PER_PR /your_graph_path /your_output_path 0.1 1000

# LocalPR: args[4]: the number of nodes to be estimated; args[5]: edges ration
python Competitors.py PER_PR /your_graph_path /your_output_path 100 0.1

# LPRAP：args[6]: threshold
python Competitors.py PER_PR /your_graph_path /your_output_path 100 0.1 0.1
```

