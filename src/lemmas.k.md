### 

```k

// Masking for packed words
rule MaskLast20 &Int (Y *Int pow176 +Int X *Int pow160 +Int A) => Y *Int pow176 +Int X *Int pow160
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)
  
rule B |Int (Y *Int pow176 +Int X *Int pow160) => Y *Int pow176 +Int X *Int pow160 +Int B
  requires #rangeAddress(B)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)
  
rule (Y *Int pow176 +Int X *Int pow160 +Int A) /Int pow176 => Y
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)
  
rule MaskFirst6 &Int (X *Int pow176 +Int Y *Int pow160 +Int A) => Y *Int pow160 +Int A
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)
  
rule (X *Int pow176) |Int (Y *Int pow160 +Int A) => (X *Int pow176 +Int Y *Int pow160 +Int A)
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)
```


### signed 256-bit integer arithmetic

```k
rule #unsigned(X) ==K 0 => X ==Int 0
  requires #rangeSInt(256, X)

// rule 0 <Int #unsigned(X) => 0 <Int X
//   requires #rangeSInt(256, X)

// uadd
// lemmas for necessity
rule notBool(chop(A +Int B) <Int A) => A +Int B <=Int maxUInt256
  requires #rangeUInt(256, A)
  andBool #rangeUInt(256, B)

// usub
// lemmas for necessity
rule notBool(A -Word B >Int A) => (A -Int B >=Int minUInt256)
  requires #rangeUInt(256, A)
  andBool #rangeUInt(256, B)

// addui
// lemmas for sufficiency
rule chop(A +Int #unsigned(B)) => A +Int B
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool #rangeUInt(256, A +Int B)

// lemmas for necessity
// rule chop(A +Int #unsigned(B)) >Int A => (A +Int B <=Int maxUInt256)
//   requires #rangeUInt(256, A)
//   andBool #rangeSInt(256, B)
//   andBool B >=Int 0

rule chop(A +Int B) >Int A => (A +Int B <=Int maxUInt256)
  requires #rangeUInt(256, A)
  andBool #rangeUInt(256, B)

rule (A +Int #unsigned(B) <=Int maxUInt256) => (A +Int B <=Int maxUInt256)
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool B >=Int 0

rule chop(A +Int #unsigned(B)) <Int A => (A +Int B >=Int minUInt256)
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool B <Int 0

// subui
// lemmas for sufficiency
rule A -Word #unsigned(B) => A -Int B
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool #rangeUInt(256, A -Int B)

// lemmas for necessity
// rule A -Word #unsigned(B) <Int A => (A -Int B >=Int minUInt256)
//   requires #rangeUInt(256, A)
//   andBool #rangeSInt(256, B)
//   andBool B >=Int 0

rule A -Word B <Int A => (A -Int B >=Int minUInt256)
  requires #rangeUInt(256, A)
  andBool #rangeUInt(256, B)

rule (A -Int #unsigned(B) >=Int minUInt256) => (A -Int B >=Int minUInt256)
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool B >=Int 0

rule A -Word #unsigned(B) >Int A => (A -Int B <=Int maxUInt256)
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool B <Int 0

// mului
// lemmas for sufficiency
rule A *Int #unsigned(B) => #unsigned(A *Int B)
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool #rangeSInt(256, A *Int B)

rule abs(#unsigned(A *Int B)) /Int abs(#unsigned(B)) => A
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool #rangeSInt(256, A *Int B)
  andBool notBool (#unsigned(B) ==Int 0)

// possibly get rid of
rule #sgnInterp(sgn(W), abs(W)) => W
  requires #rangeUInt(256, W)

rule #sgnInterp(sgn(#unsigned(A *Int B)), A) => A
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool #rangeSInt(256, A *Int B)
  andBool B >=Int 0

rule #sgnInterp(sgn(#unsigned(A *Int B)) *Int (-1), A) => A
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool #rangeSInt(256, A *Int B)
  andBool B <Int 0

// lemmas for necessity
rule (#sgnInterp(sgn(chop(A *Int #unsigned(B))), abs(chop(A *Int #unsigned(B))) /Int abs(#unsigned(B))) ==K A) => A *Int B <=Int maxSInt256
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool B >Int 0

rule (#sgnInterp(sgn(chop(A *Int #unsigned(B))) *Int (-1), abs(chop(A *Int #unsigned(B))) /Int abs(#unsigned(B))) ==K A) => A *Int B >=Int minSInt256
  requires #rangeUInt(256, A)
  andBool #rangeSInt(256, B)
  andBool B <Int 0

rule (chop(A *Int B) /Int B ==K A) => A *Int B <=Int maxUInt256
  requires #rangeUInt(256, A)
  andBool #rangeUInt(256, B)
```
