package blue;
import java.util.AbstractQueue;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;
import java.util.Queue;
import java.util.PriorityQueue;
import java.util.TreeSet;
import java.util.concurrent.ConcurrentLinkedQueue;
public class Astar2 {

	public short h(State smth) {
		short diff=0;
		for(int i=0;i<State.finalstate.length();i++)
		{
			
	//		if(smth.getState().charAt(i) != State.finalstate.charAt(i) )
		//		diff++;
		}
		return (short) (diff/3);
	}
	public State search(State start)
	{
		Map<State,Integer> mapi = new HashMap<State,Integer>();
		Set<State> visited= new HashSet<State>();;
		Queue<State> openset = new PriorityQueue<State>(new Mycomp());
		openset.add(start);
		while(!openset.isEmpty())
		{
			State s =openset.poll();//av;//openset.poll();  //openset.first();
			//System.out.println(s.getState());
			if(s.isFinal())
				return s;
			//openset.remove(s);
			visited.add(s);
			Collection<State> t = s.next();
			for(State i : t)
			{
				if(visited.contains(i))
					continue;
				int t_score = s.f_score +1;
				if(!mapi.containsKey(i))
				{
					//add prev
					i.g_score =t_score;
					i.f_score= i.g_score + h(i);
					i.prev = s;
					//mapi.put(i,i.g_score);
					openset.add(i);
				}
			/*	else
				{
					//State sk = openset.ceiling(i);
					int ko=mapi.get(s) ;
					if(ko > t_score)
					{
						openset.remove(i);
						i.g_score =t_score;
						i.f_score= i.g_score + h(i);
						i.prev = s;
						mapi.remove(i);
						mapi.replace(i,ko, i.g_score);
						openset.add(i);
					}
				}*/
				}
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
		return res;
	}
	
	
}
