package blue;
import java.util.AbstractQueue;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;
import java.util.Queue;
import java.util.PriorityQueue;
import java.util.TreeSet;
import java.util.concurrent.ConcurrentLinkedQueue;
public class bfs2side {
	public static boolean  search(State init)
	{
		Map<State,State> mapi = new HashMap<State,State>();
		//Set<State> mapi= new HashSet<State>();
		Set<State> visited= new HashSet<State>();
		Map<State,State> mapi2 = new HashMap<State,State>();
		Set<State> visited2= new HashSet<State>();
		Queue<State> openset = new LinkedList<State>();
		Queue<State> openset2 =new LinkedList<State>();
		openset.add(init);
		openset2.add(new State(init.finalstate.toCharArray()));
		while(!openset.isEmpty())
		{
			State s = openset.poll();
			if(s.isFinal() || mapi2.containsKey(s))
				return true;
			Collection<State> c = s.next();
			visited.add(s);
			for(State i : c)
			{
				if(visited.contains(i))
					continue;
				if(!mapi.containsKey(i))
				{
					mapi.put(i,i);
					//mapi.put(i, true);
					openset.add(i);
				}
			}
		}
		return false;
	}
}
