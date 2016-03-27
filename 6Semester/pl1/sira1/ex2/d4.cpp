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
typedef pair<vector<h> ,list> mypair;
//heap all;
//int *mem;
//bool cmp2(int a,int b)
//{
//return mem[a]>mem[b];
//}
class cmp2
{
	public:
		bool operator() (const mypair& lhs, const mypair& rhs) const
		{
			if(lhs.second.size()==rhs.second.size())
			return ((lhs.first).size()>(rhs.first).size());
			else
				return lhs.second.size()>rhs.second.size();
		}
};
bool cmp(list a,list b)
{return a.size()<b.size();}
//bool guard=false;
/*list dfs(heap a)
{
	queue<mypair> q;
	for(it_list i=a[0].begin();i!=a[0].end();i++)
		{
			mypair temp;
			heap aheap;
			for(it_heap it=a.begin();a.end()!=it;it++)
				if(it->count(*i)==0	)
					aheap.push_back(*it);
			temp.first=aheap;
			list temp2;
			temp2.insert(*i);
			temp.second=temp2;
			q.push(temp);
		}
	while(!q.empty())
		{
			mypair temp=q.front();
			q.pop();
			//for(it_heap it=temp.first.begin();temp.first.end()!=it;it++)
				//for(it_list it2=it->begin();it->end()!=it2;it2++)printf("%d ",*it2);
			if(temp.first.size()<1)
				return temp.second;
	for(it_list i=temp.first[0].begin();i!=temp.first[0].end();i++)
		{
			mypair temp;
		 	heap aheap;
			for(it_heap it=temp.first.begin();temp.first.end()!=it;it++)
				if(it->count(*i)==1)
					aheap.push_back(*it);
			temp.first=aheap;
			list temp2; temp2=temp.second;
			temp2.insert(*i);
			temp.second=temp2;
			//if(aheap.size()<1)
			//return temp2;
			q.push(temp);
		}
		}

}
*/
#define range(v) v.begin();v.end()
list dfs(heap a)
{
	priority_queue<mypair,vector<mypair>,cmp2> q;
	for(it_list it=range(a[0])!=it;it++)
	{
		mypair temp;
		vector<h> myheap;
		list temp_list;
		temp_list.insert(*it);
		for(int it2=0;it2<a.size();it2++)
		{
			if(a[it2].count(*it)==0)
			{
				 h temp;
				temp = &(a[it2]);
				myheap.push_back(temp);
			}
		}
		temp.first=myheap;
		temp.second=temp_list;
		q.push(temp);

	}
	while(!q.empty())
	{
		mypair cur;
		cur=q.top();
		q.pop();
		#define range2(a) a->begin();a->end()
		for(it_list it=range2(cur.first[0])!=it;it++)
		{
			
		mypair temp;
		vector<h> myheap;
		list temp_list=cur.second;
		temp_list.insert(*it);
		for(int it2=0;it2<cur.first.size();it2++)
		{
			if(cur.first[it2]->count(*it)==0)
			{
				h temp;
				temp = cur.first[it2];
				myheap.push_back(temp);
			}
		}
		if(myheap.size()==0)
			return temp_list;
		temp.first=myheap;
		temp.second=temp_list;
		q.push(temp);
	  }
	}
}
int main(int argc,char *argv[])
{
	heap all;
	list bestsol;
	int	M,N;
	scanf("%d %d",&N,&M);
	//mem= new int[43]();
	while(M--)
	{
		list temp;
		int	A;
		scanf("%d",&A);
		while(A--)
		{
			int temp1;
			scanf("%d",&temp1);
			//mem[temp1]++;
			temp.insert(temp1);
		}
		all.push_back(temp);

	}
	sort(all.begin(),all.end(),cmp);
	//for(it_heap it=all.begin();it!=all.end();it++)
		//{sort(it->begin(),it->end());}
	//a.resize(44);
	bestsol=dfs(all);
	//sort(bestsol.begin(),bestsol.end());
	//printf("best: %d\n",N-bestsol.size());
	for(int i=1;i<N+1;i++)
		if(bestsol.count(i)<1)
		//if(!binary_search(bestsol.begin(),bestsol.end(),i))
			printf("%d ",i);
	printf("\n");
}
