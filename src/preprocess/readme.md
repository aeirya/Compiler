# Preprocessor
- Ignores single-line comments (using //)
- Replaces define id with body

## Sample:
Input:
```
define D1 hello there
// this is a comment
define D2 2
define D3 2.13
somebody said D1, does D3 has D2 in it
```
Output:
```
somebody said hello there, does 2.13 has 2 in it
```

## Sample 2:
Input:
```
define fori for(int i=0; i<100;++i) {
while fori
}
```
Output:
```
while for(int i=0; i<100;++i) {
}
```