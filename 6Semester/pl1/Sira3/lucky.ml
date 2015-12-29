type mem = Nil | M of int* float list*mem;;

let rec digitalize n acc = match n with
| 0 ->acc
| _ -> digitalize (n/10) ((n mod 10)::acc);;

let rec scanl f init ls acc = match ls with
| [] ->List.rev acc
| (x::xs) -> scanl f ( f init x) xs ((f init x) :: acc);;


let docalc b a = ((a+.b)::(a-.b):: (a*.b)::(a/.b)::[] );;
let con n m = n*.10.0 +. m ;;
let rec  np x y = List.flatten (List.map (fun k-> docalc k x) y);;
let rec exists n k = match k with
        | Nil -> false
        | M ( a ,b ,c) -> if (n =a) then true else exists n c;;
let rec find n (M (a, b, c)) = match n with
|0->[]
| _ -> if n =a then b else find n c;;
let rec take n p = match n,p  with
| 0 , _-> []
| _ , [] -> []
| _ , (x::xs)-> x :: take (n-1) xs ;;
(*let rec solve digits n pak = match pak with
| Nil->  solve digits (n+1) (M (0 ,[(List.hd digits)] ,Nil))
| (M (a ,b ,c)) ->
                if (n= (List.length digits)) then find (n-1) (M (a, b, c)) else (
         if (exists n (M (a ,b ,c))) then find n (M (a ,b ,c)) else 
                let rec newL t = match t with
                | Nil -> let newLe =  List.concat( List.mapi (fun y-> fun x-> List.map (docalc x) (solve digits (n-y) (M (a ,b ,c)))) ( scanl con 0.0 (List.rev (take n digits)) [] ))
                        in (M (n, List.concat newLe, Nil))
                | M (a1,b1,c1) -> (M (a1, b1, (newL c1)))
                in
                solve digits (n+1) (newL  (M (a ,b ,c))) );;
*)
let rec make_the_list n k num acc = match k with
| [] -> List.rev acc
| (x::xs) -> let newnum = con num x
                in 
                make_the_list (n-1) xs newnum  ((n,newnum)::acc);;



let rec solve digits n pak stop= match pak with
|Nil-> solve digits (n+1) (M (1,[(List.hd digits)],Nil)) stop
| (M (a,b,c ))  -> if (n=stop) then find (n-1) (M (a,b,c)) else (if (exists n (M (a,b,c))) then find n (M (a,b,c)) else (
        let rec newL t = match t with 
        | Nil-> (let newLe = make_the_list (n-1) (List.rev (take (n) digits)) 0.0 [] in
        let v= List.concat( List.map (fun (x,y) -> (List.map (docalc y)  (find x (M (a,b,c)) ) )) newLe )
        in 
        (M (n,List.concat v,Nil)) )
        | M (a1,b1,c1) -> (M (a1,b1 , (newL c1))) 
        in 
        solve digits (n+1) (newL (M (a,b,c))) stop
));;
let dig n = List.map (float_of_int) (digitalize n []);;
let is_lucky ls =
         List.exists (fun x-> x=100.0) (solve ls 1 Nil ((List.length ls))) ;;
let main= for i =1 to Array.length Sys.argv -1 do
        if (is_lucky (dig (int_of_string Sys.argv.(i)))) then Printf.printf("true ")
        else Printf.printf("false ")
done;;
        let _ = Printf.printf("\n")
