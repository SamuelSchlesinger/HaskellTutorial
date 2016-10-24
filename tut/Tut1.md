## Introduction

This is meant to be a concise tutorial which will show you the Haskell programming language
by example and explain the machinery behind each example with references to learn more. Below
is the definition of a polymorphic linked list in Haskell.

```Haskell

data List a 
  = More a (List a)
  | NoMore

```

What this code does for us is introduce a new type called List which takes a function a in a
similar way to Java generics or C++ templates, as well as an invariant for List which says that 
if we know that l1 is a "List Int", then we know that it takes one of two forms, for some unknown n
and l2:

```Haskell

l1 = More n l2
or
l1 = NoMore

```

This is great! With this knowledge in hand, we can use what's called in Haskell a "case statement",
which I can demonstrate with the following example which takes the length of a list:

```Haskell

length :: List a -> Integer
length list = case list of
  More first rest -> 1 + length rest
  NoMore          -> 0

```

What the above declaration states is that, given any List, I know it can take at most two forms, so
I can check which one it is. If there are NoMore elements in the list, this means that it is of
length 0, so I can simply return 0. If there's one element in the first position of the list plus 
More, then I should add 1 for that element onto the length of the rest of the elements. 
This is the logical way I understand the above algorithm and many others, by reasoning about every
distinct case of input that may come in, and being able to do this case by case analysis inside of 
my programs as well feels really productive. For reference, in Haskell, the list type is denoted
by this built in notation instead of the way we've defined it:

```Haskell

data [a] 
  = a : [a]
  | []

```
There is also syntactic sugar for lists:

```Haskell

lengthTwo :: [a] -> Bool
lengthTwo xs = case xs of
  [a1, a2] -> True
  _        -> False

```

The things I've introduced so far, albeit briefly, are to me the reason why Haskell is the most
productive programming language to use and I'm pretty certain when I say that Haskell and it's derivatives (Purescript, Elm, etc) really do have the best facilities for this type of programming. OCaml is definitely a close second but there are lousily long keywords in certain areas that just makes me miss the Haskell syntax. The following two functions are very important and illustrate the essential flavor of functional programming:

```Haskell

filter :: (a -> Bool) -> [a] -> [a]
filter p as = case as of
  a : as -> if p a 
    then a : filter p as 
    else filter p as
  [] -> []

map :: (a -> b) -> [a] -> [b]
map f as = case as of
  a : as -> f a : map f as
  [] -> []

```

What filter does is the following: given a function p from a to Bool, and a list of as, filter p as
gives me a list of as for which I can be sure all of them satisfy the predicate. This is even obvious in the declaration itself, as it runs over the list creating a new one, only adding each element if they satisfy the predicate p supplied. 

What map does is the following: given a function f from a to b, and a list of as, map f as will be a list with the same structure as the one passed in, but with each a being mapped to f a. 
