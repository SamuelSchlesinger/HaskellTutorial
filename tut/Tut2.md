## And Then There Was IO

In Haskell, we want to make sure of the following invariant:

```Haskell

f = g

e = ... f ... if and only if e = ... g ... 

```

What this means is that we want a much more strong notion of "assignment" than
other language. It's so strong, that calling the declaration "f = g" is really 
a misnomer. What the above invariant means is that if we actually know that f
is equal to g, then we should really be able to replace f with g anywhere that f
is used and not modify the meaning of our code. In fact, we can also evaluate
our expressions this way, recalling map from the previous section:

```Haskell

map (+ 1) xs = case xs of
  [] -> []
  x : xs -> f x : map f xs

map f [1, 2, 3, 4] 
2 : map f [2, 3, 4] 
2 : 3 : map f [3, 4] 
2 : 3 : 4 : map f [4] 
2 : 3 : 4 : 5 : map f []
2 : 3 : 4 : 5 : []

```

For one thing, this is an obvious way to show to ourselves that our map function actually
does what I claimed it to do. Something that's interesting is thinking about how this would
work in a language like Java, where we have statements and blocks which don't even have types
and can't interact smoothly with the other parts of the language. This ability to transform
our programs is great from the perspective of correctness and the ability to inspect the execution
of our programs on concrete and unspecified inputs.

This all appears great, but consider the following program:

```Haskell

getChars :: FilePath -> [Char]

length (getChars "words.txt")

```

If we execute this function while the state of our machine is that the file "words.txt" is of
length n, or length m, we know that at different days n may or may not equal m, depending on what
is happening to our filesystem. This introduces nondeterminism, and of course is something that
eliminates the type of equality we had gotten earlier on from analyzing map on that input. Let's
try to see that in action:


```Haskell

x :: Integer
x = if length (getChars "words.txt") == 10 then "MY WORDS ARE 10" else "my words are different"

```

So now we have this Integer x which, by our languages model with this getChars function, is of
type Integer, but in fact it is really a function of the state of the world in which we execute
this code as well, as we know that if I "echo aaaaaaaaaa > words.txt" this would clearly change the
way the code will execute. Hold up, we have this problem which is that this Integer retrieved is
not just an Integer, but an Integer function of the state of the RealWorld! We can just write this
in our language, using primitives offered by GHC, the Haskell compiler which you should be using.

```Haskell

type IO a = State# RealWorld -> (# State# RealWorld, a #-)

```

This means that IO a is literally a function from the state of the real world, to another state
of the real world plus some a which was computed in the process of that change. This is our
model for interactions with the outside world, and we can interact with this model really seamlessly
using certain notions from a body of mathematical knowledge referred to as category theory which
I'll discuss in the next bit.
