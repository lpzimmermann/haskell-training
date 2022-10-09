module BinarySearchTree
( T, empty , insert, fromList
, toList, member, merge
) where

data T a = Leaf | Node (T a) a (T a)
 deriving Show

toList :: T a -> [a]
toList Leaf = []
toList (Node l x r) = toList l ++ [x] ++ toList r

-- >>> toList (Node (Node Leaf 2 Leaf) 6 (Node Leaf 8 Leaf))
-- [2,6,8]

member :: Ord a => a -> T a -> Bool
member x Leaf = False 
member x (Node l y r) = x == y || member x l || member x r

-- >>> member 5 (Node (Node (Node Leaf 9 Leaf) 2 Leaf) 1 Leaf)
-- False

empty :: T a
empty = Leaf

insert :: Ord a => a -> T a -> T a
insert toInsert Leaf = Node Leaf toInsert Leaf
insert toInsert (Node l current r)
    | toInsert == current = Node l current r
    | toInsert < current = Node (insert toInsert l) current r
    | otherwise     = Node l current (insert toInsert r)

-- >>> toList (insert 22 (Node (Node (Node Leaf 4 Leaf) 9 Leaf) 10 Leaf))
-- [4,9,10,22]

fromList :: Ord a => [a] -> T a
fromList [] = Leaf
fromList (x:xs) = insert x (fromList xs)

-- >>> fromList [55,3,6,34,6,11,2]
-- Node Leaf 2 (Node (Node (Node Leaf 3 Leaf) 6 Leaf) 11 (Node Leaf 34 (Node Leaf 55 Leaf)))

merge :: Ord a => T a -> T a -> T a
merge l r = fromList (toList l ++ toList r)

-- >>> toList (merge (Node Leaf 2 (Node (Node (Node Leaf 3 Leaf) 6 Leaf) 11 (Node Leaf 34 (Node Leaf 55 Leaf)))) (Node (Node (Node Leaf 4 Leaf) 9 Leaf) 10 Leaf))
-- [2,3,4,6,9,10,11,34,55]

instance Eq a => Eq (T a) where
    (==) x y = toList x == toList y

-- >>> (Node (Node (Node Leaf 3 Leaf) 9 Leaf) 10 Leaf) == (Node (Node (Node Leaf 4 Leaf) 9 Leaf) 10 Leaf)
-- False

instance Ord a => Semigroup (T a) where
  (<>) x y = merge x y

-- >>> (Node (Node (Node Leaf 3 Leaf) 9 Leaf) 10 Leaf) <> (Node (Node (Node Leaf 4 Leaf) 9 Leaf) 10 Leaf)
-- Node (Node (Node (Node Leaf 3 Leaf) 4 Leaf) 9 Leaf) 10 Leaf
