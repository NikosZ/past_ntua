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
let rec str s n res= match n with
|12-> List.rev res
|_-> str s (n+1) ((String.get s n)::res) ;;
let finaly = (str "bgbGgGGrGyry" 0 []);;
let rec hasi hash v= Hashtbl.add hash (char_str (first v)) (second v);;
let rec moves v =
        let k = char_str v in ((move1 v),(k,1)):: ((move2 v) ,(k,2))::( (move3 v,(k,3)) ):: (move4 v,(k,4))::[];;
(*let rec final (a0::a1::a2::a3::a4::a5::a6::a7::a8::a9::a10::a11::c) = if (a0 == '') then true else false;;
*)

let rec fi v vi = match v with
| [] -> true;
| (a::b)-> if a=(List.hd vi) then (fi b (List.tl vi)) else false;;
let rec final v = fi v finaly;;
let rec push v qu= match v with
| [] -> ()
| _ ->  let _ =Queue.add (List.hd v) qu in push (List.tl v) qu;;
(*let push2 q a= Queue.add a q;;
let pushk v  qu= (List.iter (fun x->( Queue.add  x qu))  v) ;;*)
(*let sk a v = match v with
| [] -> true
| (b::c) -> ((List.hd a) =b) && (sk (List.tl a) c);;
let same a v = match a with 
| []-> false
| (a::b) -> if (sk a v) then true else same b v ;;*)
let rec addset s mo = match mo with
| [] -> s
| (a::b) -> addset (SS.add a s) b;;
let rec  bfs qu hash visited= 
        let el = (Queue.take qu) in
        if (not (final el)) then
                let _ = List.iter (Printf.printf "%c") el and
                _ = Printf.printf "\n"  and
                poo =char_str el in 
                       let movi = moves el in
                let k = List.map (first)  (List.filter (fun x-> not( SS.mem (List.map (char_str (first x)))) visited) movi) in
                let y = List.map (fun x-> char_str x) k in
                let _ =  push k qu in
                let  _ =  List.iter (fun x-> hasi hash x) movi in
                let _ =  bfs qu hash (addset visited y) in
                ();
        else ();;


let rec res v res2 k hash= match k with
| 0 -> res2
| _ ->
        (if Hashtbl.mem hash v then 
                let e = Hashtbl.find hash v in
                res (first e) ((second e) :: res2) k hash
        else
                res v res2 0 hash) ;;
let rec solve s qu= 
        let _ =Queue.add (str s 0 []) qu 
        and hash = Hashtbl.create 1000 in
         bfs qu hash SS.empty;
         res (char_str finaly) [] 1 hash;;
let main = 
       List.iter (Printf.printf "%d") (solve Sys.argv.(1) (Queue.create ()));;(*
        let ic =open_in file in
        try 
                let line = input_line ic in
                let _= solve line in
                        close_in ic
        with e -> 
                close_in_noerr ic; 
                raise e*)
