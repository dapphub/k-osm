
```k
syntax Int ::= "#OSM.wards" "[" Int "]"   [function]
rule #OSM.wards[A] => #hashedLocation("Solidity", 2, A)

syntax Int ::= "pow160"  [function]
syntax Int ::= "pow176"  [function]
rule pow160 => 1461501637330902918203684832716283019655932542976      [macro]
rule pow176 => 95780971304118053647396689196894323976171195136475136  [macro]

syntax Int ::= "#WordPackAddrUInt16UInt64" "(" Int "," Int "," Int ")" [function]

rule #WordPackAddrUInt16UInt64(A, X, Y) => Y *Int pow176 +Int X *Int pow160 +Int A
  requires #rangeAddress(A)
  andBool #rangeUInt(16, X)
  andBool #rangeUInt(64, Y)
  
syntax Int ::= "#OSM.src_hop_zzz"  [function]
rule #OSM.src_hop_zzz => 3
```
