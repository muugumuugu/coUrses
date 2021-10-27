---

# WEEK 1

---

---

## Lec 01 - Natural Numbers and their Operations

>ℕ --> {0,1,2,3,....}
>>discrete set

### Operations of ℕ

+ \+
+ \-
+ \*
+ /
+ a|b a is a *divisor* of b --> output *True* / *False*
+ %

### Primes

+ Sieve of Erothenes
+ Unique Factorization Th.

---

## Lec 02 - Rational Numbers

+ GCD
+ Density of ℚ

---

## Lec 03 - Real Numbers

### Important Irrationals

+ Polynomial
	+ √2, √3 , etc
+ Trancendental
	+ π
	+ e

---

## Lec 04 - Set Theory

### Properties of a set

+ No duplicates included
+ order irrelavent

>subset --> set formed from selected elements of a superset
>> equivalent to ***binary sequences*** of the length #cardinality-of-superset

### Special Sets

+ φ --> Empty Set . Subset of All Sets Vacously.
+ ℙ(X) --> Set Of all Subsets of X.

---

## Lec 05 - Construction of Sets and Set Operations

>Set Comprehension
>> { *g*(x) | *some condition* on x, where x ∈ to a *certain* ***predifined*** *set* }}
>>> g              --> *transform*\
>>> some condition --> *filter*\
>>> predifined set --> *generator*

>Intervals

>Operations
>> Unions\
>> Intersections\
>> Set Difference\
>> Complementation relative to a Universal Sets

---

## Lec 06 - Relations

> A filtered subset of a Cartesion Product b/w sets.
>> Filter equips the subset with a binary operation hat acts on the first element of all tuples to result in the second element.
> Can also be denoted by a node-edge (*bipartite*) graph between the vertices taken from set-1 to set-2.
>> two vertices v<sub>a</sub> v<sub>b</sub>, representing  a ∈ A & b ∈ B respectively , are connected iff aRb. that is the relation holds for that pair.

###examples

+ Square in 2D real plane is a relation on ℝ<sup>2</sup>Xℝ<sup>2</sup>Xℝ<sup>2</sup>Xℝ<sup>2</sup> , and also on ℝ<sup>8</sup>. The relation is that the tuple defines being a corner.

###equivalence relations
+ partitions the set in question (mutually disjoint partitions, with covering union.)
+ is reflexive , symetric and transitive.

---

## Lec 07 - Functions

> 𝑓 : X → Y, a subset of a relation where the first element is resticted to no repetations. THis constricted subset is like a Map from set of elements in X to Y.
>>the set of first elements of tuples: Domain on which function acts.
>>the set of second elements of tuples: Range of function.

###Bijections

+ Injective : One-One.
+ Surjective : Onto.

###Tables As Relations.
> Extended relations . Each entry a n-tuple, where elements are mutually related by some condition. the set of such conditions is fixed and ordered and is consistent aross rows
>> If one column is unique it can be used as a key, and if two tables share sucha column, a new table can be created by performing a ***join***, that is extending the relations via the key element, and selecting different columns from the two or more tables.
?????????/


---

## Lec 08 - Prime Numbers

+ Euclid's Infinity of Primes.
+ π(x) = # of primes < x
+ Prime Number Th. - π(x)--> x/ln(x) as x-->∞

---

## Lec 09 - Why is a Number Irrational?

>The Real line is continous but some points on the line like √2, obtained from the pythogorean unit right triangle, cannot be represented as a ratio,
hence the need for irrational.

---

## Lec 10 - Sets V/S Collections

> ℕ is defined in set theory as
>> 0 --> φ\
>>1 --> {0, {0}} ==> {φ. {φ}}\
>>2 --> {1, {1}} ==> {φ, {φ} ,{φ, {φ}}}\
>> j+1 --> {j, {j}}

>>Arithmetic Operations are defined in terms of Set Building operations (Union, Intersection & Cartesion Product)

### Is there a Set of All Sets??? - Russel's Paradox

>generating by set comprehension. we can have a set of all sets that do not contain themselves then, this set contain itself impies that it does not contain itself and hence the paradox.
>> so therefore it is not definitive to form a set of all sets, and unrestricted comprehension will always lead to a paradox.

> In general call any unsuitable collection a ***Class***.

---

## Lec 11 - Degrees of Infinity

>Enumaration - ***bijection*** with ℕ
>> Enumerable Sets are called Countable. They may be finite or infinite

