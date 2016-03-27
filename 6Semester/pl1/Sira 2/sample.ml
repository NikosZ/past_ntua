let h nill _ = 0;;
let h (a::b) n= match n with
| 0 |2 ->h b (n+1) +if a ='b' then  1 else 0 
| 1 |4 ->h b (n+1) +if a ='g' then  1 else 0 
| 7 |10 ->h b (n+1) +if a ='r' then  1 else 0 
| 9 |11 ->h b (n+1) +if a ='r' then  1 else 0 
| 12 -> 0;;
let swap (a::b)
let rec move1 (a0::a1::a2::a3::a4::a5::a6::a7::a8::a9::a10::a11::c) = (a2::a1::a5::a0::a4::a3::a6::a7::a8::a9::a10::a11::c)
let rec move2 (a0::a1::a2::a3::a4::a5::a6::a7::a8::a9::a10::a11::c) = (a0::a3::a2::a6::a1::a5::a4::a7::a8::a9::a10::a11::c)
let rec move3 (a0::a1::a2::a3::a4::a5::a6::a7::a8::a9::a10::a11::c) = (a0::a1::a2::a3::a4::a7::a6::a10::a5::a9::a8::a11::c)
let rec move4 (a0::a1::a2::a3::a4::a5::a6::a7::a8::a9::a10::a11::c) = (a0::a1::a2::a3::a4::a5::a8::a7::a11::a6::a10::a9::c)
let rec second (_,b) =b;;
let rec first (a,_) = a;;
(*let myorder a b = second a + h (first a) 0 < second b + h (fist b) 0;;
*)
let rec final (a0::a1::a2::a3::a4::a5::a6::a7::a8::a9::a10::a11::c) = if (a0 == '') then true else false;;
let rec push Q v = match v with
| [] -> ()
| (a::b) -> (Queue.add Q a); push Q b;;
let rec bfs Q = let val el = Queue.take Q in
        if not final el then push Q (moves el) else el ;;
