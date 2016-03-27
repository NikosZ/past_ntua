
public class Diapragmateysi {
	public static void main( String[] args)
	{
		String s1 =new String(args[0]);
		State s = new State(s1.toCharArray());
		Astar2 a = new Astar2();
		//public final String finalstate="bgbGgGGrGyry";
		//bfs2side item= new bfs2side();
		//if(bfs2side.search(s))
	//	System.out.println("a");
		System.out.println(new StringBuilder(a.path(s)).reverse().toString());
	}
}
