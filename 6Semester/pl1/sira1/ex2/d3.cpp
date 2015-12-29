#include <vector>
#include <algorithm>
#include <stdio.h>
#include <set>
#include <queue>
using namespace std;
typedef vector<int > list;
typedef vector<list> heap;
typedef list::iterator it_list;
typedef heap::iterator it_heap;
//heap all;
int best=44;
int *mem;
bool cmp2(int a,int b)
{
	return mem[a]>mem[b];
}
class mycomparison
{
	public:
		  bool operator() (const int& lhs, const int&rhs) const
			    {
					return mem[lhs]>mem[rhs];
							  }
};
bool cmp(list a,list b)
{return a.size()<b.size();}
list dfs(heap a,list b,list best1,list ki)
{
	if(b.size()>best)
		return best1;
	if(a.size()<1)
	{
		best=b.size();
		best1=b;
		return best1;
	}
	list bi;
	bi.resize(44);
	bi=ki;
	priority_queue<int,vector<int >, mycomparison> q;
	for(it_list it = a[0].begin();it!=a[0].end();it++)
	{
		
		if(binary_search(ki.begin(),ki.end(),*it))
			continue;
		q.push(*it);
	}
	while(!q.empty()){
		int it=q.top();
		q.pop();
		heap k;
		b.push_back(it);
		for(it_heap it2=a.begin();it2!=a.end();it2++)
			if(!binary_search(it2->begin(),it2->end(),it))
				k.push_back(*it2);
		best1=dfs(k,b,best1,bi);
		b.pop_back();
		bi.push_back(it);
	}
	return best1;
}
int	main(int argc,char *argv[])
{
	heap all;
	list bestsol;
	int	M,N;
	scanf("%d %d",&N,&M);
	mem= new int[43]();
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
			temp.push_back(temp1);
		}
		all.push_back(temp);

	}
	sort(all.begin(),all.end(),cmp);
	for(it_heap it=all.begin();it!=all.end();it++)
		{sort(it->begin(),it->end());}
	list a;
	list b;
	//a.resize(44);
	bestsol=dfs(all,a,bestsol,b);
	sort(bestsol.begin(),bestsol.end());
	printf("best: %d\n",N-best);
	for(int i=1;i<N+1;i++)
		if(!binary_search(bestsol.begin(),bestsol.end(),i))
			printf("%d ",i);
	printf("\n");
}
