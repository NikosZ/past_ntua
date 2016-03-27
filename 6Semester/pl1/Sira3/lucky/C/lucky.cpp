#include <iostream>
#include <stdlib.h>
#include <vector>
#include <math.h>
#include <algorithm>
#include <set>
#include <map>
#include <limits>
#define pb(l) push_back(l)
#define all(x) begin(x),end(x)
#define forall(iter,x) for(iter=x->begin();x->end()!=iter;iter++)
//#define check(x) if (fabs(x-100.0) <0.000001) throw 1
#define check(x) if (fabs(x-100.0) <0.0000001) {throw 1;}
using namespace std;
typedef set<long double> dset,*dset2;
typedef set<long double>::iterator it;
typedef map<int, dset2> mem;
int hash(int i ,int j)
{
	return 11*i+j;
}
vector<long double> digitalize (long n)
{
	vector<long double> ret;
	while(n>0)
	{
		long double tmp =(long double) (n%10);
		ret.pb(tmp);
		n/=10;
	}
	ret.pb(0);
	reverse(ret.begin(),ret.end());
	return ret;
}
void printset(dset *);
vector<long double> digits;
void calc(long double a ,long double b,dset* k)
{
	if(a==0.)
	{
		k->insert(b);
		k->insert((-b));
		k->insert(0);
		return;
	}
	else if(b==0.){
		k->insert(a);
		k->insert(0);
	return;}

		k->insert(a+b);
		k->insert(a-b);
		k->insert(a*b);
		k->insert(a/b);
}
void calc1(long double a ,long double b)
{
//	cout<<a<<" "<<b<<endl;
	if(a==0.)
	{
		check(b)
		check((-b))
		return;
	}
	else if(b==0.){
		check(a)
	return;}
	long double c[4];
	c[0] = a+b;
	c[1] =a-b;
	c[2] = a*b;
	c[3]= a/b;
	//cout<<a<<" "<<b<<endl;
//	cout<<c[0]<<endl;
//	cout<<c[1]<<endl;
//	cout<<c[2]<<endl;
//	cout<<c[3]<<endl;
	check(c[0])
	check(c[1])
	check(c[2])
	check(c[3])
}
long double number12 (int a,int b)
{
	long double res=0;
	while(a<=b)
	{
	 res = res*10 +digits[a];	
	a++;
	}
	return res;
}
void non_det(dset *set1,dset *set2,dset* newset)
{
	it iter1,iter2;
	forall(iter1,set1)
	{
		forall(iter2,set2)
		{
			calc (*iter1,*iter2,newset); 
		}
	}
}
void non_det2(dset *set1,dset *set2)
{
	it iter1,iter2;
	forall(iter1,set1)
	{
		forall(iter2,set2)
		{
			calc1 (*iter1,*iter2); 
		}
	}
}
void printset(dset * b)
{
	it ite;
	forall(ite,b)
	{
		cout<<*ite<<" "<<endl;
	}
}
dset* solve(mem memo,int i, int j)
{
	if(i==j)
	{
		dset *news = new dset;
		news->insert(digits[i]);
		return news;
	}
	int z = hash(i,j);
	if(memo.count(z)>0)
		return memo[z];
	dset *newset =new dset;
	for(int k=0;k<j-i;k++)
	{
		non_det(solve(memo,i,i+k),solve(memo,i+k+1,j),newset);
	}
	newset->insert(number12(i,j));
//	cout<<number12(i,j)<<endl;
	memo[z]=newset;
	return memo[z];
}
bool solve1(mem memo,int i, int j)
{
	if(i==j)
	{
		dset *news = new dset;
		news->insert(digits[i]);
		return news;
	}
	int z = hash(i,j);
	if(memo.count(z)>0)
		return memo[z];
	for(int k=0;k<j-i;k++)
	{
		try{
		non_det2(solve(memo,i,i+k),solve(memo,i+k+1,j));}
		catch(int e){
		return false;}


	}
	if(number12(i,j)!=100)
	return true;
	else
		return false;
}
int main(int argc,char *argv[])
{
	int i=1;
	while(i<argc)
	{
		long n= strtol(argv[i],NULL,10);
		i++;	
		digits = digitalize(n);
		int size= digits.size();
		mem *memo = new mem;
		if(solve1(*memo,1,size-1))
			cout<<"true ";
		else
			cout<<"false ";
		delete memo;

	}
	cout<<endl;
	return 0;
}


