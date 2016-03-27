let first (a ,_) =a;
let second (_,b)=b;
let amem x v =not (IntBinarySet.member (v , x));

let dfs2 q q1= if
  (Queue.isEmpty q) then dfs q1 (Queue.mkQueue()) else dfs q q1
and dfs q1 q2= 
let  i = Queue.dequeue q1
in
  if(List.length (first i) =0) then second i else (
  IntBinarySet.app (fn k=> Queue.enqueue( q2,(List.filter (amem k) (first i)
  ,IntBinarySet.add ((second
  i),k )))) (List.hd (first i));
  dfs2 q1 q2);
let bfs (h::ls) q =( IntBinarySet.app (fn k=> Queue.enqueue(q, ((List.filter
  (amem k) ls),IntBinarySet.add'(k, IntBinarySet.empty)))) h; dfs2 q
  (Queue.mkQueue())); 
let parse file =
        let next_int input =
        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
    and stream = TextIO.openIn file
        and n = next_int stream
        and m = next_int stream
    and _ = TextIO.inputLine stream
        and scanner i acc =
            match i with
            | 0 -> acc
            | _ ->
            let k = next_int stream
                and scanline i acc = 
                  match i with
                  | 0 -> acc
                  | _ ->
                    let l = next_int stream
                    in
                        scanline (i - 1) (l :: acc);
                let line = rev(scanline k [k])
            in
                scanner (i - 1) (line :: acc);
    in
        (n, m, rev(scanner m []));
(*let lset [] tel = tel
    lset (h::ls) tel = 
      let let dothis (k::p) = [IntBinarySet.addList (IntBinarySet.empty , p)]
      in
        lset ls ((dothis h) :: tel)
      end;*)

let res n k l = 
    match n with
    | 0 ->l
    | _ ->  if IntBinarySet.member(k,n) then res (n-1) k (n::l) else res
    (n-1) k l;
let cmp (x,y)  = if (List.length x) < (List.length y) then false else true;
let lset ls = List.map (fn (x::ls)=> ls) ls;
let lset2 ls= List.map (fn x=> IntBinarySet.addList (IntBinarySet.empty ,x ))
  ls;
let com ls= lset2 (lset ls);
let mkset n k = 
    match n with
    | 0 -> k
    | _ ->  mkset (n-1) (IntBinarySet.add' (n,k));
let solve N ls =  
  List.map (fn x=> x+0) (IntBinarySet.listItems (IntBinarySet.difference (mkset N
  (IntBinarySet.empty),(bfs ls (Queue.mkQueue()) )))) ;;
let danger fileName=
let (N, M, list_a)= parse fileName
in
   solve N (com ((ListMergeSort.sort cmp ( list_a))));;
let () =
    danger Sys.argv.(0);;
