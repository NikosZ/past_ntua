fun mapAllpairsW f xs = 
        let 
        fun h x y = (x,y)
        fun g x = List.map (h x) xs
        in
        List.map f (List.map g xs)
        end;





fun mapAllpairs f xs = 
        let 
        fun h x y = (x,y)
        fun g x =  (List.map (h x) xs)
        in
        List.map f (List.foldr  (fn (x,y)=> x@y  ) [] (List.map g xs))
        end;
