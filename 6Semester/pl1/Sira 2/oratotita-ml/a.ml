type building = 
        { xs : int
        ; xe : int
        ; ye : int
        ; h : float;
        mutable seen : bool;};;
let cmpY a b  = if (a.ye = b.ye && a.xs =b.xs && a.xe = b.xe && a.h = b.h) then 0 else (if a.ye < b.ye then -1 else 1) ;; 
module AetB =
        struct
                type t = building
                let compare =cmpY
        end
module BSet = Set.Make(AetB);;
module Imap = Map.Make(struct type t =int let compare = compare end);;
module Iset = Map.Make(struct type t =int let compare = compare end);;



let rec remove q ls = match ls with
| [] -> q
| (a::b) -> remove (BSet.remove a q) b ;;
let rec addi q ls = match ls with
| [] -> q
| (a::b) -> addi (BSet.add a q) b ;;
let doSeen el = if el.seen then 0 else let _ = el.seen <- true in 1;;
let rec newSeen el themap h res= match el with
| [] -> res
| (a::b) -> let buil = Imap.find themap a in if buil.h > h then  newSeen b themap buil.h (res+doSeen buil) else newSeen b themap h res;;

let rec solve q mapS mapE count inProc themap= 
        if Queue.is_empty q then count 
        else(
                let pop = Queue.pop q in
                let rem = try Imap.find pop mapE with Not_found -> [] and
                    addm = try Imap.find pop mapS with Not_found ->[] in
                let newq = addi (remove inProc rem) addm in
                solve q mapS mapE (count+newSeen (BSet.elements newq) then 0.0 0) newq themap
        );;





let split_char sep str =
        let string_index_from i =
try Some (String.index_from str i sep)
        with Not_found -> None
        in
        let rec aux i acc = match string_index_from i with
        | Some i' ->
        let w = String.sub str i (i' - i) in
        aux (succ i') (w::acc)
        | None ->
        let w = String.sub str i (String.length str - i) in
List.rev (w::acc)
        in
        aux 0 []

let add_to_table hash key value =
        if Hashtbl.mem hash key then let u = Hashtbl.find hash key in 
                Hashtbl.replace hash key (value::u)
        else
                Hashtbl.add hash key (value::[]);;
let build k = {xs= (Pervasives.int_of_string (List.nth k 0)) ;xe =(Pervasives.int_of_string (List.nth k 2)); ye =Pervasives.int_of_string (List.nth k 3) ; h =(Pervasives.float_of_string (List.nth k 4));seen = false;} ;;


let final_const bu hA= let k = build bu in 
                let 


let line_e line haA= (final_const (split_char ' ' line) haA );;
let line_stream_of_channel channel =
            Stream.from
                  (fun _ ->
                                   try Some (input_line channel) with End_of_file -> None);;
let main = let in_channel = open_in Sys.argv.(1) in
let haS =Imap.empty and
 haE =Imap.empty and
 haA =Hashtbl.create 2 in
let _=Hashtbl.add haA 1 []in
        let _ = input_line in_channel in 
        try
                while true do
                        line_e (input_line in_channel) haA;
                done
        with End_of_file -> close_in in_channel;
        Printf.printf("%d\n") (solve 0 (Hashtbl.find haA 1) BSet.empty haS haE ) 
