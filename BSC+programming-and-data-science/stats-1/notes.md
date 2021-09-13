# WEEK 1
## Downloading Data, Intro to Statistics
___

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

## Lec 1.3 - Introduction and Types of Data - Classification of Data

>Numerical Data
+ Unit of Measurement
+ quantitative
+ types
	+ discrete
	+ continuous

>Categorical Data
+ Value of Variable belongs to a certaim enumerable set of values.
	+ identify the group membership
+ qualitative

>Time Series Data
>> data recorded over time

>Cross Sectional Data
>>data recorded at a point of time

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

# WEEK 2
## Describing Categorical Data - one variable
___

## Lec 2.1 - Describing Categorical Data - Frquency Distributions
> Frequency Table - Listing of diistinct values of a Catgerical Value and their counts in the cases.
>> One Tally Mark for each occurence of the value.
### In Google Sheets
Select data Cells ⇾ Format Menu ⇾ Data ⇾ Pivot Table ⇾ Add rows and Data.

> Relative Frequency - a standard for comparison. Ratio of frequency to Total Count.

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

## Lec 2.3 - Describe Categorical Data - BestPractices-1

> Annotate Data in Charts with both labels of the Categorical Value, and with the frequency/relative frequency.

## Lec 2.4 - Best Practices - 2

> Area Principle:
>> area occupied by portion of chart should correspond to ampunt of data.

>Misleading Baselines.
>> Such truncatio confuses due to
>>> + loss of data
>>> + incorrect represa=entation in terms of proportions.
>>if needed Y axis breaks should be marked.

## Lec 2.5 - Mode and Median.
> Central Tendency  Measures.

> Mode
>> category with heighest frequency.

> Median (for ordinal data only)
>> mid value of sorted  values.

# WEEK 3
# Describing Numerical Data - one variable
___

## Lec 3.1 - Describing Numerical Data - Frequency Tables for Numerical Data

>Group the discrete variables (counts) into bins, if the number of values is small, they can themself be considered as categories.

> Otherwise groupd data into bins (classes).
>> Classes can be used for both continous and discrete data.\
>> Take classes to be ***left-closed - right-open*** to ensure that the classes *partition* data.\
>> Conventional to have equiwidth classes.
### Plotting such frquency tables.
+ Use a Histogram.
> Google Sheet Method.
>>Insert -> Chart -> Chart - Editor -> Select Data -> Customize -> Bucket Size : Class-Width.

+ Stem -Leaf Plot.
	+ Stem : All but right-most Digit
	+ Leaf : rightmost digit.
	+ Steps
		1. Each Obsv := Stem
		2. Write Stems in Ascending order in a vertical column.
		3. Write each leaf to the write of its corresponding stem entry.
		4. Arrange Leaves in each row in Ascending order.
	+ Example:
		+ data : 15,22,29,36,31,23,45,10.
		+ Chart\
		|STEM| LEAF|
		| ---|--- |
		|1|0,5|
		|2|2,3,9|
		|3|1,6|
		|4|5|

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

## Lec 3.3 - Describing Numerical Data - Median and Mode

> Median : Middle Value in a ***Ordered*** Dataset.
> Mode : Most frquently occuring value.

## Lec 3.4 - Describing Numerical Data - Measures of dispersion- Range

>Range:
>> Max - Min
>> Sensitive , but only to extreme values.

> Variance:
>> Deviation of value of data points. from central value of a data-set.\
>> σ<sup>2</sup>= ∑(x<sub>i - C)<sup>3</sup>/N
>>>for sample means, denominator is kept ```(n-1)``` instead of n\
>>> Std Deviation : √variance
>>>> To maintain units of dispersion measure and data-points

> Percentiles are right-closed - left-open
>> 80percentile means 80% are < it, and 20% are >= to it.

>Manual Percentile Algorithm for 100 *p th percentile ( p is a fractional val.)
>>Arrange data Ascendingly.\
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
+ Q<sub>1</sub> : lower quartile
+ Q<sub>2</sub> : mean
+ Q<sub>3</sub> : upper quartile
+ Max

### Inter Quartile Range
>IQR
>>Q<sub>3</sub>-Q<sub>1</sub>

# WEEK 4
# Assosiation between Two Variables
___





<!-------->