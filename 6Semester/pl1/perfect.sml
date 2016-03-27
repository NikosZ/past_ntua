fun add [] = 0
|   add (t::h) = t + add h
fun perfect n = 
	let fun par n 0 ls = ls
	|	par n k ls = if n mod k =0 then par n (k-1) (k::ls) else par n (k-1) ls
	in
	  if add (par n (n-1) []) = n then true else false
	end

	
