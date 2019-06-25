### OSM

```k
syntax Int ::= "#WordPackAddrUInt16UInt64" "(" Int "," Int "," Int ")"  [function]
rule #WordPackAddrUInt16UInt64(A, X, Y) => Y *Int pow176 +Int X *Int pow160 +Int A
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)

// val before has
syntax Int ::= "#WordPackUInt128UInt128" "(" Int "," Int ")"  [function]
rule #WordPackUInt128UInt128(X, Y) => Y *Int pow128 +Int X
  requires #rangeUInt(128, X)
  andBool  #rangeUInt(128, Y)

// syntax Int ::= "#WordPackBytes32UInt128" "(" Int "," Int ")"  [function]
// rule #WordPackBytes32UInt128(X, Y) => (Y &Int 340282366920938463463374607431768211455) *Int pow128 +Int X
//   requires #rangeUInt(128, X)
//   andBool  #rangeBytes(32, Y)

syntax Int ::= "#OSM.wards" "[" Int "]"   [function]
rule #OSM.wards[A] => #hashedLocation("Solidity", 0, A)

syntax Int ::= "#OSM.stopped"  [function]
rule #OSM.stopped => 1

syntax Int ::= "#OSM.src_hop_zzz"  [function]
rule #OSM.src_hop_zzz => 2

syntax Int ::= "#OSM.cur"  [function]
rule #OSM.cur => 3

syntax Int ::= "#OSM.nxt"  [function]
rule #OSM.nxt => 4

syntax Int ::= "#OSM.bud" "[" Int "]"  [function]
rule #OSM.bud[A] => #hashedLocation("Solidity", 5, A)
```

### DSValue

```k
syntax Int ::= "#WordPackAddrUInt8" "(" Int "," Int ")" [function]
// ----------------------------------------------------------
rule #WordPackAddrUInt8(A, X) => X *Int pow160 +Int A
  requires #rangeAddress(A)
  andBool #rangeUInt(8, X)

syntax Int ::= "#Src.authority" [function]
rule #Src.authority => 0

syntax Int ::= "#Src.owner_has" [function]
rule #Src.owner_has => 1

syntax Int ::= "#Src.val" [function]
rule #Src.val => 2
```
