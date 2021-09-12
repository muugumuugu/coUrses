
---------------------
TOC
---
|Lec ID| Lec Name|
| ---| --- |
| 01|[Natural Numbers and their Operations](##-lec-01---natural-numbers-and-their-operations)|
| 02|[Rational Numbers](##-lec-02---rational-numbers)|
| 03|[Real Numbers](##-lec-03---real-numbers)|
| 04|[Set Theory](##-lec-04---set-theory)|
| 05|[Construction of Sets and Set Operations](##-lec-05---construction-of-sets-and-set-operations)|
| 06|[Relations](##-lec-06---relations)|
| 07|[Functions](##-lec-07---functions)|
| 08|[Prime Numbers](##-lec-08---prime-numbers)|
| 09|[Why is a Number Irrational?](##-lec-09---why-is-a-number-irrational?)|
| 10|[Sets V/S Collections](##-lec-10---sets-v/s-collections)|
| 11|[Degrees of Infinity](##-lec-11---degrees-of-infinity)|
| 12|[Rectangular Co-Ordinate System](##-lec-12---rectangular-co-ordinate-system)|
| 13|[Distance Formula](##-lec-13---distance-formula)|
| 14|[Section Formula](##-lec-14---section-formula)|
| 15|[Area of a Triangle](##-lec-15---area-of-a-triangle)|
| 16|[Slope of a Line](##-lec-16---slope-of-a-line)|
| 17|[Parallel and Perpendicular Lines](##-lec-17---parallel-and-perpendicular-lines)|
| 18|[Represantation of a Line-1](##-lec-18---represantation-of-a-line-1)|
| 19|[Representation of a Line-2 and Applications of Rectangular Co-ordinated.](##-lec-19---representation-of-a-line-2-and-applications-of-rectangular-co-ordinated.)|
| 20|[General Equation of a Line](##-lec-20---general-equation-of-a-line)|
| 21|[Equation of Perpendicular & Parallel Lines in General Form](##-lec-21---equation-of-perpendicular-&-parallel-lines-in-general-form)|
| 22|[Eqn of line Perpendicular to another line through a given Point](##-lec-22---eqn-of-line-perpendicular-to-another-line-through-a-given-point)|
| 23|[Distance of Point from Line](##-lec-23---distance-of-point-from-line)|
| 24|[Straight Line Fit](##-lec-24---straight-line-fit)|
| 25|[Quadratic Functions ,examples of QF, SLope of a QF](##-lec-25---quadratic-functions-,examples-of-qf,-slope-of-a-qf)|
| 26|[Solution of a QE using Graph, Slope -> Line & Parabola](##-lec-26---solution-of-a-qe-using-graph,-slope-->-line-&-parabola)|
| 27|[Soln of QE using factorization](##-lec-27---soln-of-qe-using-factorization)|
| 28|[Soln of QE using square method.](##-lec-28---soln-of-qe-using-square-method.)|
| 29|[Quadratic Formula](##-lec-29---quadratic-formula)|
| 30|[Polynomials](##-lec-30---polynomials)|
| 31|[Degree of polynomial](##-lec-31---degree-of-polynomial)|
| 32|[Algebra of polynomials --> + & -](##-lec-32---algebra-of-polynomials--->-+-&--)|
| 33|[Algebra of polynomials --> *](##-lec-33---algebra-of-polynomials--->-*)|
| 34|[Algebra of polynomials --> /](##-lec-34---algebra-of-polynomials--->-/)|
| 35|[division algorithm](##-lec-35---division-algorithm)|
| 36|[Graphs of Polynomials - > Identification/ Characteriztion](##-lec-36---graphs-of-polynomials--->-identification/-characteriztion)|
| 37|[Zeroes of Polynomial Functions](##-lec-37---zeroes-of-polynomial-functions)|

---------------------
# WEEK 1

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

## Lec 02 - Rational Numbers

+ GCD
+ Density of ℚ

## Lec 03 - Real Numbers

### Important Irrationals

+ Polynomial
	+ √2, √3 , etc
+ Trancendental
	+ π
	+ e

## Lec 04 - Set Theory

### Properties of a set

+ No duplicates included
+ order irrelavent

>subset --> set formed from selected elements of a superset
>> equivalent to ***binary sequences*** of the length #cardinality-of-superset

### Special Sets

+ φ --> Empty Set . Subset of All Sets Vacously.
+ ℙ(X) --> Set Of all Subsets of X.

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


## Lec 08 - Prime Numbers

+ Euclid's Infinity of Primes.
+ π(x) = # of primes < x
+ Prime Number Th. - π(x)--> x/ln(x) as x-->∞

## Lec 09 - Why is a Number Irrational?

>The Real line is continous but some points on the line like √2, obtained from the pythogorean unit right triangle, cannot be represented as a ratio,
hence the need for irrational.

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

## Lec 11 - Degrees of Infinity

>Enumaration - ***bijection*** with ℕ
>> Enumerable Sets are called Countable. They may be finite or infinite

### ℝ is uncountably infinit

> proof by diagonalization (enumarating sequences of {1,0} and picking the sequence off the diagonal --> negating it and hence finding a sequence that had not been counted

### Continuum Hypothesis

> Is there a set with cardinality between that of ℕ  and ℝ?
>> *Independent of Set Theory Axioms*, the existence of such a set cannot be proved or disproved.

# WEEK 2

## Lec 12 - Rectangular Co-Ordinate System

> Based on assosciating ***ℝ*** with a ***2d grid of perpendicular lines*** (axes)

## Lec 13 - Distance Formula

## Lec 14 - Section Formula

## Lec 15 - Area of a Triangle

## Lec 16 - Slope of a Line

> Gradient or Inclination with +ve X Axis

>***m***= <i>tan</i>(θ) , θ measured from left to right between + ve X-axis and line

## Lec 17 - Parallel and Perpendicular Lines

+ Parralelness --> m<sub>1</sub>=m<sub>2</sub>
+ Perpendicularity --> m<sub>1</sub>=-1/m<sub>2</sub>

###Angle of Intersection

> θ = (m<sub>1</sub>-m<sub>2</sub>)/(1+ m<sub>1</sub>m<sub>2</sub>

## Lec 18 - Represantation of a Line-1

+ Point on a Lines
+ Horizontal and Vertical Lines
+ Point-Slope Form
+ Two-Point Form

## Lec 19 - Representation of a Line-2 and Applications of Rectangular Co-ordinated.

+ Slope-intercept form
+ XY- intercept frm

# WEEK 3

## Lec 20 - General Equation of a Line

> a<sub>i</sub>x +b<sub>i</sub>x+c<sub>i</sub>=d

## Lec 21 - Equation of Perpendicular & Parallel Lines in General Form

+ parallel : a<sub>1</sub>/a<sub>2</sub>=b<sub>1/</sub>/b<sub>2</sub>
+ perpendicular a<sub>1</sub>a<sub>2</sub>+b<sub>1/</sub>b<sub>2</sub>=0

## Lec 22 - Eqn of line Perpendicular to another line through a given Point

## Lec 23 - Distance of Point from Line

## Lec 24 - Straight Line Fit

###SSE

# WEEK 4

## Lec 25 - Quadratic Functions ,examples of QF, SLope of a QF

+ Parabolas
+ Axis of symetry
+ Vertex
+ Maximum/MinimumS
+ Tangent



## Lec 26 - Solution of a QE using Graph, Slope -> Line & Parabola

+ use zeroes of QF to get roots of QE.
+ Sensitivity of change in run in terms of the rise --> slope
+ derievative
+ vertex co-ors by setting slope
+ Surface Of Revolution.

# WEEK 5

## Lec 27 - Soln of QE using factorization

+ intercept form
	+ y=a(x-p)(x-q)
+ FOIL
	+ firstouterinnerlast
	+ sum/product method

## Lec 28 - Soln of QE using square method.

> complete the square.

## Lec 29 - Quadratic Formula

## Lec 30 - Polynomials

## Lec 31 - Degree of polynomial

> degree of zero polynomial is undefined

## Lec 32 - Algebra of polynomials --> + & -

## Lec 33 - Algebra of polynomials --> *

## Lec 34 - Algebra of polynomials --> /

## Lec 35 - division algorithm

> Rational Functions

## Lec 36 - Graphs of Polynomials - > Identification/ Characteriztion

> the curve of polynomials is always smooth( continous without sharp corners).

## Lec 37 - Zeroes of Polynomial Functions