### ℝ is uncountably infinit

> proof by diagonalization (enumarating sequences of {1,0} and picking the sequence off the diagonal --> negating it and hence finding a sequence that had not been counted

### Continuum Hypothesis

> Is there a set with cardinality between that of ℕ  and ℝ?
>> *Independent of Set Theory Axioms*, the existence of such a set cannot be proved or disproved.

---

# WEEK 2

---

---

## Lec 12 - Rectangular Co-Ordinate System

> Based on assosciating ***ℝ*** with a ***2d grid of perpendicular lines*** (axes)

---

## Lec 13 - Distance Formula

d=√∑(x<sub>i<sub>1</sub></sub>-x<sub>i<sub>2</sub></sub>)<sup>2</sup>

---

## Lec 14 - Section Formula

(m<sub>2</sub>x⃗<sub>1</sub>+ m<sub>1</sub>x⃗<sub>2</sub>)/(m<sub>1</sub>+m<sub>2</sub>)

---

## Lec 15 - Area of a Triangle

---

## Lec 16 - Slope of a Line

> Gradient or Inclination with +ve X Axis

>***m***= <i>tan</i>(θ) , θ measured from left to right between + ve X-axis and line

---

## Lec 17 - Parallel and Perpendicular Lines

+ Parralelness --> m<sub>1</sub>=m<sub>2</sub>
+ Perpendicularity --> m<sub>1</sub>=-1/m<sub>2</sub>

###Angle of Intersection

> θ = (m<sub>1</sub>-m<sub>2</sub>)/(1+ m<sub>1</sub>m<sub>2</sub>)

---

## Lec 18 - Represantation of a Line-1

+ Point on a Lines
+ Horizontal and Vertical Lines
+ Point-Slope Form
+ Two-Point Form

---

## Lec 19 - Representation of a Line-2 and Applications of Rectangular Co-ordinated.

+ Slope-intercept form
+ XY- intercept frm

---

# WEEK 3

---

---

## Lec 20 - General Equation of a Line

> a<sub>i</sub>x +b<sub>i</sub>x+c<sub>i</sub>=d

---

## Lec 21 - Equation of Perpendicular & Parallel Lines in General Form

+ parallel : a<sub>1</sub>/a<sub>2</sub>=b<sub>1/</sub>/b<sub>2</sub>
+ perpendicular a<sub>1</sub>a<sub>2</sub>+b<sub>1/</sub>b<sub>2</sub>=0

---

## Lec 22 - Eqn of line Perpendicular to another line through a given Point

---

## Lec 23 - Distance of Point from Line

---

## Lec 24 - Straight Line Fit

###SSE
>Sum of Squares of Errors
>>∑(xᵢ - X)²

---

# WEEK 4

---

---

## Lec 25 - Quadratic Functions ,examples of QF, SLope of a QF

+ Parabolas
+ Axis of symetry
+ Vertex
+ Maximum/MinimumS
+ Tangent



---

## Lec 26 - Solution of a QE using Graph, Slope -> Line & Parabola

+ use zeroes of QF to get roots of QE.
+ Sensitivity of change in run in terms of the rise --> slope
+ derievative
+ vertex co-ors by setting slope
+ Surface Of Revolution.


---

## Lec 27 - Soln of QE using factorization

+ intercept form
	+ y=a(x-p)(x-q)
+ FOIL
	+ firstouterinnerlast
	+ sum/product method

---

## Lec 28 - Soln of QE using square method.

> complete the square.

---

## Lec 29 - Quadratic Formula

(-b ± √(b²-4ac))/2a

---

## Lec 30 - Polynomials

>∑ a<sub>i</sub>x<sub>i</sub><sup>p<sub>i</sub></sup>
>> p<sub>i</sub> ∈ ℤ

---

## Lec 31 - Degree of polynomial

> degree of zero polynomial is undefined

---

## Lec 32 - Algebra of polynomials --> + & -

---

## Lec 33 - Algebra of polynomials --> *

---

## Lec 34 - Algebra of polynomials --> /

---

## Lec 35 - division algorithm

> Rational Functions

---

## Lec 36 - Graphs of Polynomials - > Identification/ Characteriztion

> the curve of polynomials is always smooth( continous without sharp corners).

---

## Lec 37 - Zeroes of Polynomial Functions

> values where the function cuts the x axis, that is x ∋ f(x)=0
## Lec 38 - Graphs of Polynomials - Multiplicities

+ even multiplicity of root --> bounces off of x-Axis.
+ odd multiplicity of root --> crosses X axis

---

## Lec 39 - Graphs of Polynomials - Behavior at X-intercepts

> use bounces and crossings to predict factor pattern.
---

## Lec 40 - Graphs of Polynomials - End behavior

+ for even degree polynomials both -∞ and +∞ have symetrical asymptotes, either both +∞ or both -∞
+ for odd degree polynomials both -∞ and +∞ have mirroring asymptotes, one +∞ and the other -∞
+ the sign depends on the sign of the coefficient of the highest power term's coeffficient's sign.

---

## Lec 41 - Graphs of Polynomials - Turning points

>Turning Point
>> Point at which graph changes Direction, that is f'(x) changes sign.

> Max num of turning points of  a polynomial of degree n
>> **n-1**
>>> proof using calculas, intuition: can have max n roots, and has to change direction to attain same value=0 again and again.

---

## Lec 42 - Graphs of Polynomials - Graphing & Polynomial creation

+ Basic interpolation and solving for zeroes --> graphing
+ Creation --> spot zeroes and resolve factors using intercept behaviours.

---

---

# WEEK 5

---

---

## Lec 43 - One-to-One Function - Definition & Tests

> f(x)=f(y)↔x=y

+ Vertical Line Test -> check if graph is a function
+ Horizontal Line Test -> check if function is 1-1.
---

## Lec 44 - One-to-One Function - Examples & Theorems


+ Proof of HLT
---

## Lec 45 - Exponential Functions - Definitions

+ f(x)=a<sup>x</sup> where a≠1 (gives constant function) & a>0
+ to the power of an irrational is vaild due to convergence of series.
+ Domain = ℝ

---


## Lec 46 -  Exponential Functions - Graphing

### End Behaviour

| # | a>1 | 0< a <1|
| --- | --- | --- |
|+∞| ∞|0|
|-∞|0|∞|

+ y intercept = 1
+ x -intercept = NILL , asymptotic behaviour --> y=0 : horizontal asymptote
---

## Lec 47 - Natural Exponential Function

> (1+x/n)<sup>n</sup>-->e<sup>x</sup>
+ continous compounding amount=e<sup>rt</sup>
+ area under the curve `y=1/x` between 1 and e = 1 unit.


---

## Lec 48 - Composite Functions

> fog(x)=f(g(x))

---

## Lec 49 - Composite Functions - Examples

---

## Lec 50 - Composite Functions - Domain

> Domain= {x ∋ x ∈ D(g) && g(x) ∈ D(f) }

---

## Lec 51 - Inverse functions

+ f<sup>-1</sup>of(x)=fof<sup>-1</sup>(x)=x
+ reflection of  the function about x=y


---

WEEK 6

---

---
## Lec 52 - Logarithmic Functions

Inverse of
>> f(x) = a<sup>x</sup> ; a≠1 , a>0
>>> log<sub>a</sub>x

### basically

x=a<sup>y</sup> ⇐⇒ y=log<sub>a</sub>(x)

---

## Lec 53 - Logarithmic Functions - Graphs

+ vertical asymptote.
+ no y intercept
+ if a>1 function is increasing
+ if a>1 function is decreasing

> ln (x) --> natural base (e base) logarithm

---

## Lec 54 - Solving Exponential Equations
> computational excercises

---

## Lec 55 - Logarithmic Functions - Properties  - 1

* inverse of the exponential function
* logₐ1=0
* logₐa=1
* logarithmic arithmetic, for any base - slide rule rules ;)
	* log(MN)=logM+logN
	* log(M/N)=logM-logN
	* log(Mʳ)=rlog(M)
