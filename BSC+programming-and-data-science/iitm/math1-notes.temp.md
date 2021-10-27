
---

## Lec 67 - Directed Acyclic Graphs

* cycle must follow *one* direction only.
> example:
>>tasks and dependenceies - constrain on sequences
>>> interior construction of office


## Lec 68 - Topological Sorting
> given a DAG, enumerate V=\{0,1,2,...n-1\} such that ∀ (i,j) ∈ E , i appears before j.
>> transitivity holds in scheduling therefore there is no way to topologically sort a directed graph with cycle
>>> all DAGS can be topologically sorted .

### algorithm
* a vertex with no dependencies has in degree =0
	* every DAG has a zero-dependency vertex.
	* else in parent backtracking there seems to be a cycle in the graph
* choose zero vertex, add it to the enumeration, delete it and its edges from the DAG (update the indegrees of its neighbours), resulting in another DAG. repeat till the reulting DAG is a null graph.


## Lec 69 - Longest Paths in DAGs
## Lec 70 - Transitive Closure
## Lec 71 - Matrix Multiplication
## Lec 73 - Single Source Shortest Paths
## Lec 72 - Shortest Paths in Weighted Graphs
## Lec 74 - Single Source Shortest Paths with Negative Weights
## Lec 75 - All-Pairs Shortest Paths
## Lec 76 - Minimum Cost Spanning Trees
## Lec 77 - Minimum Cost Spanning Trees - Prim's Algorithm
## Lec 78 - Minimum Cost Spanning Trees - Kruskal's Algorithm