Xn+1 = (aXn + c) mod m
where X is the sequence of pseudo-random values
m, 0 <\ m  - modulus
a, 0 <\ a <\ m  - multiplier
c, 0 ≤ c <\ m  - increment
x0, 0 ≤ x0 <\ m  - the seed or start value



---

Choose the seed value X0, Modulus parameter m, Multiplier term a, and increment term c.
Initialize the required amount of random numbers to generate (say, an integer variable noOfRandomNums).
Define a storage to keep the generated random numbers (here, vector is considered) of size noOfRandomNums.
Initialize the 0th index of the vector with the seed value.
For rest of the indexes follow the Linear Congruential Method to generate the random numbers.

```python
def linearCongruentialMethod(Xo, m, a, c,
                             randomNums,
                             noOfRandomNums):

    # Initialize the seed state
    randomNums[0] = Xo

    # Traverse to generate required
    # numbers of random numbers
    for i in range(1, noOfRandomNums):

        # Follow the linear congruential method
        randomNums[i] = ((randomNums[i - 1] * a) +
                                         c) % m

# Driver Code
if __name__ == '__main__':

    # Seed value
    Xo = 5

    # Modulus parameter
    m = 7

    # Multiplier term
    a = 3

    # Increment term
    c = 3

    # Number of Random numbers
    # to be generated
    noOfRandomNums = 10

    # To store random numbers
    randomNums = [0] * (noOfRandomNums)

    # Function Call
    linearCongruentialMethod(Xo, m, a, c,
                             randomNums,
                             noOfRandomNums)

    # Print the generated random numbers
    for i in randomNums:
        print(i, end = " ")
```