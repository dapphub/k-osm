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

```act
behaviour src of OSM
interface src()

for all

    Src : address
    Hop : uint16
    Zzz : uint64
    

storage

    src_hop_zzz |-> #WordPackAddrUInt16UInt64(Src, Hop, Zzz)
    
iff

    VCallValue == 0

returns Src
```

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

```act
behaviour zzz of OSM
interface zzz()

for all

    Src : address
    Hop : uint16
    Zzz : uint64
    

storage

    src_hop_zzz |-> #WordPackAddrUInt16UInt64(Src, Hop, Zzz)
    
iff

    VCallValue == 0

returns Zzz
```

## rely

```act
behaviour rely-neq of OSM
interface rely(address guy)

for all

    May  : uint256
    Ward : uint256

storage

    wards[CALLER_ID] |-> May
    wards[guy]       |-> Ward  => 1
    
iff

    VCallValue == 0
    May == 1
    
if

    CALLER_ID =/= guy
```

```act
behaviour rely-eq of OSM
interface rely(address guy)

for all

    May : uint256

storage

    wards[CALLER_ID] |-> May => 1
    
iff

    VCallValue == 0
    May == 1
    
if

    CALLER_ID == guy
```

## deny

```act
behaviour deny-neq of OSM
interface deny(address guy)

for all

    May  : uint256
    Ward : uint256
    
storage

    wards[CALLER_ID] |-> May
    wards[guy]       |-> Ward => 0
    
iff

    VCallValue == 0
    May == 1
    
if

    CALLER_ID =/= guy
```

```act
behaviour deny-eq of OSM
interface deny(address guy)

for all

    May  : uint256
    
storage

    wards[CALLER_ID] |-> May => 0
    
iff

    VCallValue == 0
    May == 1
    
if

    CALLER_ID == guy
```

## bud

```act
behaviour bud of OSM
interface bud(address a)

for all

    Bud : bool

storage

    bud[a] |-> Bud
    
iff

    VCallValue == 0
    
returns Bud
```

## change

```act
behaviour change of OSM
interface change(address a)

for all

    Src  : address
    Hop  : uint16
    Zzz  : uint64
    Ward : uint256

storage

    wards[CALLER_ID] |-> Ward
    src_hop_zzz      |-> #WordPackAddrUInt16UInt64(Src, Hop, Zzz) => #WordPackAddrUInt16UInt64(a, Hop, Zzz)
    
iff

    Ward == 1
    VCallValue == 0
    
if

    a =/= Src
```
