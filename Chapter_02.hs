module Chapter_02 where


-- Exercise 2.1 (*)
-- Work through the examples of chapter ”First Steps” using GHCi.

-- Copy and paste your ghci sesssion into the block comment below.

-- Exercise 2.2 (*)
-- Parenthesise the following numeric expressions:
-- 2^3*4 2*3+4*5 2+3*4^5

e_2_2_a :: Int
e_2_2_a = 2^3*4

e_2_2_b :: Int
e_2_2_b = 2*3+4*5

e_2_2_c :: Int
e_2_2_c = 2+3*4^5

{-
Prelude> 2^3*4
32
Prelude> (2^3)*4


Prelude> 2*3+4*5
26
Prelude> (2*3)+(4*5)
26


Prelude> 2+3*4^5
3074
Prelude> 2+(3*(4^5))
3074
-}

-- Excercise 2.3

{-
N = a ‘div‘ length xs
    where
        a = 10
        xs = [1 ,2 ,3 ,4 ,5]
-}


-- Excercise 2.4
{-
Prelude|   findLast xs =
Prelude|     if length xs == 1 then head xs
Prelude|     else findLast (tail xs)
Prelude|   findLast [1,2,3,4]
-}