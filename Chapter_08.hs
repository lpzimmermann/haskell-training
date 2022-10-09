module Chapter_08 where
import Data.Bits (Bits(xor))


-- Exercise 8.1 (*) 
-- In a similar manner to the function add for the data type Nat below, define a recursive multiplication function mult :: Nat -> Nat -> Nat for the recursive type of natural numbers. 
-- Hint: make use of add in your definition.

data Nat = Zero | Succ Nat 
    deriving (Eq, Show) 

add :: Nat -> Nat -> Nat
add Zero n = n
add (Succ m) n = Succ (add m n)

mult :: Nat -> Nat -> Nat
mult m Zero = Zero
mult m (Succ n) = add m (mult m n)

-- >>> mult (Succ (Succ (Succ Zero))) (Succ (Succ (Succ (Succ Zero))))
-- Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero)))))))))))

-- Exercise 8.5 (**)
-- Given the type declaration for Expr below, define a higher-order function folde such that folde f g replaces each Val 
-- constructor in an expression by the function f, and each Add constructor by the function g.

data Expr = Val Int | Add Expr Expr 
    deriving Show

folde :: (Int -> a) -> (a -> a -> a) -> Expr -> a
folde f g (Val x) = f x
folde f g (Add x y) = g (folde f g x) (folde f g y)

-- >>> folde (\x -> x) (\x y -> x + y) (Add (Val 7) (Val 8))
-- 15

-- Exercise 8.6 (**)
-- Using folde, define a function eval :: Expr -> Int that evaluates an expression to an integer value, 
-- and a function size :: Expr -> Int that calculates the number of values in an expression.

eval :: Expr -> Int
eval x = folde id (+) x

-- >>> eval (Add (Add (Val 5) (Val 6)) (Val 8))
-- 19

size :: Expr -> Int
size = folde (const 1) (+)

-- >>> size (Add (Add (Val 5) (Val 6)) (Add (Val 8) (Val 4)))
-- 4

-- Exercise 8.7 (**)
-- Provide instance definitions to make the Expr and List types an instance of the Eq typeclass.

instance Eq Expr where
    Val a == Add b c = False
    Add a b == Val c = False
    Val a == Val b = a == b
    Add a b == Add c d = a == c && b == d

--- Should be False
-- >>> (Add (Add (Val 5) (Val 6)) (Val 8)) == (Add (Add (Val 4) (Val 6)) (Val 8))
-- False

-- >>> Add (Val 1) (Val 3) == Add (Val 2) (Val 2)
-- False

--- Should be True
-- >>> (Add (Add (Val 5) (Val 6)) (Val 8)) == (Add (Add (Val 5) (Val 6)) (Val 8))
-- True

-- >>> Add (Val 5) (Val 5) == Val 10
-- False

-- >>> Val 10 == Val 10
-- True

-- >>> Val 10 == Add (Val 5) (Val 5)
-- False

data List a = Nil | Cons a (List a)
    deriving Show

instance Eq a => Eq (List a) where
    (==) Nil Nil = True
    (==) (Cons x xs) (Cons y ys) = x == y && xs == ys
    (==) _ _ = False  
    
-- >>> Cons 5 (Cons 3 (Cons 3 Nil)) == Cons 5 (Cons 3 (Cons 4 Nil)) 
-- False
