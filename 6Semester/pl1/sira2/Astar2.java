
import java.util.AbstractQueue;
import java.util.ArrayDeque;
import java.util.Collection;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;
import java.util.Queue;
import java.util.PriorityQueue;
import java.util.TreeSet;
import java.util.concurrent.ConcurrentLinkedQueue;
public class Astar2 {

	public State search(State start)
	{
		Set<Integer> visited  = new HashSet<Integer>();
		Queue<State> inProc = new  ArrayDeque<State>();
		//Hashtable<State,Integer> table = new Hashtable<State,Integer>();
		inProc.add(start);
		final String finalstate="bgbGgGGrGyry";
		final State finaly = new State(finalstate.toCharArray());
		visited.add(start.hashCode());
		while(!inProc.isEmpty())
		{
			State now = inProc.poll();
			if(now.equals(finaly))
				return now;
			
			Collection<State> next = now.next();
			for(State i : next)
			{
				if(!visited.contains(i.hashCode()))
				{
					visited.add(i.hashCode());
				inProc.add(i);
			}}
		}
		return null;
		
	}
	public String path(State start)
	{
		State s = search(start);
		String res = new String();
		while(s.prev!= null)
		{
			res = res+ Integer.toString(s.movi);
			s=s.prev;
		}
		

		//for(int i : s.previus)
		//	res = res+ Integer.toString(i);
		return res;
	}
	
	
}
