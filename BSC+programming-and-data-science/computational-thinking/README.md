## 1.1 : Introduction to Datasets

-- > make a subset of data from the available set
### eg used in course

+ simplified reportcards
+ simplified shopping reciepts
+ words - letters and pos.

## 1.2 : Concepts of Variables, Iterators and Filtering

+ iterator goes across the data set ( or a filtered subset of it. (like case in statistics).
+ variables value is altered according to the value provided by the iterator.
+ one iteration can alter multiple variables.
+ important part is iteration pattern, ale initialization and variable initializzation
+ filtering means selecting a susbset of the data based on the value of one of the case-variabled (attribute of that data entry).
+ we can do multiple filters together, and nest the filtering within the iteration also.

## 1.3 : Iterations using Combination of Filter conditions

## 1.4 : Introduction to Flowcharts

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

## 1.5 : Flowchart for Sum in Filtering

## 2.1 : Conditional Termination in Iteration

```js
while (iterator){
	//----code---//
	if (condition):
		break;
	//---code---//
}
```

## 2.2 : Local Operations & max in single iteration-1.

> Keep track of a maximum , and update if exceeded;

## 2.3 : Local Operations & max in single iteration-2

## 2.4 : Local Operations & max in single iteration-3

## 2.5 : Local Operations & max in single iteration-4

## 2.6 : Max in single iteration and max in Two iterations (non-nested).

## 2.7 : Max in a single iteration without using info and Application of Frequency Count.

## 2.8 : Intro to PseudoCode
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

## 2.9 : PseudoCode for Iteration with Filtering

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

```
vars<sub>i</sub>=0;//or some other initializing val.
while (set.length>0){
	val1=item.prop1;//etc..
	if (filteringcondition){
		total+=c; etc..
	}
	set.remove current element.
}
```
###