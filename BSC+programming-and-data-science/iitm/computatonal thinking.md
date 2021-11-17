# playlist 

[yt](https://www.youtube.com/playlist?list=PLZ2ps__7DhBYSzaAFqpyQKqmoni-EefS7)
---

# data parsing and cleanup
main goal:
	make a subset of data from the available set
## running examples
+ simplified reportcards
+ simplified shopping reciepts
+ words - letters and pos.

---
# Variables, Iterators and Filtering

+ iterator goes across the data set ( or a filtered subset of it. (like case in statistics).
+ variables value is altered according to the value provided by the iterator.
+ one iteration can alter multiple variables.
+ important part is iteration pattern, ale initialization and variable initializzation
+ filtering means selecting a susbset of the data based on the value of one of the case-variabled (attribute of that data entry).
+ we can do multiple filters together, and nest the filtering within the iteration also.

---
# flowcharts

## Symbols
+ Processs : Process/Activity - Operation that CHanges Vallue
+ Arrow : Connects things and shows order
+ Diamond : Decision / Conditional
+ Rounded Rectangle : Terminal - Indicates start or end of algorithm.

## Generic Flowchart for Iteration

![iteration algorithm](imgs/iteration-alg.png)

which is simply a pictorial representation of

```
================================
st   =>   start    : START
e    =>   end      : END
op1  =>   operation: Initialize Variables
op2  =>   operation: mark element a visited
op3  =>   operation: move element to checked stack
op4  =>   operation: update variables with data from element
cond1=> condition: are there unchecked elements in the iterable set.
cond2=> condition: element passes through filter condition
------------------------------------
st->op1->cond1
cond1(no)->e(right)
cond1(yes)->op2->op3->cond2
cond2(yes)->op4->op1
cond2(no)->cond1
================================

---
# conditional Termination in Iteration

```js
while (iterator){
	//----code---//
	if (condition):
		break;
	//---code---//
}
```
---
# pseudoCode
>flowchart :
>> pictorial representation of computational process
## Node Types
	+ Decisions
	+ Operations
	+ Terminal
## Arrows
+ show direction of operation flow.

>For Large modules,it is more succint and simple to understand textual descriptions of the flowchart.
>>PSEUDOCODE.

---
# PseudoCode for Iteration with Filtering

## Steps
1.Perform initialization Functions
2.Check for condition1. If Yes go to 3 else go to 8.
3.Perform Operation 2 /3 /... etc.
4.Perform filtering check. If succesful goto 6.
5.go to 2.
6.Remove item from Set,Perform tertiary operations 4/5.. etc
7.go to 2.
8.Extract All Variables.Iteration Over.

##PseudoCode

```js
varsᵢ =0;//or some other initializing val.
while (set.length>0){
	val1=item.prop1;//etc..
	if (filteringcondition){
		total+=c; etc..
	}
	set.remove current element.
}
```
---
# Three Prizes Problem
## PseudoCode for three prizes problem

+ Basic Criterion is Total Marks
+ Student must also be in top 3 marks in @ least 1 subject.
+ All three prizes must not be given to students of same Gender.

---

---
# procedures and paramaters

+ compartmentelization of algorithm
+ repetative steps on different variables can be performed by a **procedure** that is defined to take in a **parameter**, on which it operates.

---
# PseudoCode for procedures and Paramaters-1
+ Invoke the Procedure with a parameter for the arguments it uses
+ delegation to module/procedure create need for communication b/w procedure's scope to instance's scope --> **return** value facilitates this communication. The result is passed back to where it was called.
+ Parameters fix the context
+ procedures modularize algorithms

---

# Side Effects of Procedure

+ parameters passed by **refference** are *changed*
+ data integrity is also part of the boundary interface. values that should not be changed are passed by value.

---

# binning to reduce number of comparisons in nested iterations

+ Factor of reduction = (1-N)/(1 -N/K)
	+ K := number of bins (bins are equi-sized).
+ avoid the complexity of nested iterations
+ number of bins is a trade of between memory/space and time; more bins require more space for processing.

---
# Concept of Fair Teams

> they make study pairs with contrasting mark ratios in two subjects
+ two iterations thru the data


---
# Procedure to resolve pronoun with its equivalent matching noun

+ backtracing


---

# Introduction to collections and list data structure
* set pointing to different positions in another ordered set --> indexing list
	* basically an array of pointers.
	* demarcate where to find data in a collection that has been flagged.

---

# Pseudocode for lists
* sqr bracket notation
* concatenation symbol **++**
* operations
```
foreach x in L:
	process x
```

---

# Operations on the data collected in three prizes problem using lists

* from data of top 3 marks in each subject
* find if ∃ a student who has scored with top 3 in all subjects.

---

# Pseudocode for operations on the data collected in three prizes problem using lists

1. Procedure Top3Marks(Subject): returns thirdmax, which is the cutoff.
2. make 3 lists of subject wise eleigible students
3. find the intersection of the lists if it exists.

---

# Insertion sort and ordered list

* ordered list makes comparison based and search based operations efficient.
* insertion sort is based on creating a new sorted array from the given array buy building up, inserting each encountered element into the new array in correct position by comparisons.

---

# Pseudocode for insertion sort and ordered list

> invariant = sorted condition of build-up-list.



--

# Systematic process of hypothesis verification to find relation between Mathematics and Physics...
> correlation fails XD.

# Pseudocode for systematic process of hypothesis verification to find relation between Mathematics...

# Introduction to train dataset

mutual linked dictionaries

---

WEEK 6

---



---

# lec 6.1 Relations among customers based on their spending patterns

* calculate an aggregate measure based on which to judge similarity b/w customers
	* say the aggregate of frequency(quantity) of item-categories in each bill.
* define a **distance function** between two customers wrt quantities of a category brought.
	* say the sum of absolute values of category wise difference in quantity bought.
* build a **similarity matrix** based on these distances.
	* each entry is the inverse of the distance between ```customer[i]``` & ```customer[j]```
	* the heighest entry in the matrix would be the most similar customers wrt chosen measure.


---

# Introduction to dictionary data structure

---

# Concept of dictionary to solve birthday paradox problem

---

# Resolve pronoun with its equivalent matching noun using dictionary and ordered lists

---

# Pseudocode for dictionaries

---

# Pseudocodes for real-time examples using dictionaries


---
# Dictionary comparison to find common elements in them

---

# Procedure to find relations among customers based on their spending patterns

---

# Side effects in pseudocodes for lists and dictionaries

---

# WEEK 7
---

---

# Introduction to graph data structure

vertexes connected by an edge when they are related.

---

# Introduction to matrices and implementation of matrix using nested dictionary

+ for random acces use nested dictionaries indexed by integer == using 2d - arrays

---

# Undirected graph and cliques
+ clique - all nodes connected to each other and not connected to other nodes in the graph.

---

# popular students using graph
+ degree of a vertex

---

# Pseudocodes for real-time examples using graphs

--

# Concept of connected graph to represent the relationship between different nouns in a paragraph

+ making a graph of nouns/pronouns connected by a verb not containging conjections/punctuations in btwn
+ choerence of a paragraph using noun connection graph -- disconnected - disjoint meaning of paragraph.
+ connected graphs

--

# Represent direct trains using a graph and find a route using multiple hops

+ graph representation of directly connected stations, edge represents a train.

---

# WEEK 8

---

---

## lec 8.1 - Representation of a graph as an adjacency matrix to find shortest distance and time

+ graph connections represented in matrix with true / weight at i,j if ∃ edge i,j.
+ edge weight = distance/ fare etc.
+ distance  --> matrix multiplication

---

## lec 8.2 - Construction of a graph where trains are nodes and stations are edges

+ delay propogation
+ stringing nodes

---
## lec 8.3 - Pseudocodes for finding a route between two stations using no hops, one hop, two hops and n hops


---

## lec 8.4 - Pseudocode for edge labeled graph

---

## lec 8.5 - Depth First Search (DFS) and recursive procedure call

* reachability of stations example
+ finding cycles - mentoring example.
+ connecting both train and stations graph via mutual recursive calls.

---

## lec 8.6 - Pseudocode for recursion

---

## lec 8.7 - Pseudocode for Depth First Search (DFS) and recursive procedure call


---

## lec ? - Concept of encapsulation and object
## lec ? - Concept of class and its instance called object
## lec ? - Concept of abstraction
## lec ? -   Applications of encapsulation, abstraction, class and object (Part 1)
trains and stations example.
## lec ? - Applications of encapsulation, abstraction, class and object (Part 2)
## lec ? - Decomposition of the study group problem to incorporate encapsulation and abstraction
## lec ? - Formalized notations and summary of encapsulation
## lec ? - Producer - Consumer problem
## lec 11 - Concept of message passing using Remote Procedure Call (RPC)
request and response
## lec ? - Concept of concurrent execution using polling and preemption
## lec ? - Real time applications of concurrency and drawbacks of the same
## lec ? - Applications of concurrency to speedup the execution process
## lec ? - Concept of message broadcasting

















<!---------EOF----------------->
