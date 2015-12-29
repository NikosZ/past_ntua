package blue;

import java.util.ArrayList;
import java.util.Collection;

public class State {
	public int st[] ;
//	public ArrayList<Integer> previus;
	public State prev;
	public int  hash;
	public int movi=0;
	public static int[] translate(char [] a)
	{
		int res[] = new int[12];
		for(int i =0;i<12;i++)
		{
			if(a[i] == 'r')
				res[i]=1;
			if(a[i]== 'y')
				res[i] =0;
			if(a[i]=='G')
				res[i]=2;
			if(a[i]== 'g')
				res[i]= 3;
			if(a[i]=='b')
				res[i] = 4;
		}
		return res;
	}

//	String getState()
	//{return st.toString();}
	State(int [] k)
	{
	//	f_score=0;
		//g_score =0;
		hash=0;
		st=k;
	//	previus=null; 
	}
	State(int [] k,int m,State prev)
	{
	//	f_score=0;
		//g_score =0;
		st=k;
		this.prev =prev;
		movi = m;
	//	this.previus=(ArrayList<Integer>) prev.previus.clone();
	//	this.previus.add(m);
		hash=0;
	}
	State(char[] k)
	{
		hash=0;
		//previus= new ArrayList<Integer>();
		st=translate(k);
		movi=0;
	}
	public Collection<State> next()
	{
		Collection<State> state = new ArrayList<State>(4);
		int s1[] = new int[] { st[2],st[1],st[5],st[0],st[4],st[3],st[6],st[7],st[8],st[9],st[10],st[11]};
		int s2[] = new int[] {st[0],st[3],st[2],st[6],st[1],st[5],st[4],st[7],st[8],st[9],st[10],st[11]};
		int s3[] = new int[] { st[0],st[1],st[2],st[3],st[4],st[7],st[6],st[10],st[5],st[9],st[8],st[11]};
		int s4[] = new int[] {st[0],st[1],st[2],st[3],st[4],st[5],st[8],st[7],st[11],st[6],st[10],st[9]};
		state.add(new State(s1,1,this));
		state.add(new State(s2,2,this));
		state.add(new State(s3,3,this));
		state.add(new State(s4,4,this));
		return state;
	}
	/*public String toString()
	{
		return new String(st);
	}*/
/*	public Collection<State> next()
	{
		Collection<State> states = new ArrayList<State>();
		
		int[] s1;//= new char[12];// =new String();
		s1 = st.clone();
		int a,b,c,d; a=s1[0];b=s1[2];c=s1[5];d=s1[3];
		s1[0]=b;
		s1[2]=c;
		s1[5]=d; s1[3]=a;
//	System.out.println(s1.toString());
		//swap(s1,0,3);swap(s1,2,3);
		//s1 = new StringBuilder(st);s1.setCharAt(0, st.charAt(2));s1.setCharAt(2, st.charAt(5));s1.setCharAt(3, st.charAt(0));s1.setCharAt(5, st.charAt(3));
		//s1 = new StringBuilder(12).append(st.charAt(2)).append(st.charAt(1)).append(st.charAt(5)).append(st.charAt(0)).append(st.charAt(4)).append(st.charAt(3)).append(st.substring(6, 12)).toString();
		//System.out.println(s1);
		//System.exit(0);
	//	StringBuilder s2 ;
	//	StringBuilder s3 ;
		int s2[]; //= new char[12];
		s2=st.clone(); 
		a=s2[3];b=s2[1];c=s2[6];d=s2[4];
		s2[3]=c;
		s2[1]=a;
		s2[6]=d;
		s2[4]=b;
		int s3[];
		s3=st.clone();
		a=s3[5];b=s3[7];c=s3[8];d=s3[10];
		s3[5]=b;s3[7]=d;s3[8]=a; s3[10]=c;
		int s4[];
		s4 = st.clone();
		a=s4[6];b=s4[8];c=s4[11];d=s4[9];
		s4[6]=b;s4[8]=c;s4[11]=d;s4[9]=a;
	//	StringBuilder s4 ;
		//s2 =new StringBuilder(st);s2.setCharAt(1, st.charAt(3));s2.setCharAt(3, st.charAt(6));s2.setCharAt(4, st.charAt(1));s2.setCharAt(6, st.charAt(4));
		//s2 =new StringBuilder(12).append(st.charAt(0)).append(st.charAt(3)).append(st.charAt(6)).append(st.charAt(1)).append(st.charAt(2)).append(st.charAt(5)).append(st.charAt(4)).append( st.substring(7, 12)).toString();
		//s3 = new StringBuilder(st);s3.setCharAt(5, st.charAt(7));s3.setCharAt(7, st.charAt(10));s3.setCharAt(10, st.charAt(8));s3.setCharAt(8, st.charAt(5));
		//s3= new StringBuilder(12).append(st.substring(0, 5)).append(st.charAt(7)).append(st.charAt(6)).append(st.charAt(10)).append(st.charAt(5)).append(st.charAt(9)).append(st.charAt(8)).append(st.charAt(11)).toString();
	//	s4 = new StringBuilder(st);s4.setCharAt(6, st.charAt(8));s4.setCharAt(8, st.charAt(11));s4.setCharAt(11, st.charAt(9));s4.setCharAt(9, st.charAt(6));
		//s4= new StringBuilder(12).append(st.substring(0, 6)).append(st.charAt(8)).append( st.charAt(7)).append(st.charAt(11)).append(st.charAt(6)).append(st.charAt(10)).append(st.charAt(9)).toString();
		State t1 = new State(s1);
		t1.movi=1;
		//System.out.println(s2);
		//System.out.println(s3);
		//System.out.println(s4);
		State t2 = new State(s2);
		t2.movi=2;
		State t3 = new State(s3);
		t3.movi=3;
		State t4 = new State(s4);
		t4.movi=4;
		states.add(t1);
		states.add(t2);
		states.add(t3);
		states.add(t4);
		return states;
	}*/
	public boolean equals(Object a)
	{
		return this.hashCode() == a.hashCode();
		/*
		int [] b =a.st;
		for(int i=0;i<12;i++)
		{
			if(st[i]!=b[i])
				return false;
		}
		return true;*/
	}

	@Override
	public int hashCode()
	{
		if(hash!=0)
		return hash;
		else
		{
			int res=0;
			for(int i=0;i<12;i++ )
			{
				res= this.st[i] +res *5;
			}
			hash = res;
	
			return hash;
		}
	}

/*	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		State other = (State) obj;
		if (hash != other.hash)
			return false;
		return true;
	}
*/


}
