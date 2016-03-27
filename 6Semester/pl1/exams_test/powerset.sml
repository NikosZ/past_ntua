fun powerset [] = [[]]
  | powerset (h::t) = (map (fn x=> h::x) (powerset t)) @ powerset t ;;

