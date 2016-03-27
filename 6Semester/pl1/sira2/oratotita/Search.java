package oratotita;

import java.util.*;

public class Search {
	public static int DoIt(Map<Integer,Collection<Building>> s,Map<Integer,Collection<Building>> e,Queue<Integer> q)
	{
		int res =0;
		Set<Building> inProc = new TreeSet();
		while(!q.isEmpty())
		{
			Integer top = q.poll();
			if(e.containsKey(top))
			{
				Collection<Building> temp=e.get(top);
				for(Building i : temp)
					inProc.remove(i); //TODO: overload equals
			}
			Collection<Building> temp;
				if(s.containsKey(top))
				{
					temp = s.get(top);
					for(Building i : temp)
					{
						inProc.add(i);
					}
					//Iterator<Building> it = inProc.iterator();
					
						
				
				}
				float h = -1;
				for(Building i : inProc)
				{
					if(i.getH() > h)
					{
						h= i.getH();
						if(!i.isSeen())
						{
							res++;
							i.Seen();
						}
						
					}
				}
			
			
		}
		return res;
	}
}
