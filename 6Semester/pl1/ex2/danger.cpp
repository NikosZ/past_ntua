#include <stdio.h>
#include <vector>
#include <algorithm>
#include <set>
#define range(v) v.begin();v.end()
using namespace std;
typedef set<int> intset;
typedef vector<intset> vec;
typedef vector<intset>::iterator it;
vec all;
//int bestfar=0;
class list{
	public:
	class list *next;
	it  point;
	list()
	{
		this->next=NULL;
		//this->point =0;
	}
	void insert(it pointa)
	{
		list *temp=this;
		while(temp->next!=NULL)
				temp=temp->next;
		list *k=new list();
		temp->next=k;
		k->point = pointa;
	}
};
list *lista=new list[43]();
class setA{
	public:
	static int bestfar;
	static intset best;
	static intset intial;
	int last;
	intset myset;
	int el(){return myset.size();}

	//bool operator < (const setA &b) const()
	//return this->myset.size() < b.el();//find a good heristic
};
bool sorti(intset a, intset b)
{return	a.size()<b.size();}
bool is_ok(intset A,intset B)
{
	auto it =A.begin();
	while(A.end()!=it)
	{
		if(B.count(*it)<1)
			return false;
		it++;
	}
	return true;
}
bool isok(intset v,int k)
{
	//for(it i=range(all)!=i;i++)
	list *temp;
	temp = &lista[k];
	while(temp!=NULL)
	{
		//if(v.size()<i->size())
		//break;
		//if(i->count(k)<1)
		//continue;
		//intset temp;
		//set_difference((*i).begin(),(*i).end(),v.begin(),v.end(),inserter(temp, temp.begin()));
		//if(temp.end()==temp.begin() || *temp.begin() ==0)
		//return false;
		if(is_ok(*(temp->point),v))
			return false;
		temp=temp->next;
	}
	return true;
}
//intset search()
	//{
	//	
	//}
void BB_dfs(const int i,setA A)
{
	if(i>setA::intial.size()+1)
		return;
	if(A.el()+ (setA::intial.size()-i)< setA::bestfar)
		return;
	if(A.el()>setA::bestfar)
	{
		setA::bestfar=A.el();
		setA::best=A.myset;
	}
	setA clone = A;
	clone.myset.insert(i);
	if(isok(clone.myset,i))
	{
		BB_dfs(i+1,clone); //ADD
		BB_dfs(i+1,A);
	}
	else
		BB_dfs(i+1,A);
}
int	setA::bestfar=0;
intset setA::intial;
intset setA::best;
int main()
{
			printf("a");
	int N,M;
	scanf("%d %d",&N,&M);
	all.resize(M+1);
	while(M--)
	{
		int temp;
		scanf("%d",&temp);
		intset t;
		while(temp--)
		{
			int tempo;
			scanf("%d",&tempo);
			t.insert(tempo);
			lista[tempo].insert((all.end()-1));
		}
		all.push_back(t);
	}
	for (int i = 1; i < N+1; i++) {
		setA::intial.insert(i);
	}
	setA start;
	sort(all.begin(),all.end(),sorti);
	BB_dfs(1,start);
	printf("best: %d\n",setA::bestfar);
	for (int i = 0; i <N+1 ; i++) {
			if(setA::best.count(i)>0)
				printf("%d ",i);
	}
	printf("\n");
}
