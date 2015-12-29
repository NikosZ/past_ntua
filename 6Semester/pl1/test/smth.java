import java.util.*;
import java.lang.*;
public class smth{
	public static void main(String []args)
	{
		da x = new da("42");
		Collection<da> ls = new ArrayList<da>();
		ls.add(x);
		x.S = "5";
		for(da y : ls)
			System.out.println(y.S);
	}
}
