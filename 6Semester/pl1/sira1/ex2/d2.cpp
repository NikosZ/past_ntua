#include <stdio.h>
#include <vector>
#include <algorithm>
#include <set>
#define range(v) v.begin();v.end()
using namespace std;
typedef vector<int> intset;
typedef vector<int>::iterator it;
typedef vector<intset>::iterator it2;
//int bestfar=0;
//class list{
//public:
//class list *next;
//it  point;
//list()
//{
//this->next=NULL;
////this->point =0;
//}
//void insert(it pointa)
//{
//list *temp=this;
//while(temp->next!=NULL)
//temp=temp->next;
//list *k=new list();
//temp->next=k;
//k->point = pointa;
//}
//};
//list *lista=new list[43]();
class setA{
	public:
	static int bestfar;
	static intset best;
	static intset intial;
	//int last;
	intset myset;
	int el(){return myset.size();}

	//bool operator < (const setA &b) const()
	//return this->myset.size() < b.el();//find a good heristic
};
bool sorti(intset a, intset b)
{return	a.size()<b.size();}
bool is_ok(intset A,intset B)
{
	//for(auto i: A)
	printf("%d",A.size());
	it i =A.begin();
	while(i!=A.end())
	{
		if(!binary_search(B.begin(),B.end(),*i))
			return false;
		i++;
	}
	return true;
}
bool isok(intset v,int k,vector<intset> all)
{
	//for(it i=range(all)!=i;i++)
	//list *temp;
	//temp = &lista[k];
	for(int i=0;i<all.size();i++)
	{
		//if(v.size()<i->size())
		//break;
		//if(i->count(k)<1)
		//continue;
		//intset temp;
		//set_difference((*i).begin(),(*i).end(),v.begin(),v.end(),inserter(temp, temp.begin()));
		//if(temp.end()==temp.begin() || *temp.begin() ==0)
		//return false;
		printf("%d ",all[i].size());
		if(is_ok(all[i],v))
			return false;
	}
	return true;
}
//intset search()
	//{
	//	
	//}
void BB_dfs(const int i,setA A,vector<intset> a)
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
	clone.myset.push_back(i);
	if(isok(clone.myset,i,a))
	{
		BB_dfs(i+1,clone,a); //ADD
		BB_dfs(i+1,A,a);
	}
	else
		BB_dfs(i+1,A,a);
}
int	setA::bestfar=0;
intset setA::intial;
intset setA::best;
int main()
{
vector<intset> all;
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
			t.push_back(tempo);
		}
		all.push_back(t);
	}
	for (int i = 1; i < N+1; i++) {
		setA::intial.push_back(i);
	}
	for(it2 i=range(all)!=i;i++){
		sort(i->begin(),i->end());
		}
	setA start;
	//sort(all.begin(),all.end(),sorti);
	BB_dfs(1,start,all);
	printf("best: %d\n",setA::bestfar);
	for (it i = range(setA::best)!=i; i++) {
				printf("%d ",*i);
	}
	printf("\n");
}
