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
public class Astar {

	public short h(State smth) {
		return 0;
		/*short diff=0;
		for(int i=0;i<State.finalstate.length();i++)
		{
			
			if(smth.getState().charAt(i) != State.finalstate.charAt(i) )
				diff++;
		}
		return (short) (diff/3);*/
	}
	public short h2(State smth,State smth2) {
		return 0;/*
		short diff=0;
		for(int i=0;i<State.finalstate.length();i++)
		{
			
			if(smth.getState().charAt(i) != smth2.getState().charAt(i) )
				diff++;
		}
		return (short) (diff/3);*/
	}
	public State search(State start)
	{
		Map<State,State> mapi = new HashMap<State,State>();

		Map<State,State> mapi2 = new HashMap<State,State>();
		Queue<State> openset = new LinkedList<State>();//new PriorityQueue<State>(new Mycomp());
		Queue<State> openset2 =new LinkedList<State>();// new PriorityQueue<State>(new Mycomp());
		openset.add(start);
		openset2.add(new State(State.finalstate.toCharArray()));
		while(!openset.isEmpty())
		{
			
			State s =openset.poll();
		//	System.out.println(s.toString());
			if(s.isFinal())
				return s;
			if(mapi2.containsKey(s))
			{
				State k = mapi2.get(s);
				while(k.prev != null)
				{
					State temp = k.prev;
					k.prev = s;
					s=k;
					k=temp;
				}
				return k;
			}
			//openset.remove(s);
		//.out.println(s.toString());
			Collection<State> t = s.next();
			for(State i : t)
			{
				int t_score = s.f_score +1;
				if(!mapi.containsKey(i))
				{
					//add prev
					i.g_score =t_score;
					i.f_score= i.g_score + h(i);
					i.prev = s;
					mapi.put(i, i); 
				//	mapi.put(i,i.g_score);
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
			s = openset2.poll();
			if(mapi.containsKey(s))
			{
				State k = mapi.get(s);
				State t2 = s;
				s=k;
				k=t2;
				while(k.prev != null)
				{
					State temp = k.prev;
					k.prev = s;
					s=k;
					k=temp;
				}
				return k;
			}
			//openset.remove(s);
		//	System.out.println(s.toString());
			 t = s.next();
			for(State i : t)
			{

				int t_score = s.f_score +1;
				if(!mapi2.containsKey(i))
				{
					//add prev
					i.g_score =t_score;
					i.f_score= i.g_score + h(i);
					i.prev = s;
					mapi2.put(i, i); 
				//	mapi.put(i,i.g_score);
					openset2.add(i);
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
		return res;
	}
	
	
}
