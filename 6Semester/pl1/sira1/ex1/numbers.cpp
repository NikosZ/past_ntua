#define NDEBUG
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <set>
#include <list>
#include <math.h>
#include <algorithm>
#define range(v) v.begin();v.end()
typedef unsigned int uint;
typedef std::vector<uint>::iterator iter;
using namespace std;
const uint sqrs[] ={0,1,4,9,16,25,36,49,64,81};
list<int> del(int n)
{
	list<int> temp;
	while(n)
	{
		temp.push_back(n%10);
		n/=10;
	}
	return temp;
}
uint sum_digits(uint A)
{
	uint sum=0;
	while(A){
		uint temp=A%10;
		sum+=temp*temp;
		A/=10;
	}
	return sum;
}
bool is_happy(uint A,uint* memoization)
{
	if(memoization[A])
		return (memoization[A]==1)?true:false;
	vector<uint> numbers;
	numbers.resize(100);
	numbers.push_back(A);
	memoization[A]=2;
	while(A!=1){
		A=sum_digits(A);
		if(memoization[A]==2){
			return false;
		}
		if(memoization[A]==1)
		{	
			for (iter i=range(numbers)!=i;i++)
				memoization[*i]=1;
			return true;}
		numbers.push_back(A);
		memoization[A]=2;
	}
	for (iter i=range(numbers)!=i;i++)
		memoization[*i]=1;
	numbers.resize(0);
	return true;
}
uint happy_range2(uint A,uint B,uint * mem)
{

	uint sum=0;
	while(A<=B)
	{
		sum=is_happy(A,mem)?(sum+1):sum;
		A++;
	}
	return sum;
}
#define mvl 2000
uint* sum(uint* a,uint* b)
{
	uint *temp= new uint[mvl];
	temp=temp+730;//hackia
	for(uint i =0;i<730;i++)
		temp[i]=a[i]+b[i];
	return temp;		
}
uint* no_fft(uint* a,uint *b)
{	
	uint *temp= new uint[mvl]();
	temp=temp+730;//hackiaa
	for(uint i =0;i<730;i++)
		for(uint j=0;j<=i;j++)
			temp[i]+=a[j]*b[i-j];
	return temp;		
}
uint* den_kanw_diktia(uint n,uint *mem[10])
{
	if (mem[n]!=NULL)
		return mem[n];
	uint *temp= new uint[mvl]();
	temp=temp+730;//hackia
	if(n==0) return temp;
	if(n==1){
		for(int i=0;i<10;i++)
			temp[sqrs[i]]++;
		return temp;
	}
	mem[n]= no_fft(den_kanw_diktia(ceil((1.0*n)/2),mem),den_kanw_diktia(n/2,mem));
	return mem[n];
}
uint* funky(uint len,uint back,uint *mem[10])
{
	uint *temp= new uint[mvl]();
	temp=temp+730;//hackia
	for(int i=0;i<(int)back;i++)
	{
		temp[sqrs[i]]++;
	}
	if(len==0)
	{
		temp[sqrs[back]]++;
		return temp;
	}
	return	temp=no_fft(temp,den_kanw_diktia(len,mem));
}
uint* solver(list<int> digits,uint *mem[10])
{

	uint *temp= new uint[mvl]();
	temp=temp+730;//hackia
	if(digits.empty())return temp;
	uint back=digits.back();
	digits.pop_back();
	uint size= digits.size();
	temp=solver(digits,mem);
	temp-=sqrs[back];
	return sum(funky(size,back,mem),temp);
}
uint sum_a(uint * p,uint * mem)
{
	uint res=0;
	for(uint i=1;i<730;i++)
		res=(is_happy(i,mem))?*(p+i)+res:res;
	return res;
}

int main(int argc,char *argv[] )
{

	uint *memoization=new uint[1000]();
	uint A,B;
	FILE *in = fopen(argv[1],"r");
	fscanf(in,"%u %u",&A,&B);
	happy_range2(1,900,memoization);
	list<int> a= del(A);
	list<int> b=del(B);
	uint *mem[10];
	for (int i=0;i<10;i++)
		mem[i]=NULL;
	//reverse(a.begin(),a.end());
	printf("%u\n",sum_a(solver(b,mem),memoization)-sum_a(solver(a,mem),memoization)+is_happy(sum_digits(A),memoization));
	return 0;	
}
