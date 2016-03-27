type mem = Nil | M of int*float list*mem;;

let rec digitalize n acc = match n with
| 0 ->acc
| _ -> digitalize (n/10) ((n mod 10)::acc);;

let rec scanl f init ls acc = match ls with
| [] ->List.rev acc
| (x::xs) -> scanl f ( f init x) xs ((f init x) :: acc);;


let rec flatten ls =
        let rec flatten2 ls acc = match ls with
        | [] ->acc
        | (x::xs)-> flatten2 xs (List.rev_append x acc)
        in 
        flatten2 ls [];;

let docalc a b = match b with
| 0.0->  ((a+.b)::(a-.b):: (a*.b)::[] )
| _ -> ((a+.b)::(a-.b):: (a*.b)::(a/.b)::[] );;
let con n m = n*.10.0 +. m ;;
let rec  np x y = flatten (List.map (fun k-> docalc k x) y);;
let rec exists n k = match k with
        | Nil -> false
        | M ( a ,b ,c) -> if (n =a) then true else exists n c;;
let rec find n (M (a, b, c)) = match n with
|0->[0.0]
| _ -> if n =a then b else find n c;;
let rec take n p = match n,p  with
| 0 , _-> []
| _ , [] -> []
| _ , (x::xs)-> x :: take (n-1) xs ;;
let rec make_the_list n k num acc = match k with
| [] -> acc
| (x::xs) -> let newnum = con num x
                in 
                make_the_list (n-1) xs newnum  ((n,newnum)::acc);;

let rec kf l acc= match l with
|[]-> acc
|[x]-> (x::acc)
|x::b::xs -> if(x=b) then kf (b::xs) acc else kf (b::xs) (x::acc);;


let rec list2c x l acc= match x with
| [] ->flatten acc
| k::ks ->list2c ks l (flatten (List.rev_map (docalc k) l)::acc);;

let rec fromto n y lista res = 
        let rec drop k l = match k with
        |0-> l
        |_ -> drop (k-1) (List.tl l)
        in
        take (y-n+1) (drop (n-1) lista);;

let  number12 n y digits = let dig = fromto n y digits [] in
List.fold_left (con) 0. dig;;
let rec range a b = match a<b with
| true -> a :: range (a+1) b 
| false -> [b];;
let rec range2 a b = match a>b with
| true -> a :: range (a-1) b 
| false -> [b];;
(* Start of solving phase  *)

let sf x y = if ((x-.y ) >0.0) then 1 else (if (x-.y )=0.0 then 0 else ((~-)1));;
let hash x y = 11*x+y;;
let rec solve digits start finish memo = match Hashtbl.mem memo (hash start finish) with
|true -> Hashtbl.find memo (hash start finish)
| _ -> (let result = solve2 digits start finish memo in
let _= Hashtbl.add memo (hash start finish) result in
result)
and solve2 digits start finish memo= match (start=finish) with
| true ->let k= (List.nth digits (start-1)) in [k] (*na to dw*)
| _ ->((number12 start finish digits) ::(kf ( List.fast_sort sf @@ flatten  (List.rev_map (fun x->(list2c (solve digits start (start + x) memo) (solve digits (start+ x+1) finish memo) [] )) (range 0 (finish-start-1))) )[])) 
;;
(*let rec solve digits start finish memo= match memo with 
| Nil -> solve digits start finish (M (1,Nil,[List.hd digits],Nil))
| _ -> if (start = finish) then find 1 (start-1) memo else
        ( let rec solve2 digits start2 finish2 mem2= match mem2 with 
        |Nil -> 
        |(M (a,b,c,d) -> if (a =start2) then M (a,(solve2 digits start2 finish2 b),c,d) else 
                M(a,b,c,d)

);; 
*)
let rec solve1 digits start finish=
let memo = Hashtbl.create 121
in solve digits start finish memo;;

(* End of solving phase  *)

let sec (x,y) =y;;
let dig n = List.map (float_of_int) (digitalize n []);;
let is_lucky ls = match ls with
| [] ->false
| _->      (*  let _ =Hashtbl.add memo (hash 1 1) [(List.nth ls 0)] in *)
        let k = solve1 ls 1  ((List.length ls) ) in
     (*   let _ = List.iter (Printf.printf("%f ")) k in*)
         List.exists (fun x-> x=100.) k ;;
let main= for i =1 to Array.length Sys.argv -1 do
        if (not (is_lucky (dig (int_of_string Sys.argv.(i))))) then Printf.printf("true ")
        else Printf.printf("false ")
done;;
        let _ = Printf.printf("\n")
        
