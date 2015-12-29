open Array;
fun diva n = if n%2 = 1 then (n div 2) +1 else n div 2;
fun sumi ls n = ls ! n + sim ls (n-1)
fun loop f n n = ()
  | loop f n k = f k ; loop f n (k+1)
fun upd ls1 ls2 arr k= update(arr , k , cv ls1 ls2 k);
fun create l1 l2  =let val a = array(730,0) ; let fun k =upd l1 l2 a
in loop k 730 0;
a 
end;
fun cv ls1 ls2 ~1 =0
  | cv ls1 ls2 n = co ls1 ls2 n 0
fun co ls1 ls2 k (k+1) =0
  | co ls1 ls2 n k = (ls1 ! k) * (ls2 ! (n-k)) + co ls1 ls2 n (k+1) ;
fun no_fft ls1 ls2 res = 
fun funky 1 ls = ls
  | funky n ls = create (funky (diva n) ls) (funky n/2 ls)
fun ishappy arr n = if arr !n =1 then True else False;
fun ishappy2 arr 1 = True
  | ishappy2 arr n =if arr ! i = 0 then update(arr,i,(ishappy2 arr (sqr i)))
                    else if arr ! =
