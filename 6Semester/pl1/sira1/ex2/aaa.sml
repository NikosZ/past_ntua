structure SetT =SplaySetFn (struct type ord_key = int
                                val compare = Int.compare end)
fun first (a,_) =a
fun second (_,b)=b
fun amem x v =not (SetT.member (v , x))

fun dfs2 q q1= if
  (Queue.isEmpty q) then dfs q1 (Queue.mkQueue()) else dfs q q1
  and dfs q1 q2= 
  let val i = Queue.dequeue q1
  in
    if(List.length (first i) =0) then second i else (
		  SetT.app (fn k=> Queue.enqueue( q2,(List.filter (amem k) (first i)
		    ,SetT.add ((second
			  i),k )))) (List.hd (first i));
			    dfs2 q1 q2)
		end;
		fun bfs (h::ls) q =( SetT.app (fn k=> Queue.enqueue(q, ((List.filter
		  (amem k) ls),SetT.add'(k, SetT.empty)))) h; dfs2 q
		    (Queue.mkQueue())); 
		fun parse file =
		    let
			        fun next_int input =
					        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
							        val stream = TextIO.openIn file
									        val n = next_int stream
											        val m = next_int stream
													    val _ = TextIO.inputLine stream
														        fun scanner 0 acc = acc
																          | scanner i acc =
																		              let
																					                  val k = next_int stream
																									                  fun scanline 0 acc = acc
																													                    | scanline i acc =
																																		                    let
																																							                        val l = next_int stream
																																													                    in
																																																		                        scanline (i - 1) (l :: acc)
																																																								                    end
																																																													                val line = rev(scanline k [k])
																																																																	            in
																																																																				                scanner (i - 1) (line :: acc)
																																																																								            end
																																																																											    in
																																																																												        (n, m, rev(scanner m []))
																																																																														    end;
																																																																															(*fun lset [] tel = tel
																																																																															    lset (h::ls) tel = 
																																																																																      let fun dothis (k::p) = [SetT.addList (SetT.empty , p)]
																																																																																	        in
																																																																																			        lset ls ((dothis h) :: tel)
																																																																																					      end;*)

																																																																															fun res 0 k l = l
																																																																															  |res n k l = if SetT.member(k,n) then res (n-1) k (n::l) else res
																																																																															      (n-1) k l;
																																																																																  fun cmp (x,y)  = if (List.length x) < (List.length y) then false else true;
																																																																																  fun lset ls = List.map (fn (x::ls)=> ls) ls;
																																																																																  fun lset2 ls= List.map (fn x=> SetT.addList (SetT.empty ,x ))
																																																																																    ls;
																																																																																	fun com ls= lset2 (lset ls);
																																																																																	fun mkset 0 k = k
																																																																																	  | mkset n k = mkset (n-1) (SetT.add' (n,k));
																																																																																	  fun solve N ls =  
																																																																																	    List.map (fn x=> x+0) (SetT.listItems (SetT.difference (mkset N
																																																																																		  (SetT.empty),(bfs ls (Queue.mkQueue()) )))):(int list) ;;
																																																																																		  fun danger fileName=
																																																																																		  let
																																																																																		      val (N, M, list_a)= parse fileName
																																																																																			  in
																																																																																			     solve N (com ((ListMergeSort.sort cmp ( list_a))))
																																																																																				 end
																																																																																				   
