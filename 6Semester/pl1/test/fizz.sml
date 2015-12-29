fun loop 0 _ = ()
  | loop n k = (loop (n-1) k;k n )
fun fizz 0 = ()
  | fizz n = 
      let fun vari n 0 = true
            | vari n k = (if n mod k = 0 then true else false)
      in if vari n 15 then print "FizzBuzz" else if vari n 5 then print "Buzz"
                                                 else if vari n 3 then print
                                                 "Fizz" else print (Int.toString
                                                 n);print "\n"
      end

