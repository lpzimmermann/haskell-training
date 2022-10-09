module Chapter_01 where

-- Exercise 1.1 (*)
-- Give another possible calculation for the result of double (double 2).

-- Complete the following block comment.
{-
    double (double 2)

    (double 2) + (double 2)
    (2 + 2) + (double 2)
    4 + (double 2)
    4 + 4
    8
-}


-- Exercise 1.2 (*)
-- Show that sum [x] = x for any number x.

-- Complete the following block comment.
{-
    sum [1,2,3,4]
    1 + (sum [2,3,4])
    1 + (2 + (sum [3,4]))
    1 + (2 + (3 + (sum [4])))
    1 + (2 + (3 + (4 + (sum []))))
    1 + (2 + (3 + (4 + 0))))
    1 + (2 + (3 + 4)))
    1 + (2 + 7)
    1 + 9
    10
-}


-- Exercise 1.3 (*)
-- Define a function myProduct that produces the product of a list of numbers, and show using your definition that myProduct [2,3,4] == 24.
-- Note: We use the name "myProduct" since the name product is already defined in the ghc Prelude.


--myProduct xs = if length xs == 1 then head xs else head xs * myProduct (tail xs)

--myProduct [2,3,4]

{-
Prelude> myProduct [] = 1; myProduct (n:ns) = n * myProduct ns;
Prelude> myProduct [1,2,3,4]
24
-}



