# WEEK 0

## UNIT 0.0 Introduction.

## UNIT 0.1 The Road Ahead

+ How ->Implementation
+ What ->Abstraction.
+ The Black Box of programming language hierchy.
+ Seperate interface from its internal workings.
## UNIT 0.2 Nand to Hack

### big picture.
ROM <--> CPU <--> Ram
+ Design Hardware Abstractions using Hardware Description Language.
## UNIT 0.3 Hack to Tetris
Design a mini OS, and a rich OS/ IO Std Library for the Higher Programming Language Implementation
### Project 0
+ Get NAND2Tetris Suite running
+ Try Submitting demo file.

## UNIT 1.1 Boolean Logic

### Boolean Operations
1. x AND y
	+ x ^ y

	|x|y|AND|
	|---|---|---|
	|1|0|0|
	|0|0|0|
	|1|1|1|
	|0|1|0|
2. x OR y
	+ x ∨ y

	|x|y|OR|
	|---|---|---|
	|1|0|1|
	|0|0|0|
	|1|1|1|
	|0|1|1|
3.  NOT (x)
	+ ¬x

	|x|NOT|
	|---|---|
	|1|0|
	|0|1|

### Describing Boolean Functions/Expressions
+ Function Expressions
+ Truth Table ( Finite number of Inputs )

## UNIT 1.2 Boolean Function Synthesis

### Truth Table to Boolean Expression.
> Disjunctive Normal Form Formula
1. Go Row by Row.
2. Focus only on Rows thqat have value 1.
3. Write an expression that gets value 1 for that row only using NOTs and ANDs.
4. OR all the clauses.

>Any expression can be represented with NOTs and AND/OR.
>> Any boolean expression can be computed using only NANDs or only NORs.


## UNIT 1.3 Logic Gates

### Circuit Implementation of Elementary Logic Gates.

## UNIT 1.4 Hardware Description Language

### Gate Interface
```
CHIP name{
	IN inpa,inpb;
	OUT out;

	PARTS:
		/*IMPLEMANTATION*/
		/* Description of all connections
		eg- AND (a=inpa, b=inpb, out=andab)
		*/
	}

```
> HDL is a non procedural, static descriptive language. Textual representatipn of the Gate DIagram.
>> Order does not matter. Convention to describe left to right.

## UNIT 1.5 Hardware Simulation

### test scripts.
```
load ChipName.hdl;
set a 0, set b 0 , eval, output;
output-file ChipName.out;
compare-to ChipName.cmp;
output.list a b out;// the truth table
set a 0, set b 1 , eval, output;
//....
```
### Architect Builds the Black Box
+ A chip API
+ A test Script
+ Behavioral Simulation-> Compare FIle

### Developer Realizes the stuff within the Glass Box.
+ Describe the connections in HDL and turn the stub file(interface) into a working implementation
+ Test it using the test suite.


## UNIT 1.6 Multi-Bit Buses

+ Notation for multiple bits is similar to that of arrays in any higher level language.
+ eg : 16 bit input is called in by typing a[16]. then for using the entire buses use the var ```a``` without any subscript
+ to access a specific bus, call inp=a[0]..etc.
+ to access sublist ```[start..stop]```


## UNIT 1.7 Project 1
+ Given NAND gate
+ Build:
	+ Elementary
		1. [ ]  Not
		2. [ ]  And
		3. [ ]  Or
		4. [ ]  Xor
		5. [ ]  Mux
			+ a,b,set--> if set=0 -->output=a, else output=b.
			+ if an ossilator is fed to the mux, it can output intermix multiple msgs.
		6. [ ]  DMux
			+ invert Multiplexing.

	+ 16-Bit
		7. [ ] Not16
		8. [ ] And16
		9. [ ] Or16
		10. [ ] Mux16
	+ Multi-Way
		11. [ ] Or8Way
		12. [ ] Mux4Way16
		13. [ ] Mux8Way16
		14. [ ] DMux4Way16
		15. [ ] DMux8Way







<!----------------->