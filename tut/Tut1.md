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

length :: List a -> Int
length list = case list of
  More first rest -> 1 + length rest
  NoMore          -> 0

```

What the above declaration states is that, given any List, I know it can take at most two forms, so
I can check which one it is. If there are NoMore elements in the list, this means that it is of
length 0, so I can simply return 0. If there's one element in the first position of the list, then
I should add 1 for that element onto the length of the rest of the elements. This is the logical way
I understand this algorithm, and being able to do this case analysis inside of my programs as well
as in my mind is really excellent. 
