<script src="/styles/syntaxhighlighter.js"></script>
<script>hljs.highlightAll();</script>

---
# WEEK 1
## Downloading Data, Intro to Statistics
---


---
## Lec 1.1 - Introduction and Types of Data - Basic Definitions

>The art of learning from data

### Branches of Statistcs

+ Descriptive Statistics - summarization and description
	+ purpose of study is to examine info for its own intrinsic interest
+ Inferential Statistics - drawing conclusions from data
	+ involves dealing with possibility of chance
	+ draws conclusion about the entire dataset( *poplation* ) from a chosen subset( the *sample* )
### DataSets

+ population
	+ all elements we are interested in
+ sample
	+ subset of the population which will be studied in detail.
	+ a good sample has good representation.
>inference from sample can be extended to be true, upto some error, for the population


---
## Lec 1.2 - Introduction and Types of Data - Understanding Data

### Data

> facts & figures collected, analyzed, and summarized for interpretation and presentation.

+ Where to Find Data?
	+ Data Already Available - download the published data
		+ [Gov. provided Common Data Sets](http://data.gov.in)
	+ Data Not Available - generate and/or collect data.

### Organization of Data

+ Unstructured Data is scattered and needs *Contextualization* and *Organization* before Analysis.
+ Organization is posible thru many ways, like **tabulation**, etc.

#### Variables and Cases

+ case - a unit from which data is collected.
+ variable - attribute of the units that varies across the sampling set of the units.

#### Tabulation

+ each variable must have its own column, and same type of value/measurement unit across the units to be consistent and comparable
+ each case has its own unique row, with values ( could be NA ) for each variable.


---
## Lec 1.3 - Introduction and Types of Data - Classification of Data

### Numerical Data

+ Unit of Measurement
+ quantitative
+ types
	+ discrete
	+ continuous

### Categorical Data

+ Value of Variable belongs to a certaim enumerable set of values.
	+ identify the group membership
+ qualitative

### Time Series Data
> data recorded over time

### Cross Sectional Data
> data recorded at a point of time


---
## Lec 1.4 - Introduction and Types of Data - Scales of Measurement

## Categorical Data

### Nominal Scale of Measurement
+ NO ordering in such variables.
+ they are just lables.
+ they can be numerically coded.
+ only give an characterestic identification to the case.
+ don't imply amything
+ example
	+ gender
	+ jersey number

### Ordinal Scale of  Measurement
+ labels with ranks.
+ order relevant.
+ data is still a label, that is it takes a categorical value, and hence can also be numerically codded (keep order in mind).
+ example
	+ worded ratings

## Numerical Data

### Interval Scale of Measurement
+ extends on ordinal data, and also has a fixed unit to measure differenece between two values.
+ always numeric.
+ ratios meaningless since it's all about the differences, the zero is arbitrary.
+ can be converted to ratio scale by fixing a zero and performing subtraction ( similar to origin - shifting)
+ example
	+ star ratings

### Ratio Scale of Measurement
+ extends from interval data, and has a fixed , meaningful zero, so that a standalone value also is a useable characteristic.
+ possible to perform all arithmetic on such data
+ example
	+ height

---
# WEEK 2
## Describing Categorical Data - one variable
---


---
## Lec 2.1 - Describing Categorical Data - Frquency Distributions
> Frequency Table - Listing of diistinct values of a Catgerical Value and their counts in the cases.
>> One Tally Mark for each occurence of the value.
### In Google Sheets
Select data Cells ⇾ Format Menu ⇾ Data ⇾ Pivot Table ⇾ Add rows and Data.

> Relative Frequency - a standard for comparison. Ratio of frequency to Total Count.


---
## Lec 2.2 - Describing Categorical Data - Charts of Categorical Data

### graphs
> Displays of the frequency Table.
+ Bar Charts
	+ For compact Representation of Data.
	+ Bars shouldn't Touch each other
	+ ***Pareto Chart*** - bars are ordered in ascending/descending order of value if data is Ordinal/ Interval Scale. (No meaning for a Nominal data-set)

+ Pie Charts
	+ display y=the portions
	+ Suitable for representing relative frquencies.


---
## Lec 2.3 - Describe Categorical Data - BestPractices-1

> Annotate Data in Charts with both labels of the Categorical Value, and with the frequency/relative frequency.


---
## Lec 2.4 - Describing Categorical Data - Best Practices - 2

> Area Principle:
>> area occupied by portion of chart should correspond to ampunt of data.

>Misleading Baselines.
>> Such truncatio confuses due to
>>> + loss of data
>>> + incorrect represa=entation in terms of proportions.
>>if needed Y axis breaks should be marked.


---
## Lec 2.5 - Describing Categorical Data - Mode and Median
> Central Tendency  Measures.

> Mode
>> category with heighest frequency.

> Median (for ordinal data only)
>> mid value of sorted  values.

---

# WEEK 3
## Describing Numerical Data - one variable

---


---
## Lec 3.1 - Describing Numerical Data - Frequency Tables for Numerical Data

>Group the discrete variables (counts) into bins, if the number of values is small, they can themself be considered as categories.

> Otherwise groupd data into bins (classes).
>> Classes can be used for both continous and discrete data.

>> Take classes to be ***left-closed - right-open*** to ensure that the classes *partition* data.

>> Conventional to have equiwidth classes.
### Plotting such frquency tables.
+ Use a Histogram.
> Google Sheet Method.
>>Insert -> Chart -> Chart - Editor -> Select Data -> Customize -> Bucket Size : Class-Width.

+ Stem -Leaf Plot.
	+ Leaf : All but right-most Digit
	+ Stem : rightmost digit.
	+ Steps
		1. Each Obsv := Stem
		2. Write Stems in Ascending order in a vertical column.
		3. Write each leaf to the write of its corresponding stem entry.
		4. Arrange Leaves in each row in Ascending order.
	+ Example:
		+ data : 15,22,29,36,31,23,45,10.
		+ Chart

		|STEM| LEAF|
		| ---|--- |
		|1|0,5|
		|2|2,3,9|
		|3|1,6|
		|4|5|


---
## Lec 3.2 - Describing Numerical Data - Mean

### Numerical Summaries.
+ Meaures of Central Tendency
	+ Mode
	+ Median
	+ Mean
+ Measure of Dispersion/variability/spread

> Mean : Average.
>>∑x<sub>i</sub>/n
>>> extremely sensitive to outliers
+ μ = Population Mean
+ x̄ = Sample Mean

#### Appx Mean for grouped data
> ∑f<sub>i</sub>x<sub>i</sub>/n

> x is the class-mark.


---
## Lec 3.3 - Describing Numerical Data - Median and Mode

> Median : Middle Value in a ***Ordered*** Dataset.
> Mode : Most frquently occuring value.


---
## Lec 3.4 - Describing Numerical Data - Measures of dispersion- Range

>Range:
>> Max - Min

>> Sensitive , but only to extreme values.

> Variance:
>> Deviation of value of data points. from central value of a data-set.\
>> σ<sup>2</sup>= ∑(x<sub>i - x)<sup>2</sup>/N
>>>for sample means, denominator is kept ```(n-1)``` instead of n. (Statistical Correction)

<blockquote>Welford’s method of computing sample Variance
<blockquote>(n-1)σ<sub>n</sub><sup>2</sup>=(n-2)σ<sub>n-1</sub><sup>2</sup> +(x<sub>n</sub>-x̄<sub>n</sub>)(x<sub>n</sub>-x̄<sub>n-1</sub>)</blockquote>
<blockquote><pre><code>
variance(samples):
	M := 0
	S := 0
		for k from 1 to N:
		x := samples[k]
		oldM := M
		M := M + (x-M)/k
		S := S + (x-M)*(x-oldM)
return S/(N-1)
</code></pre></blockquote>
</blockquote>
>>Single Pass
>>>simply accumulating the sums of x<sub>i</sub> and x<sup>2</sup><sub>i</sub>:
>>>> + σ<sup>2</sup> = ∑(x<sup>2</sup><sub>i</sub>–2xx̄<sub>i</sub>+x̄<sup>2</sup>)/(N−1)
>>>> + σ<sup>2</sup> = (∑x<sup>2</sup><sub>i</sub>x–2Nx̄<sup>2</sup>+x̄<sup>2</sup>)/(N−1)
>>>> + σ<sup>2</sup> = (∑x<sup>2</sup><sub>i</sub>–Nx̄<sup>2</sup>)/N−1

> Std Deviation : √variance
>>To maintain units of dispersion measure and data-points



---
## Lec 3.5 - Describing Numerical Data - Percentiles, Quartiles, and Interquartile Range

> Percentiles are right-closed - left-open
>> 80percentile means 80% are < it, and 20% are >= to it.

>Manual Percentile Algorithm for 100 *p th percentile ( p is a fractional val.)
>>Arrange data Ascendingly.

>> If n\*p is not an integer,determine pos=floor(np). The posth data is the 100\*pth percentile

>> Else 100*pth percentile= avg(np,np+1<sup>th</sup>obsv)

>G sheet Percentile Algorithm.
>> Rank= percentile*(n-1)+1
>>>Split Rank into integer and fractional part.
>>>>Compute the ordered data value (odv<sub>0</sub>) corresponding to integer rank.
>>>>>Percentile=odv<sub>0</sub>+frac-rank*(odv<sub>1</sub> - odv<sub>0</sub>)

### Quartiles.
+ 25th percentile --> first quartile / lower quartile.
+ 50th percentile --> Mean.
+ 75th percentile --> third quartile / upper quartile.

### Five Number Summary
1. Min
2. Q<sub>1</sub> : lower quartile
3. Q<sub>2</sub> : mean
4. Q<sub>3</sub> : upper quartile
5. Max

### Inter Quartile Range
>IQR
>>Q<sub>3</sub>-Q<sub>1</sub>

---

# WEEK 4
## Assosiation between Two Variables

---

---
## Lec 4.1 - Association between two variables - Review of course


---
## Lec 4.2 - Association between two categorical variables - Introduction

+ Contigency Table : Two-way Table for bivariate categorical data.
+ ij position has the data which satisfies both catgeory<sub>1</sub> val=c<sub>i<sub>1</sub></sub> and category<sub>2</sub> val=c<sub>2<sub>j</dub></sub>
+ Google Sheet Method
	+ choose column for association'+ In Data Tab - >Pivot Table.
	+ create a pivot table, and in edutor
		+ --> Rows --> click on first categorical variables
		+ --> Colums --> click on second catgeorical variable
		+ --> Values --> click on either variable and then click on COUNTA under "summarize by" tab.


---
## Lec 4.3 - Association between two categorical variables - Relative frequencies

+ Row Relative Frequency --> Divide each Cell Frequency by its row total frequency
+ Column Relative Frequency --> Divide each Cell Frequency by its column total frequency
+ Assosiation Rule --> Column / Row Frequency for each Row/Column respectively are non homogenous --> there is a pattern of change in one category with the other category variable.
### Stacked Bar Chart
> Represents counts for a particular category, and is further segmented into segments, each segment representing the frequency of that particular category within the segment.

> Can Represent two categories within one chart
#### Google Sheet.
>Select Data for Contingency Table --> Insert Chart -->Stacked Column Chart.
>> If Stacking is ```Standard``` type, then the numbers show COunt, and ```100%``` Stacking shows relative frequency.


---
## Lec 4.4 - Association between two numerical variables - Scatterplot
> A graph that displays pairs of values as points on a 2D Plane.
>> For interpretting association of two *numerical* variables.
>>> Visual test for association.
### Google Sheet

1. Highlight Data to plot.
2. Insert Chart --> Scatter Charts
3. Under X-Axis Tab , choose the explanatory variable.
4. Under Series Tab , choose the response variable.


---
## Lec 4.5 - Association between two numerical variables - Describing association

### The 4 key Qs.
1. Direction : Is there a pattern trend up, down or both?
2. Curvature: Does the pattern appear linear, or appear to follow some curve?
3. Variation: Are the points tightly clustered or variable?
4. Outliers: Are some points way off the majority pattern.
	> values that are
	>> < Q1-IQR  or  > Q3+IQR


---
## Lec 4.6 - Association between two numerical variables - Covariance

### Quantyfying (Linear) Assosiation b/w numerical values.
+ Covariance
	+ Cov(x,y)=∑(x<sub>i</sub>-x̄)*(y<sub>i</sub>-ȳ)/N
	+ Denominator =```n-1``` if considering sample.
	+ Difficult to interpret due to units.
+ Correlation



---
## Lec 4.7 - Association between two numerical variables - Correlation

+ Pearson correlation Coefficient
	+ ρ<sub>xy</sub>= Cov(x,y)/((σ<sub>x</sub>σ<sub>y</sub>))


---
## Lec 4.8 - Association between two numerical variables - Fitting a line

> Summarizing the linear association using a line on ℝ<sup>2</sup>
>> R<sup>2</sup> = Measure of Accuracy of Fit = correlation coeff <sup.2</sup>
>>Using Google Sheets
>>> In scatter Plot --> Customize--> Series -->Trend Line. -->Label -->Use Equation.


---
## Lec 4.9 - Association between categorical and numerical variables

>Point Bi-Serial Correlation Coefficient
>> Group values into two sets based on values of the selected dichotomous variable (code them in binary, as 0 and 1) .

>> Calculate the mean values of the two groups ȳ<sub>0</sub> and ȳ<sub>1</sub>.

>>let p<sub>0</sub> and p<sub>1</sub> be the proportion of the observations. and s<sub>X</sub> be the std deviation of the random value X.

>> r<sub>pb</sub>=(ȳ<sub>0</sub> - ȳ<sub>1</sub>.)*√(p<sub>0</sub>p<sub>1</sub>)/s<sub>x</sub>

---

# WEEK 5

-----


---
## Lec 5.1 - Permutations and Combinations - Basic Principles of counting

+  Addition Principal of counting
	+ event A **or** B
	+ #A **+** #B
+  Multiplication Principal of Counting
	+ event A **and** B
	+ #A **X** #B


---
## Lec 5.2 - Permutations and Combinations - Factorials

>Factorial:
>> Simpler Way to represent 1x2x3...xn = *n!*

>Recursive definition:
>> n!=n*(n-1)! ; 0!=1



---
## Lec 5.3 - Permutations and Combinations - Permutations: Distinct objects.

> Permutation:
>> ordered arrangement

+ <sup>n</sup>P<sub>r</sub>=n!/(n-r)! --> for N distinct objects, without repetation
+ with repetation allowed,  <sup>n</sup>P'<sub>r</sub> = n<sup>r</sup>


---
## Lec 5.4 - Permutations and Combinations - Permutations : Objects not distinct

+ For non distinct objects each n-ordering occurs p<sub>i</sub> times if an element is present in p<sub>i</sub> duplicates.
	+ so, <sup>n</sup>P<sub>n</sub>=n!/π(p<sub>i</sub>!) where p<sub>i</sub> is the number of copies of the repeating element.

+ For circular arrangements, the order of chosing the first elements position is irrelevant, hence
	+ <sup>n</sup>P<sub>n</sub>=(n-1)!
	+ if AC/CLockwise are not distinct, the number gets divided by 2.


---
## Lec 5.5 - Permutations and Combinations - Combinations
<<<<<<< HEAD
+ <sup>n</sup>C<sub>r</sub>=<sup>n</sup>P<sub>r</sub>/r! =<sup>n</sup>C<sub>n-r</sub>
+ <sup>n</sup>C<sub>r</sub>=<sup>n-1</sup>C<sub>r-1</sub>+<sup>n-1</sup>C<sub>r</sub>
	+ that is it is the sum of the two entries above it in the pascal's triangle
=======
	+ <sup>n</sup>C<sub>r</sub>=<sup>n</sup>P<sub>r</sub>/r! =<sup>n</sup>C<sub>n-r</sub>
	+ <sup>n</sup>C<sub>r</sub>=<sup>n-1</sup>C<sub>r-1</sub>+<sup>n-1</sup>C<sub>r</sub>
		+ that is it is the sum of the two entries above it in the pascal's triangle
>>>>>>> 9736d8c63294609414027bd2421b4dcfea688734



---
## Lec 5.6 - Permutations and Combinations - Applications
<<<<<<< HEAD
+ summary lecture
=======
	+ summary lecture
>>>>>>> 9736d8c63294609414027bd2421b4dcfea688734

---

# WEEK 6

---

---

## Lec 6.1 - Probability - Basic Definitions

* random experiment
* Sample Space

---

## Lec 6.2 - Probability - Events and basic operations on events

* event : subset of sample space
* disjoint events
* null event

---

## Lec 6.3 - Probability - Random experiment, Same Space events
* playing cards examples
* venn diagram represantation of events

---

## Lec 6.4 - Probability - Properties of probability

* classocal/apiori definition:when there are n eqially likely outcomes in the sample space of a random experiment, and event E contains exactly m of those , the probability of event E = ***P(E) = m/n***

* relative/ aposteriori/ emperical : probababiltu of an event in an experiment id the proprtion of times the event occurs in a very long(hteoratically infinite) series of independent repetations of an experiment. P(E)= lim<sub>n→∞</sub> n(E)/n , where n(E) is the number of times E occurs in n repetations of the experiment

* subjective - a person's best belief

### axiomatic theory of probability
1. 0≤P(E)≤1
2. P(S)=1
3. for a countable sequence of mutually disjoint events: P(∪E<sub>i<sub>) = ∑P(E<sub>i</sub>)

* addition rule of probability

---

## Lec 6.5 - Probability - Equally likely outcomes
>examples
---

## Lec 6.6 - Probability - Equally likely outcomes
> examples


---

# WEEK 7

---

---

## Lec 7.1 - Conditional Probability - contingency tables

>row relative frequencies gives conditional(marginal) and joint(sum total entries) probabilities.
--

## Lec 7.2 - Conditional Probability - Conditional probability formula

P(E if F has occured)= **P(E|F)** = P(E∩F)/P(F)

---

## Lec 7.3 - Conditional Probability - Multiplication rule
### Multiplication Rule
P(E∩F)=P(E|F) * P(F)

#### Generalized Rule

P(E₁∩E₂∩E₃∩E₄)=P(E₁) * P(E₂|E₁) * P(E₃| E₁∩E₂)....P(Eₙ|E₁∩E₂∩...Eₙ₋₁)

---

## Lec 7.4 - Conditional Probability - Independent events
P(E∩F)=P(E)XP(F)

---
## Lec 7.5 - Conditional Probability - Independent events: examples

> dice and cards example
### independence of more than one events
* if E is independent of F and also G,
* it is not necessarily independent of F∩G.

---

## Lec 7.6 - Conditional Probability - Independent events: properties

>If E and F is independent, E and Fᶜ  are also independent
if E,F and G are independent , all mutual intersection probabilities follow the multiplication rule, and
P(E∩F∩G)=P(E)XP(F)XP(G)

---

## Lec 7.7 - Conditional Probability - Bayes' rule

### Law of total probabalities
P(E)=P(F)P(E|f)+P(Fᶜ)P(E|Fᶜ)
* probability of E is a weighted average of the conditional probability of E  given F happens and doesnt occur
* weighted by the probability of the event on which it is conditioned.

> Suppose Fᵢ are mutually excliusive and exhaustive then for any event E is a weighted sum = ∑P(E|Fᵢ)P(Fᵢ)

### Bayes Rule
* P(F|E)=P(F∩E)/P(E) = (P(E|Fᵢ)P(Fᵢ))/∑(P(E|Fᵢ)*P(Fᵢ))


---

# WEEK 8

---

---

## Lec 8.1 - Random variables - Introduction

>Random Expeiment
>> experiment whose outcomes are known but not certain
> Random Variable
>> real valued function defined on the sample space of a random experiment/
>>> example sum of two die roll

---

## Lec 8.2 - Random variables - Application
### Discrete random vaqriable
* can take only countable number of different values.


---

## Lec 8.3 - Random variables - Discrete and continuous random variable
### Discrete vs Continous variables
>Discrete
>> isolated points on the real line
> Continous
>> interval along the real number

* apartment complex example

---

## Lec 8.4 - Discrete random variables - Probability mass function properties

### std deviation of a random variable.
1. expectation (cx) = cE(x)
2. SD (cx) = cSD(x)
3. expectation (x+c) = E(x) +c
4. SD (x+c) = SD(x)

* let X be a random variable with n possible outcomes labelled xᵢ.
* define PMF p(x) of X :
	* p(xᵢ)=P(X=xᵢ)
	* p(xᵢ)≥0
	* ∑p(xᵢ)=1
	* p(x) for any x ∉ { xᵢ }



---

## Lec 8.5 - Discrete random variables - Graph of probability mass function
> plot P(X=xᵢ) on y-axis, against xᵢ on X axis.
>> gives the shape of the random distribution.

### distribution shapes
1. Positive skewed , xᵢ increases pmf decreases
2. Negative skewed , xᵢ increases pmf decreases
3. Symetric
4. Uniform

---

## Lec 8.6 - Discrete random variables - Cumulative distribution function
>Cumulative distribution Function:
>> F : ℝ → \[0,1\]
>>>F(A) = P(X≤a)

* if X is a discrete random variable with values in exact ascending order  --> F of X is a step function
* size of the step =  probability of X that X assumes at that value.

---

# WEEK 9

---

---

## Lec 9.1 - Discrete random variable - Application
> summary lecture

---


## Lec 9.2 - Expectation of a random variable
> Expectation
>> Long run average
E(X)=∑xᵢP(X=xᵢ)

### Bernoulli random variable.
* random variable that taes two value 1 or 0
* takes on the value 1 with probability p
* expextation=p

### Discrete uniform random variable
* pmf=1/n for each xᵢ
* E(x)=(n+1)/2


---

## Lec 9.3 - Expectation of a random variable - Properties of expectation

### Expectation of a function of a random variable
E(*g(x)*)=∑(g(xᵢ)P(X=xᵢ))

### sum of two random variables

E(X+Y)=E(X)+E(Y)

### Hypergeometric random variable
* The result of each draw (the elements of the population being sampled) can be classified into one of two mutually exclusive categories (e.g. Pass/Fail or Employed/Unemployed).
* The probability of a success changes on each draw, as each draw decreases the population (sampling without replacement from a finite population).
* parameters:
	* N: the population size,
	* K: the number of success states in the population,
	* n: the number of draws (i.e. quantity drawn in each trial),
	* k: the number of observed successes
* pmf = ᴷCₖ * ᴺ⁻ᴷCₙ₋ₖ / ᴺCₙ
* expectation = nm/N
* variance = E*((n-1)(m-1)/(N-1) + 1 - E)

---

## Lec 9.4 - Variance of a random variable - Properties of variance

> Var(X)=E(X-E(X))²
>> E(X²)-E(X)

### Special cases
1. Bernoulli:
	Var(X)=p(p-1)
2. Discrete Uniform:
	Var(X)=(n²-1)/12

---

## Lec 9.5 - Variance of a random variable - Properties of variance
1. Var(cX)=c²Var(X)
2. Var(c+X)=Var(X)

### independent random variables
* knowing the value of one doesnt change the expectation of the other.
* Var(X+Y)=Var(X)+Var(Y)

---

## Lec 9.6 - Standard deviation of a random variable

> sd=sqrt(Variance)


---

# WEEK 10

---

---

## Lec 10.1 - Binomial distribution - Bernoulli distribution

### Bernoulli Trial
> experiment whose outcome sample space can be classified into a binary set =\{ Success,Failure\}
>> associate success with value 1 and failure with 0

* large variance --> most uncertain.

---


## Lec 10.2 - Binomial distribution - IID Bernoulli trials

* for n independent bernoulli trials,
	* number of diff outcomes that result in i success and hence n-i failures = ⁿCᵢ
	* P(X=i) = ⁿCᵢ x pⁱ x (1-p)⁽ⁿ⁻ⁱ⁾
	* probability of i successes in n identically distributed independent bernoulli trials

---


## Lec 10.3 - Binomial distribution - Distribution of Binomial random variable

### Binomial Random Variable
> number of succsess in n independent Bernoulli trials.

### shapes for small n
* right skewed if BT has p is less than 0.5
* symetrix if BT has p = 0.5
* left skewed if BT has p is more than 0.5

### shape for large n
> distribution approaches symetry
>> graph may be shifted, bur is shaped symetrically


---

## Lec 10.4 - Binomial distribution - Modeling situations as Binomial distribution

> defectives in packs example, mcq exam example

---

## Lec 10.5 - Binomial distribution - Expectation and variance of Binomial random variable

* Expectation: np
* Variance: np(p-1)



---

#WEEK 11

---

---
## Lec 11.1 - Continuous random variable - Introduction

### probability density function
* every continous random variable has a curve associated with it.
* this curve is called it's probability density function f(x).
* area under a pdf = ₐ∫ᵇf(x)dx= P(X∈\[a,b\])
* 0≤f(x)≤1
* ᵐᵃˣ∫ₘᵢₙf(x)dx=1


---

## Lec 11.2 - Continuous random variable - Uniform distribution

if distribution is uniform f(x) is a constant in the given interval 0 otherwise, and = 1/(max-min)

### std uniform distribution
> min=0, max=1

### cdf
F(X)=P(X<\x) = ∫ᵃf(x)dx = 0 if x<\min, (x-min)/(max-min) , 1 if x ≥ max.

### expectation
E(X)=(min+max)/2

### variance
V(X)=(max-min)²/12

---

## Lec 11.3 - Continuous random variable - Uniform distribution: applications
> application problems and solutions

---

## Lec 11.4 - Continuous random variable - Non uniform and triangular distribution
### triangle distribution
* has a peak, looks like a triangle, obviously.
* there it is a function which takes constant positive slope upto the peak, and then a negative slope down to the max

---

## Lec 11.5 - Continuous random variable - Exponential distribution
> pdf : f(x)=ke⁻ᵏˣ for x>0 , 0 otherwise

### cdf
* taper of at 1.
* P(x≤a) = 1- e⁻ᵏᵃ

### expectation
* E(X)=1/k
* E(Xⁿ)=nE(X^ⁿ⁻¹)/k

### variance
* var(X)=1/k²




































<!-----------eof-------->
