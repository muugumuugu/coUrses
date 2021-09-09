## Not
Logically invert a boolean vector

### Declaration
```glsl
bvec2 not(bvec2 x)  
bvec3 not(bvec3 x)  
bvec4 not(bvec4 x)
```

### Parameters
```x``` specifies the vector to be inverted.

### Description
```not()``` logically inverts the boolean vector ```x```. It returns a new boolean vector for which each element ```i``` is computed as ```!x[i]```.

### See Also
[any()](/glossary/?search=any), [all()](/glossary/?search=all)
