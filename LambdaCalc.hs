module LambdaCalc (reduce) where

type Id = String

data Term = Var Id   -- Variables / Var
    | Abs Id Term    -- Abstractions / Lambda
    | App Term Term  -- Applications
    deriving Show

removeFromList :: Eq a => a -> [a] -> [a]
removeFromList x [] = []
removeFromList x (y:ys) | x == y = removeFromList x ys
    | otherwise = [y] ++ removeFromList x ys

freeVars :: Term -> [Id]
freeVars (Var id) = [id]
freeVars (Abs id term) = removeFromList id (freeVars term)
freeVars (App term1 term2) = freeVars term1 ++ freeVars term2

allVars :: Term -> [Id]
allVars (Var id) = [id]
allVars (Abs id term) = [id] ++ (allVars term)
allVars (App term1 term2) = allVars term1 ++ allVars term2

findInList :: Id -> [Id] -> Bool
findInList _ [] = False
findInList x (y:ys) = x == y || findInList x ys

isFreeIn :: Id -> Term -> Bool
isFreeIn x term = findInList x (freeVars term)

-- fn to do alpha renaming 
renameVar :: Term -> Id -> Id -> Term
renameVar (Var x) oldId newId | x == oldId = Var newId
                                    | otherwise = Var x
renameVar (App term1 term2) oldId newId = App (renameVar term1 oldId newId) (renameVar term2 oldId newId)
renameVar (Abs x term) oldId newId | x == oldId = Abs newId (renameVar term oldId newId)
                                   | otherwise = Abs x (renameVar term oldId newId)

-- Probably
substitute :: (Id, Term) -> Term -> Term
substitute (x, tx) (Var y) | y == x = tx
    | otherwise = Var y
substitute (x, tx) (Abs id term) = Abs id (substitute (x, tx) term)
substitute (x, tx) (App term1 term2) = App (substitute (x, tx) term1) (substitute (x, tx) term2)

-- Not so sure about that (not in scope for minimal solution)
isBetaRedex :: Term -> Bool
isBetaRedex (App _ _) = False
isBetaRedex (Var _) = False
isBetaRedex (Abs id term) = True

betaReduce :: Term -> Id -> Term
betaReduce (App a b) _ = App a b
betaReduce (Var x) _ = Var x
betaReduce (Abs id term) beta | isBetaRedex term = substitute (id, Var beta) term
                              | otherwise = Abs id term
fixSubstituteTerm :: Term -> Term -> Term
fixSubstituteTerm mainTerm (Var x) | x `isFreeIn` mainTerm = Var (x ++ "1")
                                | otherwise = Var x
fixSubstituteTerm mainTerm (App term1 term2) = App (fixSubstituteTerm mainTerm term1) (fixSubstituteTerm mainTerm term2)
fixSubstituteTerm mainTerm (Abs x term) | x `isFreeIn` mainTerm = Abs (x ++ "1") (fixSubstituteTerm mainTerm term)         
                                        | otherwise = Abs x (fixSubstituteTerm mainTerm term) 

apply :: Term -> Term -> Term
apply (Abs id term1) term2 = reduce $ substitute (id, term2) (fixSubstituteTerm term2 term1)
apply term1 term2 = App term1 term2

reduce :: Term -> Term
reduce (Var id)       = Var id
reduce (Abs id term)  = Abs id (reduce term)
reduce (App term1 term2) = apply (reduce term1) (reduce term2)

instance Eq Term where
    (Var x) == (Var y)                      = x == y
    (App term1 term2) == (App term3 term4)  = term1 == term3 && term2 == term4
    (Abs x term1) == (Abs y term2)
        | x == y                            = term1 == term2
        | otherwise                         = substitute (x, (Var z)) term1 == substitute (y,(Var z)) term2
        where z = "z"
    _ == _                                  = False

--leftmostOutermost :: Term -> Term
--derivation :: (Term -> Term) -> Term -> [Term]

-- `(%x.x) a` reduces to `a`
-- >>> reduce (App (Abs "x" (Var "x")) (Var "a")) == (Var "a")
-- True

-- `(%x.x x) (%x.x)` reduces to `%x.x`
-- >>> reduce (App (Abs "x" (App (Var "x") (Var "x"))) (Abs "x" (Var "x"))) == (Abs "x" (Var "x")) 
-- True

-- `(%x.%y.x y) y` reduces to `%y1.y y1`, and not `%y.y y`
-- >>> reduce (App (Abs "x" (Abs "y" (App (Var "x") (Var "y")))) (Var "y")) == (Abs "y1" (App (Var "y") (Var "y1")))
-- True