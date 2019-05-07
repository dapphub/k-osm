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

## pass

```act
behaviour pass-true of OSM
interface pass()

for all

    Src : address
    Hop : uint16
    Zzz : uint64

storage

    src_hop_zzz |-> #WordPackAddrUInt16UInt64(Src, Hop, Zzz)

if

    TIME >= Zzz + Hop
    
iff

    VCallValue == 0
    
returns 1
```

```act
behaviour pass-false of OSM
interface pass()

for all

    Src : address
    Hop : uint16
    Zzz : uint64

storage

    src_hop_zzz |-> #WordPackAddrUInt16UInt64(Src, Hop, Zzz)

if

    TIME < Zzz + Hop
    
iff

    VCallValue == 0
    
returns 0
```

## peek

```act
behaviour peek of OSM
interface peek()

for all

    Val : uint128
    Has : bool
    Bud : bool

storage

    cur            |-> #WordPackUInt128Bool(Val, Has)
    bud[CALLER_ID] |-> Bud
    
iff

    Bud == 1
    VCallValue == 0
    
returns Val : Has
```


# Mutators

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
```

## step

```act
behaviour step of OSM
interface step(uint16 ts)

for all

    Src  : address
    Hop  : uint16
    Zzz  : uint64
    Ward : uint256

storage

    wards[CALLER_ID] |-> Ward
    src_hop_zzz      |-> #WordPackAddrUInt16UInt64(Src, Hop, Zzz) => #WordPackAddrUInt16UInt64(Src, ts, Zzz)
    
iff

    Ward == 1
    VCallValue == 0
    ts > 0
```

## void

```act
behaviour void of OSM
interface void()

for all
    
    CurVal  : uint128
    CurHas  : bool
    NxtVal  : uint128
    NxtHas  : bool
    Ward : uint256

storage

    wards[CALLER_ID] |-> Ward
    cur              |-> #WordPackUInt128Bool(CurVal, CurHas) => #WordPackUInt128Bool(0, 0)
    nxt              |-> #WordPackUInt128Bool(NxtVal, NxtHas) => #WordPackUInt128Bool(0, 0)
    
iff

    Ward == 1
    VCallValue == 0
```

## poke

## kiss

```act
behaviour kiss of OSM
interface kiss(address a)

for all

    Ward : uint256
    Bud  : bool

storage

    wards[CALLER_ID] |-> Ward
    bud[a]           |-> Bud   => 1
    
iff

    Ward == 1
    a =/= 0
    VCallValue == 0
```

## diss

```act
behaviour diss of OSM
interface diss(address a)

for all

    Ward : uint256
    Bud  : bool

storage

    wards[CALLER_ID] |-> Ward
    bud[a]           |-> Bud   => 0
    
iff

    Ward == 1
    VCallValue == 0
```
