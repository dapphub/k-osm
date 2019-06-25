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

## stopped

```act
behaviour stopped of OSM
interface stopped()

for all

    Stopped : uint256

storage

    stopped |-> Stopped

iff

    VCallValue == 0

returns Stopped
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

    Bud : uint256

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

    Zzz + Hop <= TIME

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

    Zzz + Hop > TIME
    Zzz + Hop < pow64

iff

    VCallValue == 0

returns 0
```

## peek

```act
behaviour peek-eq of OSM
interface peek()

for all

    Val : uint128
    Has : uint128
    Bud : uint256

storage

    cur            |-> #WordPackUInt128UInt128(Val, Has)
    bud[CALLER_ID] |-> Bud

if

    Has == 1

iff

    VCallValue == 0
    Bud == 1

returns Val : 1
```

```act
behaviour peek-neq of OSM
interface peek()

for all

    Val : uint128
    Has : uint128
    Bud : uint256

storage

    cur            |-> #WordPackUInt128UInt128(Val, Has)
    bud[CALLER_ID] |-> Bud

if

    Has =/= 1

iff

    VCallValue == 0
    Bud == 1

returns Val : 0
```

## peep

```act
behaviour peep-eq of OSM
interface peep()

for all

    Val : uint128
    Has : uint128
    Bud : uint256

storage

    bud[CALLER_ID] |-> Bud
    nxt            |-> #WordPackUInt128UInt128(Val, Has)

if

    Has == 1

iff

    VCallValue == 0
    Bud == 1

returns Val : 1
```

```act
behaviour peep-neq of OSM
interface peep()

for all

    Val : uint128
    Has : uint128
    Bud : uint256

storage

    bud[CALLER_ID] |-> Bud
    nxt            |-> #WordPackUInt128UInt128(Val, Has)

if

    Has =/= 1

iff

    VCallValue == 0
    Bud == 1

returns Val : 0
```

## read

```act
behaviour read of OSM
interface read()

for all

    Bud : uint256
    Val : uint128
    Has : uint128

storage

    bud[CALLER_ID] |-> Bud
    cur            |-> #WordPackUInt128UInt128(Val, Has)

iff

    VCallValue == 0
    Bud == 1
    Has == 1

returns Val
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

## stop

```act
behaviour stop of OSM
interface stop()

for all

    Ward    : uint256
    Stopped : uint256

storage

    wards[CALLER_ID] |-> Ward
    stopped          |-> Stopped => 1

iff

    Ward == 1
    VCallValue == 0
```

## start

```act
behaviour start of OSM
interface start()

for all

    Ward    : uint256
    Stopped : uint256

storage

    wards[CALLER_ID] |-> Ward
    stopped          |-> Stopped => 0

iff

    Ward == 1
    VCallValue == 0
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
    CurHas  : uint128
    NxtVal  : uint128
    NxtHas  : uint128
    Ward    : uint256
    Stopped : uint256

storage

    wards[CALLER_ID] |-> Ward
    cur              |-> #WordPackUInt128UInt128(CurVal, CurHas) => #WordPackUInt128UInt128(0, 0)
    nxt              |-> #WordPackUInt128UInt128(NxtVal, NxtHas) => #WordPackUInt128UInt128(0, 0)
    stopped          |-> Stopped => 1

iff

    Ward == 1
    VCallValue == 0
```

## poke

```act
behaviour poke-ok of OSM
interface poke()

for all

    Stopped : uint256
    Src     : address DSValue
    Hop     : uint16
    Zzz     : uint64
    Wut     : uint256
    Ok      : bool
    CurVal  : uint128
    CurHas  : uint128
    NxtVal  : uint128
    NxtHas  : uint128

storage

    stopped       |-> Stopped
    src_hop_zzz   |-> #WordPackAddrUInt16UInt64(Src, Hop, Zzz) => #WordPackAddrUInt16UInt64(Src, Hop, (TIME - (TIME %Int Hop)))
    cur           |-> #WordPackUInt128UInt128(CurVal, CurHas)  => #WordPackUInt128UInt128(NxtVal, NxtHas)
    nxt           |-> #WordPackUInt128UInt128(NxtVal, NxtHas)  => pow128 +Int (MaskFirst16 &Int Wut)

storage Src

    val  |-> Wut
    has  |-> Ok

iff

    VCallValue == 0
    VCallDepth < 1024
    Stopped == 0
    Hop =/= 0
    TIME >= Zzz + Hop

if

    #rangeUInt(48, TIME)
    Ok =/= 0
```

```act
behaviour poke-not-ok of OSM
interface poke()

for all

    Stopped : uint256
    Src     : address DSValue
    Hop     : uint16
    Zzz     : uint64
    Wut     : uint256
    Ok      : bool

storage

    stopped       |-> Stopped
    src_hop_zzz   |-> #WordPackAddrUInt16UInt64(Src, Hop, Zzz)

storage Src

    val  |-> Wut
    has  |-> Ok

iff

    VCallValue == 0
    VCallDepth < 1024
    Stopped == 0
    TIME >= Zzz + Hop

if

    #rangeUInt(48, TIME)
    Ok == 0
```

## kiss

```act
behaviour kiss of OSM
interface kiss(address a)

for all

    Ward : uint256
    Bud  : uint256

storage

    wards[CALLER_ID] |-> Ward
    bud[a]           |-> Bud   => 1

iff

    VCallValue == 0
    Ward == 1
    a =/= 0
```

## diss

```act
behaviour diss of OSM
interface diss(address a)

for all

    Ward : uint256
    Bud  : uint256

storage

    wards[CALLER_ID] |-> Ward
    bud[a]           |-> Bud   => 0

iff

    VCallValue == 0
    Ward == 1
```


# DSValue

```act
behaviour peek of DSValue
interface peek()

types
  Owner : address
  Value : bytes32
  Ok    : bool

storage
  1 |-> #WordPackAddrUInt8(Owner, Ok)
  2 |-> Value

iff
  VCallValue == 0

returns Value : Ok
```

```act
behaviour read of DSValue
interface read()

types
  Owner : address
  Value : bytes32
  Ok    : bool

storage
  1 |-> #WordPackAddrUInt8(Owner, Ok)
  2 |-> Value

iff
  VCallValue == 0
  Ok == 1

returns Value
```
