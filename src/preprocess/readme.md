# Preprocessor
- Ignores single-line comments (using //)
- Replaces constant defines (String, Integer, Float)

## Sample:
Input:
```
define D1 "hello"
// this is a comment
define D2 2
define D3 2.13
somebody told D1, does D3 has D2 in it
```
Output:
```
somebody told "hello", does 2.13 has 2 in it
```
