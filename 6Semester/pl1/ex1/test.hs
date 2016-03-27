
sumsqr 0 = 0
sumsqr n = (n `mod` 10) *(n `mod`10) + sumsqr n/10

ishappy n ls = n !! ls
ishappy2 :: [a]->a->bool
ishappy2 ls n | elem n ls =False
			  | n==1 =True
			  | otherwise = ishappy2 (ls:n) (sumsqr n)
happy= ishappy2 []
make_ls = filter (happy) [1..900]
find_happy a b ls | if a<=b && a`mod`10==0 =
check a b res ls | a>b = res
		         | a `mod` 10==0 = 
