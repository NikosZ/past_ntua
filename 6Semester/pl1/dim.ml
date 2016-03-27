let rec moves v =  ;;
let rec final v = 
let rec push Q v = match v with
| [] -> ()
| (a::b) -> (Queue.add Q a); push Q b;;
let rec bfs Q = let el = Queue.take Q in
        if not final el then push Q (moves el) else el ;;
