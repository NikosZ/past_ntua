module SS =Set.Make(String);;
let char_str clist= String.concat "" (List.map (Printf.sprintf "%c") clist);;
let rec move1 (a0::a1::a2::a3::a4::a5::a6::a7::a8::a9::a10::a11::c) = (a2::a1::a5::a0::a4::a3::a6::a7::a8::a9::a10::a11::c);;
let rec move2 (a0::a1::a2::a3::a4::a5::a6::a7::a8::a9::a10::a11::c) = (a0::a3::a2::a6::a1::a5::a4::a7::a8::a9::a10::a11::c);;

let rec move3 (a0::a1::a2::a3::a4::a5::a6::a7::a8::a9::a10::a11::c) = (a0::a1::a2::a3::a4::a7::a6::a10::a5::a9::a8::a11::c);;
let rec move4 (a0::a1::a2::a3::a4::a5::a6::a7::a8::a9::a10::a11::c) = (a0::a1::a2::a3::a4::a5::a8::a7::a11::a6::a10::a9::c);;
let rec second (_,b) =b;;
let rec first (a,_) = a;;
(*let myorder a b = second a + h (first a) 0 < second b + h (fist b) 0;;
*)
let rec hashit ls res= match ls with
| [] -> res
| (a::b) -> hashit b (res*5 + a);;
let rec str s n res= match n with
|12-> List.rev res
|_-> str s (n+1) ((String.get s n)::res) ;;
let  translate a = match a with
|'r'-> 1
| 'b'->4
|'G'->2
| 'g'->3
| 'y' -> 0 ;;
(*let rec char_int ls res = match ls with
|[] -> List.rev res
|(a::b) -> char_int b ((translate a)::res) ;;
*)
let finaly = List.map translate  (str "bgbGgGGrGyry" 0 []);;
let rec hasi hash v= Hashtbl.add hash (char_str (first v)) (second v);;
let  moves v =let k = hashit v 0 in
         (((move1 v), hashit (move1 v) 0),(k,1)):: (((move2 v) ,hashit (move2 v) 0),(k,2))::(((move3 v),(hashit (move3 v) 0)) ,(k,3)) :: ((move4 v,hashit (move4 v) 0),(k,4))::[];;
(*let rec final (a0::a1::a2::a3::a4::a5::a6::a7::a8::a9::a10::a11::c) = if (a0 == '') then true else false;;
*)

let rec fi v vi = match v with
| [] -> true;
| (a::b)-> if a=(List.hd vi) then (fi b (List.tl vi)) else false;;
let rec final v = fi v finaly;;
let rec push v qu= match v with
| [] -> ()
| _ ->  let _ =Queue.add  (first (first (List.hd v))) qu in push (List.tl v) qu;;
let gethash x =second (first x) ;;
let rec  bfs q1 hash1  = 
        let a =  Queue.pop q1  in
        if final a  then (hashit a 0)
        else
                let b = List.filter (fun x-> not (Hashtbl.mem hash1 (gethash x))) (moves a) in
                let _ =List.iter (fun x-> Hashtbl.add hash1 (gethash x) (second x)) b in
                let _ = push b q1 in
                bfs q1 hash1  
;;
                             
let rec res1 v hash result = match v with
| -1 -> List.tl result
| _ -> let x = Hashtbl.find hash v in res1 (first x) hash ((second x)::result) ;;

let rec res v res2 k hash= match k with
| 0 -> res2
| _ ->
        (if Hashtbl.mem hash v then 
                let e = Hashtbl.find hash v in
                res (first e) ((second e) :: res2) k hash
        else
                res v res2 0 hash) ;;
let rec solve s q1 q2= 
        let _ =Queue.add ( List.map translate (str s 0 [])) q1
        and _ = Queue.add finaly q2
        and hash1 = Hashtbl.create 1000 and
         hash2 = Hashtbl.create 1000 in
        let _ = Hashtbl.add hash1 (hashit (Queue.peek q1) 0) (-1,0)
        and _ = Hashtbl.add hash2 (hashit (Queue.peek q2) 0) (-1,0)in
        let k=   bfs q1 hash1  in
        let alist = res1 k hash1 [] 
        in
        alist  ;;
let main = 
        let _ =List.iter (Printf.printf "%d") (solve Sys.argv.(1) (Queue.create ()) (Queue.create ())) in Printf.printf("\n");;(*
        let  ic =open_in file in
        try 
                let line = input_line ic in
                let _= solve line in
                        close_in ic
        with e -> 
                close_in_noerr ic; 
                raise e*)
