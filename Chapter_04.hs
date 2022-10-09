module Chapter_04 where


-- Exercise 4.3 (**)
-- Consider a function safeTail :: [a] -> [a] that behaves in the same way as tail except that it maps the empty list to itself rather than producing an error. Using tail and the function null :: [a] -> Bool that decides if a list is empty or not, define safetail using:
-- (a) a conditional expression; 
-- (b) guarded equations;
-- (c) pattern matching.

safeTailA :: [a] -> [a]
-- safeTailA xs = if ??? then ??? else ???
safeTailA xs = if (length xs) == 0 then xs else (tail xs)

safeTailB :: [a] -> [a]
safeTailB xs | (length xs) == 0 = xs
            | otherwise = tail xs

safeTailC :: [a] -> [a]
safeTailC (_:xs) = xs
safeTailC [] = [] 

-- Exercise 4.7 (**)
-- Show how the meaning of the following curried function definition can be formalised in terms of lambda expressions:
-- mult :: Int -> Int -> Int -> Int 
-- mult x y z = x*y*z

mult :: Int -> (Int -> (Int -> Int)) 
mult = \x -> (\y -> (\z -> x * y * z))


