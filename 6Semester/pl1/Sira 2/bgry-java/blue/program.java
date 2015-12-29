package blue;
import blue.*;
public class program {
	public static void main( String[] args)
	{
		String s1 =new String(args[0]);
		State s = new State(s1.toCharArray());
		Astar a = new Astar();
		//bfs2side item= new bfs2side();
		//if(bfs2side.search(s))
	//	System.out.println("a");
		System.out.println(new StringBuilder(a.path(s)).reverse().toString());
	}
}
