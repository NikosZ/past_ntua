fun altSum ls = (List.foldr (fn (x,y) => (~1)*y +x ) 0 ls);;

 
fun inc1Seqs ls = 
let fun inc1 [] acc =List.rev acc
        | inc1 (h::hs) [] = inc1 hs [h::[]] (* need to reserver each inside list *)
        | inc1 (h::ls)  (h1::acc)= if (h-1 = List.hd(h1)) then inc1 ls (( h::h1
        )::acc) else inc1 ls ([h]::(h1::acc)) 
in
        inc1 ls [] 
end;;
