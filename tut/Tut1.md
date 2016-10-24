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


