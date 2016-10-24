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

```Haskell

data Counted a = Counted a Integer

modifyCounted :: (a -> b) -> Counted a -> Counted b
modifyCounted f (Counted a n) = modify (f a) n

data Stream a = Stream a (Stream a)
modifyAll :: (a -> b) -> Stream a -> Stream b
modifyAll f (Stream a as) = Stream (f a) (modifyAll f as)

```
