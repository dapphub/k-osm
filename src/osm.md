Table of Contents
=================

# Accessors

## wards

```act
behaviour wards of OSM
interface wards(address a)

for all

    Ward : uint256
    
storage

    wards[a] |-> Ward
    
iff

    VCallValue == 0
    
returns Ward
```

## src

// ```act
// behaviour src of OSM
// interface src()
// 
// for all
// 
//     Src : address
//     // Hop : uint16
//     // Zzz : uint64
//     
// 
// storage
// 
//     src_hop_zzz |-> #WordPackAddrUInt16UInt64(Src, _, _)
//     
// iff
// 
//     VCallValue == 0
// 
// returns Src
// ```

## hop

```act
behaviour hop of OSM
interface hop()

for all

    Src : address
    Hop : uint16
    Zzz : uint64
    

storage

    src_hop_zzz |-> #WordPackAddrUInt16UInt64(Src, Hop, Zzz)
    
iff

    VCallValue == 0

returns Hop
```

## zzz

