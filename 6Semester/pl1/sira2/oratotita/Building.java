package oratotita;


public class Building implements Comparable<Building>{
	private final int startx;
	private final int endx;
	private final int starty;
	private final int endy;
	private final float height;
	private boolean isSeen ;
	//private final float medial;
	Building(int xa,int ya,int xb,int yb,float h){
		startx=xa;
		endx=xb;
		starty=ya;
		endy=yb;
		height=h;
		isSeen=false;
	//	medial = (xa+xb)/2.0;
	}
	public boolean isSeen()
	{
		return isSeen;
	}
	public void Seen()
	{
		isSeen=true;
	}
	public boolean equals(Building o )
	{
		if (startx == o.getXs() && starty == o.getYs() && endx == o.getXe() 
				&& endy == o.getYe() && isSeen == o.isSeen())
			return true;
		return false;
	}


	//public double getKey(){return  medial;}
	public float getH(){return height;}
	public int getXs(){return startx;}
	public int getYs(){return starty;}
	public int getXe(){return endx;}
	public int getYe(){return endy;}
	public int compareTo(Building o)
	{
		if(starty<o.getYs())
			return -1;
		else if (starty==o.getYs())
			return 0;
		else	
			return 1;
	}
}
