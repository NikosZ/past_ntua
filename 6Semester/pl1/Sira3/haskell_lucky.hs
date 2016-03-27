import Control.Applicative

data Ls = Nil | Member Int [Double] Ls

calcs x= [(+) x, (-) x , (*) x ,(/) x]
--digit :: Int->[Double]
--digit n |  n==0 = []
  --      |otherwise = ((n `mod`10): (digit (n `div`10)))
con n m = n*10.0 + m 
exists n Nil = False
exists n (Member k _  next) | n==k = True
                        |otherwise = exists n next
find n (Member k a  next) | n==k = a
                        |otherwise = find n next
solution digits n lista@(Member o1 o2 o3) | n==0 = solution digits (n+1) (Member 0 [digits !! 0] Nil)
                        | exists n (Member o1 o2 o3) = find n lista
                        | n==(length(digits)) = find (n-1) lista
                        | otherwise = solution digits (n+1) (newL (n) lista)  
                        where newL k (Member p ls next)  = (Member p ls (newL k next)) 
                              newL k Nil  = (Member k (((calcs  (digits !! n)) <*> (find (n-1)  lista)) ++ ( concat $ zipWith (<*>) (map calcs (scanl con ( digits!! n) (take (n-1) digits) ) ) (map (\x-> solution digits x (Member o1 o2 o3))  [(n-1)..0]  )   )  ) Nil)

