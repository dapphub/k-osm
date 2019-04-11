### macros

```k
syntax Int ::= "pow16"   [function]
syntax Int ::= "pow160"  [function]
syntax Int ::= "pow176"  [function]
rule pow16  => 65536                                                  [macro]
rule pow160 => 1461501637330902918203684832716283019655932542976      [macro]
rule pow176 => 95780971304118053647396689196894323976171195136475136  [macro]

syntax Int ::= "mersenne16"        [function]
syntax Int ::= "mersenne160"       [function]
rule mersenne16  => 65535          [macro]
rule mersenne160 => 1461501637330902918203684832716283019655932542975 [macro]

syntax Int ::= "minUInt16"
             | "maxUInt16"
             | "minUInt64"
             | "maxUInt64"

rule minUInt16         =>  0                                   [macro]
rule maxUInt16         =>  65535                               [macro]
rule minUInt64         =>  0                                   [macro]
rule maxUInt64         =>  18446744073709551615                [macro]
rule #rangeUInt(16, X) => #range(minUInt16 <= X <= maxUInt16)  [macro]
rule #rangeUInt(64, X) => #range(minUInt64 <= X <= maxUInt64)  [macro]

```

### string literal syntax

```k

syntax Int ::= "#string2Word" "(" String ")" [function]
// ----------------------------------------------------
rule #string2Word(S) => #asWord(#padRightToWidth(32, #parseByteStackRaw(S)))
```

### hashed storage

```k
// hashed storage offsets never overflow (probabilistic assumption):
rule chop(keccakIntList(L) +Int N) => keccakIntList(L) +Int N
  requires N <=Int 100

// solidity also needs:
rule chop(keccakIntList(L)) => keccakIntList(L)
// and
rule chop(N +Int keccakIntList(L)) => keccakIntList(L) +Int N
  requires N <=Int 100
```

### solidity masking

```k

rule X |Int 0 => X

rule chop(A &Int B) => A &Int B
  requires #rangeUInt(256, A)
  andBool #rangeUInt(256, B)

rule chop(A |Int B) => A |Int B
  requires #rangeUInt(256, A)
  andBool #rangeUInt(256, B)
  
rule (Y *Int pow176 +Int X *Int pow160 +Int A) <Int pow256 => true
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)

rule mersenne160 &Int (Y *Int pow176 +Int X *Int pow160 +Int A) => A
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)
  
rule mersenne16 &Int (Y *Int pow176 +Int X *Int pow160 +Int A) /Int pow160 => X
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)
  
// rule (Y *Int pow176 +Int X *Int pow160 +Int A) /Int pow
```
