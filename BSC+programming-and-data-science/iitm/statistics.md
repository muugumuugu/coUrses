TOC
---
|Lec Name|
|---|
|[Playlist](#playlist)|
|[Introduction](#introduction)|
|[Understanding Data](#understanding-data)|
|[Organization of Data](#organization-of-data)|
|[Variables and Cases](#variables-and-cases)|
|[Tabulation](#tabulation)|
|[Classification of Data](#classification-of-data)|
|[Scales of Measurement](#scales-of-measurement)|
|[Describing Data](#describing-data)|
|[Association between two categorical variables](#association-between-two-categorical-variables)|
|[Association between two numerical variables](#association-between-two-numerical-variables)|
|[Association between categorical and numerical variables](#association-between-categorical-and-numerical-variables)|
|[Permutations and Combinations](#permutations-and-combinations)|
|[Probability](#probability)|
|[Random variables](#random-variables)|
|[Probability mass function](#probability-mass-function)|
|[Cumulative distribution function](#cumulative-distribution-function)|
|[Expectation of a random variable](#expectation-of-a-random-variable)|
|[Variance of a random variable](#variance-of-a-random-variable)|
|[Discrete Distributions](#discrete-distributions)|
|[probability density function](#probability-density-function)|
|[continous distributions](#continous-distributions)|
|[WOrking With G-SHeets](#working-with-g-sheets)|

# Playlist
[https://www.youtube.com/playlist?list=PLZ2ps__7DhBYrMs3zybOqr1DzMFCX49xG](yt)

---
# Introduction
>The art of learning from data

## Branches of Statistcs
+ Descriptive Statistics - summarization and description
	+ purpose of study is to examine info for its own intrinsic interest
+ Inferential Statistics - drawing conclusions from data
	+ involves dealing with possibility of chance
	+ draws conclusion about the entire dataset( *poplation* ) from a chosen subset( the *sample* )

## DataSet Classification
+ population
	+ all elements we are interested in
+ sample
	+ subset of the population which will be studied in detail.
	+ a good sample has good representation.
>inference from sample can be extended to be true, upto some error, for the population

# Understanding Data
> facts & figures collected, analyzed, and summarized for interpretation and presentation.
+ Where to Find Data?
	+ Data Already Available - download the published data
		+ [http://data.gov.in](Gov. provided Common Data Sets)
	+ Data Not Available - generate and/or collect data.

# Organization of Data
+ Unstructured Data is scattered and needs *Contextualization* and *Organization* before Analysis.
+ Organization is posible thru many ways, like **tabulation**, etc.

# Variables and Cases
+ case - a unit from which data is collected.
+ variable - attribute of the units that varies across the sampling set of the units.

# Tabulation
+ each variable must have its own column, and same type of value/measurement unit across the units to be consistent and comparable
+ each case has its own unique row, with values ( could be NA ) for each variable.

# Classification of Data
## Numerical Data
+ Unit of Measurement
+ quantitative
+ types
	+ discrete
	+ continuous

## Categorical Data
+ Value of Variable belongs to a certaim enumerable set of values.
	+ identify the group membership
+ qualitative

## Time Series Data
> data recorded over time

### Cross Sectional Data
> data recorded at a point of time


---
# Scales of Measurement
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
--

---
# Describing Data
## Describing Categorical Data - one variable
### Frequency Distributions
> Frequency Table - Listing of diistinct values of a Catgerical Value and their counts in the cases.
>> One Tally Mark for each occurence of the value.
### In Google Sheets
	Select data Cells ⇾ Format Menu ⇾ Data ⇾ Pivot Table ⇾ Add rows and Data.

> Relative Frequency - a standard for comparison. Ratio of frequency to Total Count.

### Charts of Categorical Data
> Displays of the frequency Table.
+ Bar Charts
	+ For compact Representation of Data.
	+ Bars shouldn't Touch each other
	+ ***Pareto Chart*** - bars are ordered in ascending/descending order of value if data is Ordinal/ Interval Scale. (No meaning for a Nominal data-set)
+ Pie Charts
	+ display y=the portions
	+ Suitable for representing relative frquencies.
> Area Principle:
>> area occupied by portion of chart should correspond to ampunt of data.

>Misleading Baselines.
>> Such truncatio confuses due to
>>> + loss of data
>>> + incorrect represa=entation in terms of proportions.
>>if needed Y axis breaks should be marked.

### Mode and Median
> Central Tendency  Measures.

### Mode
> category with heighest frequency.

### Median (for ordinal data only)
> mid value of sorted  values.

---



## Describing Numerical Data
### Frequency Tables for Numerical Data
>Group the discrete variables (counts) into bins, if the number of values is small, they can themself be considered as categories.

> Otherwise group data into bins (classes).
>> Classes can be used for both continous and discrete data.

>>> Take classes to be ***left-closed - right-open*** to ensure that the classes *partition* data.

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
### Mean
### Numerical Summaries.
+ Meaures of Central Tendency
	+ Median : Middle Value in a ***Ordered*** Dataset.
	+ Mode : Most frquently occuring value.
	+ Mean
		+ Mean : Average.
			+ ∑xᵢ/n
		+ extremely sensitive to outliers
		+ μ = Population Mean
		+ x̄ = Sample Mean
		+ Appx Mean for grouped data
			+ ∑fᵢxᵢ/n
			+ x is the class-mark.
+ Measure of Dispersion/variability/spread
	+ Range:
		+ Max - Min
		+ Sensitive , but only to extreme values.
	+ Variance:
		+ Deviation of value of data points. from central value of a data-set.
			+ σ<sup>2</sup>= ∑(xᵢ - x)<sup>2</sup>/N
		+ for sample means, denominator is kept ```(n-1)``` instead of n. (Statistical Correction)
		+ Welford’s method of computing sample Variance
			+ (n-1)σₙ<sup>2</sup>=(n-2)σ<sub>n-1</sub><sup>2</sup> +(xₙ-x̄ₙ)(xₙ-x̄<sub>n-1</sub>)
			```
			variance(samples):
				M := 0
				S := 0
					for k from 1 to N:
					x := samples[k]
					oldM := M
					M := M + (x-M)/k
					S := S + (x-M)*(x-oldM)
			return S/(N-1)
			```
		+ Single Pass
			+ simply accumulating the sums of xᵢ and x<sup>2</sup>ᵢ:
			+ σ<sup>2</sup> = ∑(x<sup>2</sup>ᵢ–2xx̄ᵢ+x̄<sup>2</sup>)/(N−1)
			+ σ<sup>2</sup> = (∑x<sup>2</sup>ᵢx–2Nx̄<sup>2</sup>+x̄<sup>2</sup>)/(N−1)
			+ σ<sup>2</sup> = (∑x<sup>2</sup>ᵢ–Nx̄<sup>2</sup>)/N−1

	+ Std Deviation
		+ √variance
		+ To maintain units of dispersion measure and data-points

### Five Number Summary
1. Min
2. Q₁ : lower quartile
3. Q<sub>2</sub> : mean
4. Q<sub>3</sub> : upper quartile
5. Max
#### Box Plot CandleStick Summary
	+ Five Number Summary Rep
	+ make a I cursor marking min/max.
	+ make a box on the cursor showing the IQR
	+ mark Q2 with a slicing line on the box

#### Percentiles
> Percentiles are right-closed - left-open
>> 80percentile means 80% are < it, and 20% are >= to it.

+ Manual Percentile Algorithm for 100 *p th percentile ( p is a fractional val.)
	+ Arrange data Ascendingly.
	+ If n\*p is not an integer,determine pos=floor(np). The posth data is the 100\*pth percentile
	+ Else 100*pth percentile= avg(np,np+1<sup>th</sup>obsv)
+ G sheet Percentile Algorithm.
	+ Rank= percentile*(n-1)+1
	+ Split Rank into integer and fractional part.
	+ Compute the ordered data value (odv₀) corresponding to integer rank.
	+ Percentile=odv₀+frac-rank*(odv₁ - odv₀)

#### Quartiles.
+ 25th percentile --> first quartile / lower quartile.
+ 50th percentile --> Mean.
+ 75th percentile --> third quartile / upper quartile.

#### Inter Quartile Range
>IQR
>>Q<sub>3</sub>-Q₁

---



---
# Association between two categorical variables
+ Contigency Table : Two-way Table for bivariate categorical data.
+ ij position has the data which satisfies both catgeory₁ val=c<sub>i₁</sub> and category<sub>2</sub> val=c<sub>2<sub>j</sub></sub>
+ Google Sheet Method
	+ choose column for association'+ In Data Tab - >Pivot Table.
	+ create a pivot table, and in edutor
		+ --> Rows --> click on first categorical variables
		+ --> Colums --> click on second catgeorical variable
		+ --> Values --> click on either variable and then click on COUNTA under "summarize by" tab.

## Relative frequencies
+ Row Relative Frequency --> Divide each Cell Frequency by its row total frequency
+ Column Relative Frequency --> Divide each Cell Frequency by its column total frequency
+ Assosiation Rule --> Column / Row Frequency for each Row/Column respectively are non homogenous --> there is a pattern of change in one category with the other category variable.
## Stacked Bar Chart
> Represents counts for a particular category, and is further segmented into segments, each segment representing the frequency of that particular category within the segment.
>> Can Represent two categories within one chart
### Google Sheet.
>Select Data for Contingency Table --> Insert Chart -->Stacked Column Chart.
>> If Stacking is ```Standard``` type, then the numbers show COunt, and ```100%``` Stacking shows relative frequency.


---
# Association between two numerical variables
## Scatterplot
> A graph that displays pairs of values as points on a 2D Plane.
>> For interpretting association of two *numerical* variables.
>>> Visual test for association.
### Google Sheet
1. Highlight Data to plot.
2. Insert Chart --> Scatter Charts
3. Under X-Axis Tab , choose the explanatory variable.
4. Under Series Tab , choose the response variable.

## Describing association
### The 4 key Qs.
1. Direction : Is there a pattern trend up, down or both?
2. Curvature: Does the pattern appear linear, or appear to follow some curve?
3. Variation: Are the points tightly clustered or variable?
4. Outliers: Are some points way off the majority pattern.
	> values that are
	>> < Q1-IQR  or  > Q3+IQR
### Quantyfying (Linear) Assosiation b/w numerical values.
+ Covariance
	+ Cov(x,y)=∑(xᵢ-x̄)*(yᵢ-ȳ)/N
	+ Denominator =```n-1``` if considering sample.
	+ Difficult to interpret due to units.
+ Correlation
	+ Pearson correlation Coefficient
	+ ρ<sub>xy</sub>= Cov(x,y)/((σ<sub>x</sub>σ<sub>y</sub>))

### Fitting a line
> Summarizing the linear association using a line on ℝ<sup>2</sup>
>> R<sup>2</sup> = Measure of Accuracy of Fit = correlation coeff <sup.2</sup>
>>Using Google Sheets
>>> In scatter Plot --> Customize--> Series -->Trend Line. -->Label -->Use Equation.


---
# Association between categorical and numerical variables
> Point Bi-Serial Correlation Coefficient
+ Group values into two sets based on values of the selected dichotomous variable (code them in binary, as 0 and 1) .
+ Calculate the mean values of the two groups ȳ₀ and ȳ₁.
+ let p₀ and p₁ be the proportion of the observations. and sₓ be the std deviation of the random value X.
+ rₚ=(ȳ₀ - ȳ₁)*√(p₀p₁)/sₓ
---

# Permutations and Combinations
+  Addition Principal of counting
	+ event A **or** B
	+ #A **+** #B
+  Multiplication Principal of Counting
	+ event A **and** B
	+ #A **X** #B

## Permutation:
> ordered arrangement
+ For Distinct Objects:
	+ ⁿPᵣ=n!/(n-r)! --> for N distinct objects, without repetation
	+ with repetation allowed,  ⁿP'ᵣ = nʳ
+ For non distinct objects each n-ordering occurs pᵢ times if an element is present in pᵢ duplicates.
	+ so, ⁿPₙ=n!/π(pᵢ!) where pᵢ is the number of copies of the repeating element.
+ For circular arrangements, the order of chosing the first elements position is irrelevant, hence
	+ ⁿPₙ=(n-1)!
	+ if AC/CLockwise are not distinct, the number gets divided by 2.

## Combinations:
+ ⁿCᵣ=ⁿPᵣ/r! =ⁿCₙ₋ᵣ
+ ⁿCᵣ=ⁿ⁻¹Cᵣ₋₁+ⁿ⁻¹Cᵣ
	+ that is it is the sum of the two entries above it in the pascal's triangle
	+ ⁿCᵣ=ⁿPᵣ/r! =ⁿCₙ₋ᵣ
	+ ⁿCᵣ=ⁿ⁻¹Cᵣ₋₁+ⁿ⁻¹Cᵣ
		+ that is, it is the sum of the two entries above it in the pascal's triangle
---

# Probability
* random experiment
* Sample Space : set of outcomes of experiment.
* event : subset of sample space
* disjoint events
* null event
* classical/apiori definition
	+ when there are n eqially likely outcomes in the sample space of a random experiment
	+ and event E contains exactly m of those, then,
	+ the probability of event E = ***P(E) = m/n***
* relative/ aposteriori/ emperical :
	+	probababiltu of an event in an experiment is
	+ the proprtion of times the event occurs in a very long(theoratically infinite) series of independent repetations of an experiment.
	+ P(E)= lim<sub>n→∞</sub> n(E)/n
	+ where n(E) is the number of times E occurs in n repetations of the experiment

## axiomatic theory of probability
1. 0≤P(E)≤1
2. P(S)=1
3. for a countable sequence of mutually disjoint events: P(∪Eᵢ) = ∑P(Eᵢ)
	+ addition rule of probability

## Conditional Probability
### contingency tables
>row relative frequencies gives conditional(marginal) and joint(sum total entries) probabilities.
### formula
> P(E if F has occured)= **P(E|F)** = P(E∩F)/P(F)
### Multiplication rule
> P(E∩F)=P(E|F) * P(F)
### Generalized Rule
> P(E₁∩E₂∩E₃∩E₄)=P(E₁) * P(E₂|E₁) * P(E₃| E₁∩E₂)....P(Eₙ|E₁∩E₂∩...Eₙ₋₁)
## Independent events
> P(E∩F)=P(E)XP(F)
### independence of more than one events
* if E is independent of F and also G,
* it is not necessarily independent of F∩G.
+ If E and F is independent, E and Fᶜ  are also independent
+ if E,F and G are independent , all mutual intersection probabilities follow the multiplication rule, and
	+ P(E∩F∩G)=P(E)XP(F)XP(G)

## Bayes' rule
### Law of total probabalities
P(E)=P(F)P(E|F)+P(Fᶜ)P(E|Fᶜ)
* probability of E is a weighted average of the conditional probability of E  given F happens and doesnt occur
* weighted by the probability of the event on which it is conditioned.
> Suppose Fᵢ are mutually excliusive and exhaustive then for any event E is a weighted sum = **∑P(E|Fᵢ)P(Fᵢ)**
### The Rule
* P(F|E)=P(F∩E)/P(E) = (P(E|Fᵢ)P(Fᵢ))/∑(P(E|Fᵢ)xP(Fᵢ))

---

# Random variables
## Random Expeiment
> experiment whose outcomes are known but not certain.

> Random Variable
>> real valued function defined on the sample space of a random experiment/
### Discrete and continuous random variable
>Discrete
>> isolated points on the real line, can take only countable number of different values.
> Continous
>> interval along the real number

# Probability mass function
* let X be a random variable with n possible outcomes labelled xᵢ.
* define PMF p(x) of X :
	* p(xᵢ)=P(X=xᵢ)
	* p(xᵢ)≥0
	* ∑p(xᵢ)=1
	* p(x) for any x ∉ { xᵢ }
> plot P(X=xᵢ) on y-axis, against xᵢ on X axis.
>> gives the shape of the random distribution.

## distribution shapes
1. Positive skewed , xᵢ increases pmf decreases
2. Negative skewed , xᵢ increases pmf decreases
3. Symetric
4. Uniform

# Cumulative distribution function
> F : ℝ → \[0,1\]
>>F(A) = P(X≤a)
* if X is a discrete random variable with values in exact ascending order  --> F of X is a step function
* size of the step =  probability of X that X assumes at that value.

# Expectation of a random variable
> Long run average
>> E(X)=∑xᵢP(X=xᵢ)
## Expectation of a function of a random variable
> E(*g(x)*)=∑(g(xᵢ)P(X=xᵢ))
## Linearity of Expextation
> E(X+Y)=E(X)+E(Y)

# Variance of a random variable
> Var(X)=E(X-E(X))²
>> E(X²)-E(X)
## independent random variables
* knowing the value of one doesnt change the expectation of the other.
* Var(X+Y)=Var(X)+Var(Y)

# Discrete Distributions

|Distribution                   |Description                                                                   |PMF                         |E(X)     |Var(X)                       |CDF         |
|    ---                        | ---                                                                          |    ---                     |    ---  |     ---                     |    ---     |
|Bernoulli                      |random variable that takes two value 1 or 0                                   | f(x)=p if x=1, 0 otherwise.|p        |p(p-1)                       |            |
|Discrete uniform               |each outcome is equally likely                                                | f(x)=1/n for each xᵢ.       |(n+1)/2  |(n²-1)/12                    |            |
|Hypergeometric(K true in N)    |bernoulli sampling without replacement, n at a time,k=var=num of successes    | f(k)=ᴷCₖ * ᴺ⁻ᴷCₙ₋ₖ / ᴺCₙ    |nm/N     |E*((n-1)(m-1)/(N-1) + 1 - E) |            |
|Binomial distribution          |var= # of successes in n iid bernoulli trials                                 | f(i)= ⁿCᵢ x pⁱ x (1-p)⁽ⁿ⁻ⁱ⁾    |np      | np(p-1)                     |            |

# probability density function
* every continous random variable has a curve associated with it.
* this curve is called it's probability density function f(x).
* area under a pdf = ₐ∫ᵇf(x)dx= P(X∈\[a,b\])
* 0≤f(x)≤1
* ᵐᵃˣ∫ₘᵢₙf(x)dx=1
# continous distributions
|Distribution                   |Description                                                                   |PDF                         |E(X)        |Var(X)                       |CDF                      |
|    ---                        | ---                                                                          |    ---                     |    ---     |     ---                     |    ---                  |
|uniform                        |constant distribution                                                         | f(I)=1/(max-min)           |(min+max)/2 |((max-min)²/12               |  (x-min)/(max-min)      |
|exponential                    |multiplicative probabilty, like no of offsprings in time                      | f(x)=ke⁻ᵏˣ                              |1/k         |1/k²                         | 1- e⁻ᵏᵃ       |

---
# WOrking With G-SHeets
## Functions:
+ SUMIF
	```
	=sumif(range,criteria)
	```
	> put *criteria* in double quotes.

	> equality criteria can be directly stated
	>> for instance = to a number or string is --> value itself can be used as the criteria,no need to write = value.
+ VLOOKUP






























<!-----------eof-------->

---