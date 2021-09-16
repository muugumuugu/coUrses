# WEEK 1

## lec 1.1 - Introduction to Datasets

-- > make a subset of data from the available set
### eg used in course

+ simplified reportcards
+ simplified shopping reciepts
+ words - letters and pos.

## lec 1.2 - Concepts of Variables, Iterators and Filtering

+ iterator goes across the data set ( or a filtered subset of it. (like case in statistics).
+ variables value is altered according to the value provided by the iterator.
+ one iteration can alter multiple variables.
+ important part is iteration pattern, ale initialization and variable initializzation
+ filtering means selecting a susbset of the data based on the value of one of the case-variabled (attribute of that data entry).
+ we can do multiple filters together, and nest the filtering within the iteration also.

## lec 1.3 - Iterations using Combination of Filter conditions

## lec 1.4 - Introduction to Flowcharts

### Symbols
+ Processs : Process/Activity - Operation that CHanges Vallue
+ Arrow : Connects things and shows order
+ Diamond : Decision / Conditional
+ Rounded Rectangle : Terminal - Indicates start or end of algorithm.

### Generic Flowchart for Iteration

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
```

## lec 1.5 - Flowchart for Sum in Filtering


# WEEK 2
## lec 2.1 - Conditional Termination in Iteration

```js
while (iterator){
	//----code---//
	if (condition):
		break;
	//---code---//
}
```

## lec 2.2 - Local Operations & max in single iteration-1.

> Keep track of a maximum , and update if exceeded;

## lec 2.3 - Local Operations & max in single iteration-2

## lec 2.4 - Local Operations & max in single iteration-3

## lec 2.5 - Local Operations & max in single iteration-4

## lec 2.6 - Max in single iteration and max in Two iterations (non-nested).

## lec 2.7 - Max in a single iteration without using info and Application of Frequency Count.

## lec 2.8 - Intro to PseudoCode
>flowchart :
>> pictorial representation of computational process
### Node Types
	+ Decisions
	+ Operations
	+ Terminal
### Arrows
+ show direction of operation flow.

>For Large modules,it is more succint and simple to understand textual descriptions of the flowchart.
>>PSEUDOCODE.

## lec 2.9 - PseudoCode for Iteration with Filtering

### Steps
1.Perform initialization Functions
2.Check for condition1. If Yes go to 3 else go to 8.
3.Perform Operation 2 /3 /... etc.
4.Perform filtering check. If succesful goto 6.
5.go to 2.
6.Remove item from Set,Perform tertiary operations 4/5.. etc
7.go to 2.
8.Extract All Variables.Iteration Over.

###PseudoCode

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


# WEEK 3

## lec 3.1 Presentation of datasets in Forms of Tables

## lec 3.2 Below Average Students in Two Iterations

## lec 3.3 Systematic process of Hypothesis verification

## lec 3.4 Three Prizes Problem

## lec 3.5 Introduction to procedures and Paramaters

+ compartmentelization of algorithm
+ repetative steps on different variables can be performed by a **procedure** that is defined to take in a **parameter**, on which it operates.

## lec 3.6 PseudoCode for procedures and Paramaters-1
+ Invoke the Procedure with a parameter for the arguments it uses
+ delegation to module/procedure create need for communication b/w procedure's scope to instance's scope --> **return** value facilitates this communication. The result is passed back to where it was called.

## lec 3.7 PseudoCode for procedures and Paramaters-2
+ Parameters fix the context
+ procedures modularize algorithms

# WEEK 4

## lec 4.1 PseudoCode for three prizes problem

+ Basic Criterion is Total Marks
+ Student must also be in top 3 marks in @ least 1 subject.
+ All three prizes must not be given to students of same Gender.

## lec 4.2 Side Effects of Procedure

+ parameters passed by **refference** are *changed*
+ data integrity is also part of the boundary interface. values that should not be changed are passed by value.

## lec 4.3 Concept of nested iterations using the birthday paradox Naive approaach & Using binning

## lec 4.4 Importance of binning to reduce number of comparisons in nested iterations

+ Factor of reduction = (1-N)/(1 -N/K)
	+ K := number of bins (bins are equi-sized_.

## lec 4.5 Concept of binning to avoid the complexity of nested iterations

+ number of bins is a trade of between memory/space and time; more bins require more space for processing.

## lec 4.6 Concept of Fair Teams

## lec 4.7 Procedure to find same date of birth for different students

## lec 4.8 Procedure to resolve pronoun with its equivalent matching noun

## lec 4.9 Summary of contents introduced in week 1 to 4
