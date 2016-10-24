## Patterns from Math

In programming, we often write functions over data structures to modify their internals, or perhaps
to indicate the way to modify something in the future. Functions do this, they map elements of types
to other types, allowing you to use them to abstract over this notion of modifying data structures.
There happens to be an even more general formulation of this idea which came out of the body of
mathematics called Category Theory. We won't cover this, but we'll cover the way it's used in
Haskell, which is thankfully much simpler. In Haskell this is represented by a class, which if you
haven't read about before you can totally go do that in Learn You a Haskell, as I encouraged in the
first bit.

```Haskell

class Functor f where
  fmap :: (a -> b) -> (f a -> f b)

```

Essentially, this class lets us talk about all types which give us the ability to lift a function
between two domains, to a function between the two domains mapped over by f, which is a type level
function, a template by C++ lingo, or a generic in Java lingo. This generalizes the following sort
of pattern:

The rules that we want implementations of Functor to obey are the following:

```Haskell

fmap f . fmap g = fmap (f . g) x
fmap id = id

```

This lets us optimize lots of code, for instance see the following, wherein we assume that the
data structure we are mapping these functions over is distributed throughout some huge database:

```Haskell

y = (fmap f1 . fmap f2 ... . fmap fn) x = fmap (f1 . f2 . ... . fn) x

```

The latter way would be much more convenient, and we can avoid a helluva lot of cache misses if x
is distributed in memory.

```Haskell

class Functor f => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b

```
