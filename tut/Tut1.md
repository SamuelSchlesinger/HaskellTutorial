## Introduction

This is meant to be a concise tutorial which will show you the Haskell programming language
by example and explain the machinery behind each example with references to learn more. Below
is the definition of a polymorphic linked list in Haskell.

```Haskell

data List a 
  = More a (List a)
  | NoMore

```

What this code does for us is introduce a new type called List, as well as an invariant for
List which takes the following form:

```Haskell

forall (l :: List a). l = More x l' or l = NoMore

```


