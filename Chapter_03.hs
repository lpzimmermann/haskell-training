module Chapter_03 where

-- Exercise 3.1
-- What are the types of the following values?

e3_1_1 = ['a','b','c']
e3_1_1 :: [Char]

e3_1_2 = ('a','b','c')
e3_1_2 :: (Char, Char, Char)

e3_1_3 = [(False,'O'),(True,'1')]
e3_1_3 :: [(Bool, Char)]

e3_1_4 = ([False,True],['0','1'])
e3_1_4 :: ([Bool], [Char])

e3_1_5 = [tail, init, reverse]
e3_1_5 ::  [[a] -> [a]]


-- Exercise 3.2
-- Write down definitions that have the following types; it does not matter what the definitions actually do as long as they are type correct. The type of your defined function may be more general than the types defined below.


bools :: [Bool]
bools = [True, False]

nums :: [[ Int ]]
nums = [[1,2], [3,4]]

add :: Num a => a -> a -> a -> a
add a b c = a + b + c

copy :: b -> (b, b)
copy b = (b, b)

apply :: (t1 -> t2) -> t1 -> t2
apply f x = f x


-- Exercise 3.3 (**)
-- What are the types of the following functions?

-- Hint: take care to include the necessary class constraints in the types if the functions are defined using overloaded operators.

second xs = head (tail xs) 
second :: [a] -> a

swap (x,y) = (y,x)
swap :: (a, b) -> (b, a)

pair x y = (x,y)
pair :: x -> y -> (x,y)

double x = x*2
double :: Num x => x -> x

palindrome xs = reverse xs == xs 
palindrome :: [Char] -> Bool

twice f x = f (f x)
twice :: (x -> x) -> x -> x


-- Exercise 3.4 (*)
-- Check your answers to the preceding three questions using GHCi.

-- Copy and paste your ghci sesssion into the block comment below.
{-
    Prelude> double x = x*2
    Prelude> :type double
    double :: Num a => a -> a

    Prelude> palindrome xs = reverse xs == xs
    Prelude> :type palindrome
    palindrome :: Eq a => [a] -> Bool

    Prelude> twice f x = f (f x)
    Prelude> :type twice
    twice :: (t -> t) -> t -> t
-}

-- Exercise 3.5 (**)
-- Why is it not feasible in general for function types to be instances of the Eq class? When is it feasible? Hint: two functions of the same type are equal if they always return equal results for equal arguments.

-- Type your answer into the block comment below.
{-
    you cannot test EVERY input 
-}