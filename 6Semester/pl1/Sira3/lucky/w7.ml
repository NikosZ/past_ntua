type mem = Nil | M of int*float list*mem;;

let rec digitalize n acc = match n with
| 0 ->acc
| _ -> digitalize (n/10) ((n mod 10)::acc);;
let rec chop k l =
          if k = 0 then l else begin
                      match l with
                          | x::t -> chop (k-1) t
                              | _ -> assert false
                                end
;;

let rec scanl f init ls acc = match ls with
| [] ->List.rev acc
| (x::xs) -> scanl f ( f init x) xs ((f init x) :: acc);;
let sort_uniq cmp l =
  let rec rev_merge l1 l2 accu =
    match l1, l2 with
    | [], l2 -> List.rev_append l2 accu
    | l1, [] -> List.rev_append l1 accu
    | h1::t1, h2::t2 ->
        let c = cmp h1 h2 in
        if c = 0 then rev_merge t1 t2 (h1::accu)
        else if c < 0
        then rev_merge t1 l2 (h1::accu)
        else rev_merge l1 t2 (h2::accu)
  in
  let rec rev_merge_rev l1 l2 accu =
    match l1, l2 with
    | [], l2 -> List.rev_append l2 accu
    | l1, [] -> List.rev_append l1 accu
    | h1::t1, h2::t2 ->
        let c = cmp h1 h2 in
        if c = 0 then rev_merge_rev t1 t2 (h1::accu)
        else if c > 0
        then rev_merge_rev t1 l2 (h1::accu)
        else rev_merge_rev l1 t2 (h2::accu)
  in
  let rec sort n l =
    match n, l with
    | 2, x1 :: x2 :: _ ->
       let c = cmp x1 x2 in
       if c = 0 then [x1]
       else if c < 0 then [x1; x2] else [x2; x1]
    | 3, x1 :: x2 :: x3 :: _ ->
       let c = cmp x1 x2 in
       if c = 0 then begin
         let c = cmp x2 x3 in
         if c = 0 then [x2]
         else if c < 0 then [x2; x3] else [x3; x2]
       end else if c < 0 then begin
         let c = cmp x2 x3 in
         if c = 0 then [x1; x2]
         else if c < 0 then [x1; x2; x3]
         else let c = cmp x1 x3 in
         if c = 0 then [x1; x2]
         else if c < 0 then [x1; x3; x2]
         else [x3; x1; x2]
       end else begin
         let c = cmp x1 x3 in
         if c = 0 then [x2; x1]
         else if c < 0 then [x2; x1; x3]
         else let c = cmp x2 x3 in
         if c = 0 then [x2; x1]
         else if c < 0 then [x2; x3; x1]
         else [x3; x2; x1]
       end
    | n, l ->
       let n1 = n asr 1 in
       let n2 = n - n1 in
       let l2 = chop n1 l in
       let s1 = rev_sort n1 l in
       let s2 = rev_sort n2 l2 in
       rev_merge_rev s1 s2 []
  and rev_sort n l =
    match n, l with
    | 2, x1 :: x2 :: _ ->
       let c = cmp x1 x2 in
       if c = 0 then [x1]
       else if c > 0 then [x1; x2] else [x2; x1]
    | 3, x1 :: x2 :: x3 :: _ ->
       let c = cmp x1 x2 in
       if c = 0 then begin
         let c = cmp x2 x3 in
         if c = 0 then [x2]
         else if c > 0 then [x2; x3] else [x3; x2]
       end else if c > 0 then begin
         let c = cmp x2 x3 in
         if c = 0 then [x1; x2]
         else if c > 0 then [x1; x2; x3]
         else let c = cmp x1 x3 in
         if c = 0 then [x1; x2]
         else if c > 0 then [x1; x3; x2]
         else [x3; x1; x2]
       end else begin
         let c = cmp x1 x3 in
         if c = 0 then [x2; x1]
         else if c > 0 then [x2; x1; x3]
         else let c = cmp x2 x3 in
         if c = 0 then [x2; x1]
         else if c > 0 then [x2; x3; x1]
         else [x3; x2; x1]
       end
    | n, l ->
       let n1 = n asr 1 in
       let n2 = n - n1 in
       let l2 = chop n1 l in
       let s1 = sort n1 l in
       let s2 = sort n2 l2 in
       rev_merge s1 s2 []
  in
  let len = List.length l in
  if len < 2 then l else sort len l
;;

let rec flatten ls =
        let rec flatten2 ls acc = match ls with
        | [] ->acc
        | (x::xs)-> flatten2 xs (List.rev_append x acc)
        in 
        flatten2 ls [];;

