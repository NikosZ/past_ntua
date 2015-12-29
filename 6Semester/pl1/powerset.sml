fun powerset [] ls = ls
|   powerset (h::t) ls = 
	let fun con x [] = [[x]]
	|       con x (h::t) = [x::h] @ (con x t)
	in
		con h (powerset t ls) @ powerset t ls
	end
