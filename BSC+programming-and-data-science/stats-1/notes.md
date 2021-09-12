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


# WEEK 4
# Assosiation between Two Variables
___




<!-------->