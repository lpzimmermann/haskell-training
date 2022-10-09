module Chapter_07 where

-- Exercise 7.1 (*)
-- Show how the list comprehension [f x | x <- xs, p x] can be re-expressed using the higher-order functions map and filter.

e_7_1 :: (a -> b) -> (a -> Bool) -> [a] -> [b]
e_7_1 f p xs = map f (filter p xs)


-- Exercise 7.2 (**)
-- Without looking at the definitions from the standard prelude, define the following higher-order library functions on lists. Try to use the higher-order functions and, or, (.), foldr and map within your definitions if possible.
-- Note: in the prelude the first two of these functions are generic functions rather than being specific to the type of lists.
-- Note: If you are trying this within ghc, please note that these functions are already defined in the Prelude. Use fresh function names by prefixing each name with a "my" and changing the resulting name into camelcase, for example "all" becomes "myAll". 

-- (a) Decide if all elements of a list satisfy a predicate:
--     all :: (a -> Bool) -> [a] -> Bool

myAll :: (a -> Bool) -> [a] -> Bool
myAll p xs = foldr (&&) True (map p xs)



-- (b) Decide if any element of a list satisfies a predicate:
--     any :: (a -> Bool) -> [a] -> Bool

myAny :: (a -> Bool) -> [a] -> Bool
myAny p xs = foldr (||) False (map p xs)


-- (c) Select elements from a list while they satisfy a predicate:
--     takeWhile :: (a -> Bool) -> [a] -> [a]

myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile p (x:xs) | p x = x : (myTakeWhile p xs)
                    | otherwise = [] 


-- (d) Remove elements from a list while they satisfy a predicate:
--     dropWhile :: (a -> Bool) -> [a] -> [a]

myDropWhile :: (a -> Bool) -> [a] -> [a]
myDropWhile _ [] = []
myDropWhile p (x:xs) | p x = myDropWhile p xs
                    | otherwise = x : xs


-- Exercise 7.3 (**)
-- Redefine the functions map and filter using foldr.

myMap :: (a -> b) -> [a] -> [b]
myMap p = foldr (\x xs -> (p x) : xs) []

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter p = foldr (\ x xs -> if p x then x : xs else xs ) []

--- >>> myFilter (\x -> x > 3) [1,2,3,4,5,6]
-- [4,5,6]
---

-- Exercise 7.5 (**)
-- Without looking at the definitions from the standard prelude, define the higher-order library function curry that converts a function on pairs into a curried function, and, conversely, the function uncurry that converts a curried function with two arguments into a function on pairs.
-- Hint: first write down the types of the two functions.

myCurry :: ((a, b) -> t) -> a -> b -> t
myCurry f = \a b -> f (a,b)

myUncurry :: (t1 -> t2 -> t3) -> (t1, t2) -> t3
myUncurry f = \(a,b) -> f a b

