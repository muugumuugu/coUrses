##IO
### running the file handler
```python
fh=open(fname,mode)
```
####modes
'r' : read
'r+': read n write
'w' : write afresh
'a' : append

###input
```python
fh.read() # returns all the content as a single string
```
```python
fh.readline() # moves cursor to next line, returns current line.
```
```python
fh.readlines() # returns the entire content indexed as a list of lines.
```
###output
```python
fh.write(string to write) # does not add newline @ the end.
```
```python
fh.writelines(string to write # doesnot add newline.
```
###clearing the file handler
```python
fh.close() # clears file handler.
```

## MODULES
### Official Modules
[https://docs.python.org/3/py-modindex.html](Modules for Functionality)

### installing a module
```bash
pip install modulename
```
###importing installed external modules, generally placed in Python installation Directories **Lib** subdirectory.* some modules may even be compartmented into ***site-packages***  subdirectory if they are not pre-installed.*
```python
import modulename # gets module as an object, which has as properties the functions,constants,classes etc of module.

```
```python
from modulename import * # imports all definitions of module and adds it as properties of current py file.
```
##CLASSES
### building the class type
```python
class SampleClassFunction: # modelling & wrapping a data type by giving it attributes
	def __init__(self, arg1,arg2,arg3): # initializing function, self refers to the object instance, is not part of the arguments to be passed while running, class calling passes it along with the other parameters.
		self.property1=arg1
		self.property2=arg2
		self.property3=arg3
	def classfunc1(self,argf1,argf2):
		#code for the function
		return somestuff
```
### instansiation
```python
sampleinstance=SampleClassFunction(arg1var,arg2var,arg3var)to create an object, use the class function
```
### inheritance
```python
```