let docalc a b = match b with
| 0.0->  (fun x->(a+.b)::(a-.b):: (a*.b)::x )
| _ -> (fun x->(a+.b)::(a-.b):: (a*.b)::(a/.b)::x );;
let con n m = n*.10.0 +. m ;;
(*let rec  np x y = flatten (List.map (fun k-> docalc k x) y);;*)

let rec listmonad ls xs =  let rec listmonad2 ls1 xs1 acc = match ls1,xs1 with
| [],_ -> acc
| x::xs3,[] -> listmonad2 xs3 xs acc
| y::ys,p::ps -> listmonad2 (y::ys) ps ((y p) acc)
in
listmonad2 ls xs [];;

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
(*
let rec mymap ls x = let rec mymap2 ls x acc= match ls with 
| [] ->acc
| y::ys -> mymap2 ys x (acc (y x) )
in
mymap2 ls x  (fun t->t);;*)
let f (x: float list ->float list) = x;;
(*let rec myfold ls (x:float) = let rec myfold2 (ls1:(float-> (float list->float list)) list) x (acc:float list->float list) = match ls1 with
| [] -> (acc:float list->float list)
| [y] ->  acc (y x)
| y::ys -> myfold2 ys x (acc  (y x))
in 
myfold2 ls x f ;;*)
(*
let rec myfold2 (ls: (float-> float list->float list)list) x = List.fold_left (fun a->fun b -> (a (b x)) ) f ls :float list->float list ;;
*)
let rec kf l acc= match l with
|[]-> acc
|[x]-> (x::acc)
|x::b::xs -> if(x=b) then kf (b::xs) acc else kf (b::xs) (x::acc);;
let reva x y = y x;;
let rec list2c x l acc = let k =  (List.rev_map (docalc)  x) in
 listmonad k l;;
(* List.fold_left (fun a->fun b-> b a)  [] ( List.fold_left (fun a->fun b -> b a) [] (List.rev_map (myfold k) l ) ) ;;
let rec list2c3 x l acc= match x with
| [] ->List.fold_left (fun x-> fun y-> y x) [] acc
| k::ks ->list2c3 ks l ((List.fold_left (fun x->fun y-> x y) (docalc2 k)  l)::acc);;*)
(*
let rec list2c x l acc= List.fold_left (fun x->fun y-> List.rev_append (flatten (List.rev_map (docalc y) l )) x) [] x;;*)

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
| true -> a :: range2 (a-1) b 
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
| _ ->((number12 start finish digits) ::(sort_uniq sf @@ flatten  (List.rev_map (fun x->(list2c (solve digits start (start + x) memo) (solve digits (start+ x+1) finish memo) [] )) (range 0 (finish-start-1) )) ));;
(*let rec solve digits start finish memo= match memo with 
| Nil -> solve digits start finish (M (1,Nil,[List.hd digits],Nil))
| _ -> if (start = finish) then find 1 (start-1) memo else
        ( let rec solve2 digits start2 finish2 mem2= match mem2 with 
        |Nil -> 
        |(M (a,b,c,d) -> if (a =start2) then M (a,(solve2 digits start2 finish2 b),c,d) else 
                M(a,b,c,d)

);; 
*)
let rec find7 ls = match ls with
| [] -> ()
| (x::xs) -> if (x=100.) then raise Not_found else find7 xs;;
let rec solve3 digits start finish memo= match (start=finish) with
| true ->false(*na to dw*)
| _ -> try let _= (for i=0 to (finish-start-1) do
        ((find7((number12 start finish digits)::(list2c (solve digits start (start + i) memo) (solve digits (start+ i+1) finish memo) [] )))) done) 
in
                false with Not_found-> true;;

let rec solve1 digits start finish=
let memo = Hashtbl.create 121
in let k =solve3 digits start finish memo in
let _ =Hashtbl.reset memo in
k
;;

(* End of solving phase  *)

let sec (x,y) =y;;
let dig n = List.map (float_of_int) (digitalize n []);;
let is_lucky ls = match ls with
| [] ->false
| _->      (*  let _ =Hashtbl.add memo (hash 1 1) [(List.nth ls 0)] in *)
         solve1 ls 1  ((List.length ls) )
     (*   let _ = List.iter (Printf.printf("%f ")) k in
List.exists (fun x-> (x=100.)  ) k *);;
let main= for i =1 to Array.length Sys.argv -1 do
        if (not (is_lucky (dig (int_of_string Sys.argv.(i))))) then Printf.printf("true ")
        else Printf.printf("false ")
done;;
        let _ = Printf.printf("\n")
