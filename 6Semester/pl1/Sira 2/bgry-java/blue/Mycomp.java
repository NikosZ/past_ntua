package blue;

import java.util.Comparator;

public class  Mycomp implements Comparator<State>{

	public int compare(State o1, State o2) {

		if (o1.f_score < o2.f_score)
			return -1;
		else if (o1.f_score > o2.f_score)
			return 1;
		else
			return 0;
	}


	
}
