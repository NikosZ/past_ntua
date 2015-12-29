fun innerproduct A B dc =
let
  fun inner A B x acc dc =
    if (Array.lenght A) = (x +dc) then acc
    else inner A B (x+1) (acc + Array.sub(A , x) *
    Array.sub(B, x + dc) ) dc;
in
  inner A B 0 0 dc 
end
