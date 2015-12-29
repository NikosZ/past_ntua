package oratotita;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.Queue;
import java.util.Scanner;
import java.util.TreeMap;

public class main {
	public static  void main( String[] args)
	{
		Map<Integer,Collection<Building>> StartSet = new TreeMap<Integer, Collection<Building>>();
		Map<Integer,Collection<Building>> EndSet = new TreeMap();
		Queue<Integer> q =  new PriorityQueue(new prioryCmp());
		Scanner s = new Scanner(System.in);
		int n = s.nextInt();
		while(n-- > 0)
		{
			Building temp = new Building(s.nextInt(),s.nextInt(),s.nextInt(),s.nextInt()
					,s.nextFloat());
			int Start = temp.getXs();
			int end = temp.getXe();
			q.add(Start);
			q.add(end);
			Collection<Building> startC;
			//Collection<Building> endC;
			if(StartSet.containsKey(Start))
			{
				startC = StartSet.get(Start);
				startC.add(temp);
				StartSet.put(Start, startC);
			}
			else
			{
				startC = new ArrayList<Building>();
				startC.add(temp);
				StartSet.put(Start, startC);
			}
			if(EndSet.containsKey(end))
			{
				startC = EndSet.get(end);
				startC.add(temp);
				EndSet.put(end, startC);
			}
			else
			{
				startC = new ArrayList<Building>();
				startC.add(temp);
				EndSet.put(end, startC);
			}
		}

		System.out.println(Search.DoIt(StartSet, EndSet, q));
	}
}
