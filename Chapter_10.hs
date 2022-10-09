module Chapter_10 where

-- Note: There are no automated tests for the solutions in this chapter since all solutions require console interaction. Although tests involvin IO are possible (see https://stackoverflow.com/questions/7370073/testing-functions-in-haskell-that-do-io ), this has been avoided to keep the solutions simple. Please use ghci to test the solutions yourself before submitting them as follows:

-- > ghci src/Chapter_10.hs
-- [1 of 1] Compiling Chapter_10       ( src/Chapter_10.hs, interpreted )
-- Ok, one module loaded.
-- *Chapter_10> myPutStr "Hello\n"
-- Hello
-- *Chapter_10> adder
-- How many numbers? 5
-- 1
-- 2
-- 3
-- 4
-- 5
-- The total is 15


-- Exercise 10.WarmUp1
-- Define an action strlen :: IO () that prompts the user to enter a string and then displays its length:
-- > strlen
-- Enter a string: Haskell
-- The string has 7 characters

strlen :: IO ()
strlen = undefined 



-- Exercise 10.1 (**)
-- Redefine putStr :: String -> IO () using a list comprehension and the library function sequence_ :: [IO a] -> IO ().

-- putStr :: String -> IO ()
-- putStr []     = return ()
-- putStr (x:xs) = do  putChar x
--                     putStr xs

-- Note: If you are trying this within ghc, please note that putStr is already defined in the Prelude. Use the name myPutStr which is currently undefined instead.

myPutStr :: String -> IO ()
myPutStr = undefined 


-- Exercise 10.4 (**)
-- Define an action adder :: IO () that reads a given number of integers from the keyboard, one per line, and displays their sum. For example:

-- > adder
-- How many numbers? 5
-- 1
-- 3
-- 5
-- 7
-- 9
-- The total is 25

-- Hint: Start by defining an auxiliary function adder' :: Int -> Int -> IO () that takes the current total and how many numbers remain to be read as arguments. Use the library functions read and show to convert between Int and String.

-- >>> :t read
-- read :: Read a => String -> a

-- >>> :t show
-- show :: Show a => a -> String

adder :: IO ()
adder = undefined
adder' :: Int -> Int -> IO ()
adder' = undefined


-- Exercise 10.5 (***)
-- Redefine adder using the function sequence :: [IO a] -> IO [a] that performs a list of actions and returns a list of resulting values.
-- Note: Use the name adderUsingSequence for your solution to avoid a name clash with the previous solution. 

adderUsingSequence :: IO ()
adderUsingSequence = undefined



