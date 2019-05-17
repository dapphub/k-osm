### macros

```k
syntax Int ::= "pow16"   [function]
syntax Int ::= "pow128"  [function]
syntax Int ::= "pow160"  [function]
syntax Int ::= "pow176"  [function]
rule pow16  => 65536                                                  [macro]
rule pow128 => 340282366920938463463374607431768211456                [macro]
rule pow160 => 1461501637330902918203684832716283019655932542976      [macro]
rule pow176 => 95780971304118053647396689196894323976171195136475136  [macro]

syntax Int ::= "MaskFirst30"                                           [function]
syntax Int ::= "MaskFirst24"                                           [function]
syntax Int ::= "MaskFirst16"                                           [function]
syntax Int ::= "MaskFirst12"                                           [function]
syntax Int ::= "MaskLast20"                                            [function]
syntax Int ::= "MaskLast16"                                            [function]
syntax Int ::= "MaskZzz"                                               [function]
rule MaskFirst30 => 65535                                              [macro]
rule MaskFirst24 => 18446744073709551615                               [macro]
rule MaskFirst16 => 340282366920938463463374607431768211455            [macro]
rule MaskFirst12 => 1461501637330902918203684832716283019655932542975  [macro]
rule MaskLast20 => 115792089237316195423570985007226406215939081747436879206741300988257197096960 [macro]
rule MaskLast16 => 115792089237316195423570985008687907852929702298719625575994209400481361428480 [macro]
rule MaskZzz => 115790322390251417039241497492158469052807804578432885314823438572906973495295 [macro]

syntax Int ::= "minUInt16"
             | "maxUInt16"
             | "minUInt64"
             | "maxUInt64"
             | "minUInt128"
             | "maxUInt128"

rule minUInt16         =>  0                                   [macro]
rule maxUInt16         =>  65535                               [macro]
rule minUInt64         =>  0                                   [macro]
rule maxUInt64         =>  18446744073709551615                [macro]
rule minUInt128        =>  0                                   [macro]
rule maxUInt128        =>  340282366920938463463374607431768211455 [macro]
rule #rangeUInt(16, X) => #range(minUInt16 <= X <= maxUInt16)  [macro]
rule #rangeUInt(64, X) => #range(minUInt64 <= X <= maxUInt64)  [macro]
rule #rangeUInt(128, X) => #range(minUInt128 <= X <= maxUInt128)  [macro]
```

### hashed storage

```k
// // hashed storage offsets never overflow (probabilistic assumption):
// rule chop(keccakIntList(L) +Int N) => keccakIntList(L) +Int N
//   requires N <=Int 100
//
// // solidity also needs:
// rule chop(keccakIntList(L)) => keccakIntList(L)
// // and
// rule chop(N +Int keccakIntList(L)) => keccakIntList(L) +Int N
//   requires N <=Int 100
```

### solidity masking

```k
rule X |Int 0 => X
  requires #rangeUInt(256, X)

rule chop(A &Int B) => A &Int B
  requires #rangeUInt(256, A)
  andBool #rangeUInt(256, B)

rule chop(A |Int B) => A |Int B
  requires #rangeUInt(256, A)
  andBool #rangeUInt(256, B)

rule (A |Int B) <Int pow256 => true
  requires #rangeUInt(256, A)
  andBool #rangeUInt(256, B)

rule (A &Int B) <Int pow256 => true
  requires #rangeUInt(256, A)
  andBool #rangeUInt(256, B)
```

#### packing { address uint16 uint64 }

```k
rule (Y *Int pow176 +Int X *Int pow160 +Int A) <Int pow256 => true
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)

rule MaskFirst12 &Int (Y *Int pow176 +Int X *Int pow160 +Int A) => A
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)

rule MaskFirst24 &Int (Y +Int X) => Y +Int X
  requires #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)

rule MaskFirst30 &Int (Y *Int pow176 +Int X *Int pow160 +Int A) /Int pow160 => X
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)

rule MaskLast20 &Int (Y *Int pow176 +Int X *Int pow160 +Int A) => Y *Int pow176 +Int X *Int pow160
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)

// could be strenghtened to #rangeUInt(80, Y) but...
rule (Y *Int pow176 +Int X *Int pow160 +Int A) /Int pow176 => Y
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)

rule A |Int (Y *Int pow176 +Int X *Int pow160) => Y *Int pow176 +Int X *Int pow160 +Int A
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)

rule (Y *Int pow176) |Int (X *Int pow160 +Int A) => Y *Int pow176 +Int X *Int pow160 +Int A
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)

rule MaskZzz &Int (Y *Int pow176 +Int X *Int pow160 +Int A) => X *Int pow160 +Int A
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)
```

#### packing { uint128 uint128 }

```k
rule (Y *Int pow128 +Int X) <=Int maxUInt256 => true
  requires #rangeUInt(128, X)
  andBool #rangeUInt(128, Y)

rule MaskLast16 &Int (Y *Int pow128 +Int X) => Y *Int pow128
  requires #rangeUInt(128, Y)
  andBool #rangeUInt(128, X)

// special case
rule MaskLast16 &Int (pow128 +Int X) => pow128
  requires #rangeUInt(128, X)

rule MaskFirst16 &Int (Y *Int pow128 +Int X) => X
  requires #rangeUInt(128, Y)
  andBool #rangeUInt(128, X)

// special case for a boolean
rule MaskFirst16 &Int (pow128 +Int X) => X
  requires #rangeUInt(128, X)

rule X |Int (Y *Int pow128) => Y *Int pow128 +Int X
  requires #rangeUInt(128, Y)
  andBool #rangeUInt(128, X)

rule (Y *Int pow128) |Int X => Y *Int pow128 +Int X
  requires #rangeUInt(128, Y)
  andBool #rangeUInt(128, X)

rule (Y *Int pow128 +Int X) /Int pow128 => Y
  requires #rangeUInt(128, X)
  andBool #rangeUInt(128, Y)

rule MaskFirst16 &Int (X *Int pow128) => 0
  requires #rangeUInt(128, X)

rule MaskLast16 &Int X => 0
  requires #rangeUInt(128, X)
```

### poke

```k
// not being used?
rule T -Int (T %Int X) <=Int maxUInt64 => true
  requires #rangeUInt(48, T)
  andBool #rangeUInt(16, X)
rule T -Int (T %Int X) >=Int minUInt64 => true
  requires #rangeUInt(48, T)
  andBool #rangeUInt(16, X)

// not being used?
rule (MaskFirst16 &Int X) <=Int maxUInt128 => true
  requires #rangeUInt(256, X)
rule (MaskFirst16 &Int X) >=Int minUInt128 => true
  requires #rangeUInt(256, X)

rule chop(X *Int pow128 +Int (MaskFirst16 &Int Y)) => X *Int pow128 +Int (MaskFirst16 &Int Y)
  requires #rangeUInt(128, X)
  andBool #rangeUInt(256, Y)

rule MaskFirst16 &Int (X *Int pow128 +Int (MaskFirst16 &Int Y)) => MaskFirst16 &Int Y
  requires #rangeUInt(128, X)
  andBool #rangeUInt(256, Y)

rule pow128 |Int (MaskFirst16 &Int Y) => pow128 +Int (MaskFirst16 &Int Y)
  requires #rangeUInt(256, Y)

rule chop(pow128 +Int (MaskFirst16 &Int Y)) => pow128 +Int (MaskFirst16 &Int Y)
  requires #rangeUInt(256, Y)
```
