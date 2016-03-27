fun first (a, _) =a
fun second (_,b) =b 
fun sum_sqrs 0 = 0
  | sum_sqrs n = (n mod 10)*(n mod 10) + sum_sqrs (n div 10)
fun add a b = ((first a + first b),(second b * second a));
fun conv [] l2 res = res
  | conv (a::b) l2 res=conv b l2 (res @ (map (add a) l2));

fun same a b = first a = first b;
fun notsame a b = not (same a b);
fun do_s (x,y) =(first x,second x+second y);
fun myfil f [] l1 l2 = (l1,l2)
  | myfil f (a::b) l2 l3 = if f a then myfil f b (a::l2) l3 else myfil f b l2
  (a::l3)
fun duplicates [] l3= l3
  | duplicates (a::b) l3 = 
  let val i = myfil (same a) b [] []
  in
    duplicates (second i) ((List.foldl
    do_s (first a,0) (a::(first  i)))::l3) 
  end
fun sumk [] l2 l3= l3@l2
  | sumk (a::b) l2 l3 = sumk b (List.filter (notsame a) l2) ((List.foldl do_s a (List.filter
  (same a) l2))::l3);
fun even n =( n mod 2 =0);
 fun  dik 0 = []
      | dik 1 = [(0,1),(1,1),(4,1),(9,1),(16,1),(25,1),(36,1),(49,1),(64,1),(81,1)]
      | dik n = 
      let val i =(conv (dik ((n+1) div 2)) (dik (n div 2)) [])
      in duplicates i []
      end
val make_ls = List.map (dik) [0,1,2,3,4,5,6,7,8,9]
fun funky n k ls=
let val sqrs=[(0,1),(1,1),(4,1),(9,1),(16,1),(25,1),(36,1),(49,1),(64,1),(81,1)]
      in
        (if n = 0 then List.take (sqrs,k) else 
          let val i = conv (List.take (sqrs,(k))) (List.nth (ls,n)) []
    in
      duplicates i []
      end)
          end

fun solver [] ls k= ls
  | solver (a::b) ls k= let val i = solver(b) ls k
          in
            sumk  (map (add (a*a,1)) i) (funky (List.length b) a k)
            []
end
fun is_happy1 (a,b) =
let fun is_happy 1 _ = true
  | is_happy 0 _ = false
  | is_happy n ls = if List.exists (fn x=>x=n) ls then false else is_happy (sum_sqrs
  n) (n::ls)
                       in is_happy a []
                       end
fun sum_a [] = 0
  | sum_a ls = second (List.foldl (fn (x,y)=> (0,second x+second y)) (0,0) (List.filter
  (is_happy1) ls));
fun digitalize 0 = [] 
  | digitalize n= (n mod 10)::(digitalize (n div 10));
fun take_in n = sum_a (solver (rev (digitalize n)) [] make_ls);
fun res a b = (take_in b)- (take_in a) + (if is_happy1(b,0) then 1 else 0);

fun parse file =
let
  (* A function to read an integer from specified input. *)
  fun readInt input = 
    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC)
    input)

    (* Open input file. *)
  val inStream = TextIO.openIn file

  (* Read an integer (number of countries) and consume
  * newline. *)
  val n = readInt inStream
  val y = readInt inStream
  val _ = TextIO.inputLine inStream
in
  (n,y)
end
fun happy file = 
let val x = parse file
in
  res (first x) (second x)
end

