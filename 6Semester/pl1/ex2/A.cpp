#include <vector>
#include <algorithm>
#include <stdio.h>
#include <set>
#include <queue>
using namespace std;
typedef set<int> list,*h;
typedef vector<list> heap;
typedef list::iterator it_list;
typedef heap::iterator it_heap;
typedef pair<vector<short>,vector<short> > mypair;
//heap all;
//int *mem;
//bool cmp2(int a,int b)
//{
//return mem[a]>mem[b];
//}
//class mycomparison
//{
//public:
//bool operator() (const int& lhs, const int&rhs) const
//{
//return mem[lhs]>mem[rhs];
//}
//};
bool cmp(list a,list b)
{return a.size()<b.size();}
#define range(v) v.begin();v.end()
list *hash_table;
int N;
bool hash(vector<short> a)
{
	int hashA(0),hashB(0);
	for(vector<short>::iterator i =a.begin();i!=a.end();i++)
	{
		if(*i < N/2)
			hashA+= 2<<(*i);
		else
			hashB+=2<< ((*i) % (N/2));
	}
	if(hash_table[hashA].count(hashB)==0)
	{
		hash_table[hashA].insert(hashB);
		return true;
	}
	return false;
}
int max1=0;
vector<short> dfs(heap a)
{
	vector<short> b;
	queue<mypair> q;
	for(it_list it=range(a[0])!=it;it++)
	{
		mypair temp;
		vector<short> myheap;
		vector<short> temp_list;
		temp_list.push_back(*it);
		for(int it2=0;it2<(int)a.size();it2++)
		{
			if(a[it2].count(*it)==0)
			{
				 short temp;
				temp =(short) it2;
				myheap.push_back(temp);
			}
		}
		temp.first=myheap;
		temp.second=temp_list;
		hash(temp.second);
		q.push(temp);
		b=temp_list;
	}
	while(!q.empty())
	{
		if(q.size()>max1)
			max1=q.size();
		mypair cur;
		cur=q.front();
		q.pop();
		#define range2(a) a.begin();a.end()
		for(it_list it=range2(a[cur.first[0]])!=it;it++)
		{
			
		mypair temp;
		vector<short> myheap;
		//myheap.resize(cur.first.size());
		vector<short> temp_list=cur.second;
		temp_list.push_back(*it);
		for(vector<short>::iterator it2=cur.first.begin();it2!=cur.first.end();it2++)
		{
			if(a[*it2].count(*it)==0)
			{
				short temp;
				temp = *it2;
				myheap.push_back(temp);
			}
		}
		if(myheap.size()==0)
			return temp_list;
		if(!hash(temp_list))
			continue;
		temp.first=myheap;
		temp.second=temp_list;
		q.push(temp);
	  }
	}
	return b;
}
int main(int argc,char *argv[])
{
	heap all;
	//list bestsol;
	int	M;
	FILE *in =fopen(argv[1],"r");
	fscanf(in,"%d %d",&N,&M);
	hash_table = new list[(2<<(N/2))+1]();
	//mem= new int[43]();
	while(M--)
	{
		list temp;
		int	A;
		fscanf(in,"%d",&A);
		while(A--)
		{
			int temp1;
			fscanf(in,"%d",&temp1);
			//mem[temp1]++;
			temp.insert(temp1);
		}
		all.push_back(temp);

	}
	sort(all.begin(),all.end(),cmp);
	//for(it_heap it=all.begin();it!=all.end();it++)
		//{sort(it->begin(),it->end());}
	//a.resize(44);
	vector<short> temp6;
	temp6=dfs(all);
	printf("%d ",max1);
	list bestsol(temp6.begin(),temp6.end());
	//sort(bestsol.begin(),bestsol.end());
	printf("%d ",sizeof(mypair));
	for(int i=1;i<N+1;i++)
		if(bestsol.count(i)<1)
		//if(!binary_search(bestsol.begin(),bestsol.end(),i))
			printf("%d ",i);
	printf("\n");
}
