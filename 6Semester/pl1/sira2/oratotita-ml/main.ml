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
(*let haS =Hashtbl.create 1000;;
let haE =Hashtbl.create 1000;;
let haA =Hashtbl.create 20;;*)
let processing = BSet.empty ;; 
(*let qup = Set.empty() ;;*)
let doSeen a =let _ = a.seen<- true in 1 ;;
let rec newSeen ls prev= match ls with 
| [] -> 0
| (a::b) -> if a.h > prev then  (newSeen b a.h + (if not a.seen then doSeen a else 0); )else newSeen b prev;;
let rec remove q ls = match ls with
| [] -> q
| (a::b) -> remove (BSet.remove a q) b ;;
let rec addi q ls = match ls with
| [] -> q
| (a::b) -> addi (BSet.add a q) b ;;
let find_h hash key= try Hashtbl.find hash key with Not_found -> [] ;;
let rec solve n ls p haS haE= match ls with
| [] -> n
| (a::b) ->  (
               let out =find_h haE a (* Hashtbl.find haE a*)
               and ink = find_h haS a(*Hashtbl.find haS a*) in
               let qnew = addi (remove p out) ink in
               solve (n+ newSeen (BSet.elements qnew) 0.0) b qnew haS haE 

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
let final_const bu haS haE haA= let k = build bu in 
                    let _ =  add_to_table haS k.xs k (*Hashtbl.add haS k.xs k *)
                    and _ =add_to_table haE k.xe k (*Hashtbl.add haE k.xe k*)
                    in
                    let _=  add_to_table haA 1 k.xe and
                     _=  add_to_table haA 1 k.xs in
                    ();; 
let line_e line haS haE haA= (final_const (split_char ' ' line) haS haE haA );;
let line_stream_of_channel channel =
            Stream.from
                  (fun _ ->
                                   try Some (input_line channel) with End_of_file -> None);;
let main = let in_channel = open_in Sys.argv.(1) in
let haS =Hashtbl.create 1000 and
 haE =Hashtbl.create 1000 and
 haA =Hashtbl.create 20 in
        let _ = input_line in_channel in 
        try
                while true do
                        line_e (input_line in_channel) haS haE haA;
                done
        with End_of_file -> close_in in_channel;
        if (Hashtbl.mem haA 1) then
        Printf.printf("%d\n") (solve 0 (Hashtbl.find haA 1) BSet.empty haS haE ) 
        else
        Printf.printf("ERROR");;
              (*  Stream.iter (fun x -> line_e x) (line_stream_of_channel in_channel);
                close_in in_channel
        with e->
                close_in in_channel;
                raise e*)