---

## Lec 56 - Logarithmic Functions - Applications

> simple computations

---

## Lec 57 - Logarithmic Functions -Properties - 2
> Base conversions
logₐx=logₚx/logₚa

---

## Lec 58 - Logarithmic Equations
>computational excercises
---

WEEK 7

---

---

## Lec 59 - Introduction to Graphs
### Graph = (V,E)
+ V = set of vertices / nodes
+ E = set of edges, is a subset of VxV, that is, it is a binary relation on the nodes

#### Directed Graph
+ (v,v') ∈ E doesnot ⇒ (v',v) ∈ E
#### Un-Directed Graph
+ eg -freindships
+ (v,v') ∈ E  ⇒ (v',v) ∈ E
+ effectively (v,v') is the same edge as (v',v)

### Path
* sequence of vertices connected by edges.
* no vertice is re[eated
* every adjacent vertice in the seqeunce share an edge

### walk
* path with freedom of repeating vertices.


#### reachable vertex
* v is reachable from u if there is a path from   u to v.

#### connected graph
* example flight landings
* every vertice is reachable from every other vertice

---

## Lec 60 - Some general graph problems

### map coloring
+ example min classroom for overlapping timeslots
* states that share a border should be different color
* create a graph
	* each state = vertex
	* edge relation = sharing border
	* problem becomes assigning colors to nodes so that endpoins of an edge have diff colors.
	* for planar graphs , 4 colors suffice. -- Four color theorem

### vertex covering
* example= installing cct cameras
	+ vertices = intersections of coridors
	+ Edges = corridor segments connecting intersections
* smallest set of V to cover all the edges

### independent set
* example group dances
	* vertices = dances
	* edges = have common dancers
	* dances we can have so as to have one dancer perform only once
* set of vertices such as none of them share an edge

### matching
* example - class project
	* group of freinds
* subset of E of mutually disjoint edges
* maximal matching, max cardinality matching
* perfect matching, covers all vertices.

---

## Lec 61 - Representation of graphs

### adjacency matrix
* map vertex names to integer indices
* Matrix entry (i,j) = 1 if (vᵢ,vⱼ) is an edge , 0 otherwise
* columns represent incoming edges
* rows represent outgoing edges
* wastes lots of space because typically |E|<< n²
>degree
>>d(v)= number of edges incident on i

### adjacency list
> list of neighbour indices for any vertices
>> time costly for neighbourhood scanning, etc.

--

## Lec 62 - Breadth-first neighbour search

* do it level by level
* implement using queue(FIFO)
* visit closest ( 1-step away) neighbours and mark them for exploration by adding them to the queue.
* repeat closest neighbour exploration for each item in queue, dequeuing it and flaging it as visited,till queue is empty, adding to queue only unvisited neighbours.
* necessarily mark each visited node with a flag so as to not loop infinitely.
* to store and extract path --> store parents, while exploring nearest neighbours, store parent in addition to flagging the neighbour visited.
* can also store level insted of visited flag --> unvisited =level -1
* on exploration of each item's nearest neighbours, while adding parent increment level.

---

## Lec 63 - Depth-first search
* implement using stack (LIFO)
* explore fully till the end a neighbour to its fring end and then back track to the parent and explore its other neighbours
* keep backtracking and exploring till u reach back the root, and it has no new neighbours to explore.

### uses
* find *cut vertices* - vertices which connect the graph, on deleting the graph no longer remains connected.
* find bridge - edges that connect the graph.
* cannot find shortest path :(


---

## Lec 64 - Applications of BFS and DFS-1
1. From bfs parent list --> get shortest path of unweighted graph.
2. finding components of a graph. (mutually unconnected maximal connected subgraphs)
	a. starts bfs/dfs at vertex 0  -- initialize component number 0 and assign it to each node as u visit it.
	b. increment component number and start scan on smallest unvisited node.
2. detecting cycles. - walk that ends on the same vertex, without repeating an edge
	+ simple cycle - only repeated vertice is the start/end.
	+ maintain a DFS counter that is incremented both at start and end of exploring a node
	+ assign nodes these entry and exit numbers

### tree
1. minimally connected graph.
2. edges explored by a BFS form one tree per component.
3. collection of trees= forest.
4. N vertice tree necessarily has n-1 edges.
5. acyclic graph.


* any non tree edge creates a cycle.



## Lec 65 - Applications of BFS and DFS-2
### directed cycles
### non-tree edges
1. Forward edges
2. Backward edges -- form cycles
3. Cross edged - across branches
#### classifying using dfs numbers
1. forward :Interval  \[pre(start),post(start)\] contains \[pre(end),post(end)\]
2. backward:Interval  \[pre(end),post(end)\] contains \[pre(start),post(start)\]
3. cross :Intervals  \[pre(start),post(start)\] & \[pre(end),post(end)\] are disjoint.
### strong connections
two vertices have both paths from v1 to v2 and v2 to v1.
#### Strongly Connected Components:
> directed graph decomposition


































































<!------------------------------eof-------->