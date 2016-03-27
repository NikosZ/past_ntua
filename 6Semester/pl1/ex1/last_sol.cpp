#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <set>
#include <algorithm>
#include <iostream>
#include <math.h>
#define range(v) v.begin();v.end()
typedef unsigned int uint;
typedef std::vector<uint>::iterator iter;
using namespace std;
#define MAX_VAL 730
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
uint getdigit(int *n)
{
	int A=*n;
	uint temp=0;
	uint B=0;
	while(A){
		B++;
		temp=A%10;
		A/=10;
	}
	*n-=B*temp;
	return temp;
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
uint is_happy2(uint B,uint *memoization)
{
	uint res=0;
	for (uint i=0;i<10;i++)
		res=(memoization[B+i*i]==1)?(res+1):res;
	return res;
}
uint sqrs[]={0,1,4,9,16,25,36,49,64,81};
uint funky_fun(uint start,uint width,uint num,uint * mem)
{
	if (width==9)
		return 0;
	uint res=0;
	for (uint i=start;i<10;i++)
	{
		uint temp=num+sqrs[i];
		res+=is_happy(temp,mem)+funky_fun(0,width+1,temp,mem);
	}
	return res;
}
uint happy_range(uint A,uint B,uint * mem)
{
	uint sum=0;
	while(A%10 && A<B)
	{
		sum=(is_happy(sum_digits(A),mem))?(sum+1):sum;
		A++;
	}
	while(A+10<B)
	{
		sum+=is_happy2(sum_digits(A),mem);
		A+=10;
	}
	while(A<=B)
		{
		sum=(is_happy(sum_digits(A),mem))?(sum+1):sum;
		A++;
	}
	return sum;
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
inline void sum(uint *A,uint *B,uint *res)
{
	for(uint i=1;i<MAX_VAL;i++)
		*(res+i)=*(A+i)+*(B+i);
}

uint* no_fft(uint * A,uint * B)
{
	//cout<<"a";
	uint *res=new uint[MAX_VAL]();
	//res[0]=0;
	for(uint i=0;i<MAX_VAL;i++)
	{
		uint temp=0;
		for(uint j=0;j<=i;j++)
			temp+= A[j]*B[i-j];
		res[i]=temp;
		//cout<<res[i]<<endl;
	}
	return res;
}
uint* gothic (int  n,uint ** mem){
	uint *p = new uint[MAX_VAL]();
//	memset(p,0,MAX_VAL * sizeof(uint));
	if(n==0)
		return p;
	if(n==1){
		return mem[1];
	}
	//if(mem[n]!=NULL)
	//	return mem[n];
	//p=conv TODO::!!
	//p=no_fft(mem[1],mem[1]);
	sum(no_fft(gothic(ceil((1.0*n)/2),mem),gothic(n/2,mem)),p,p);
	for(int i=0;i<n/2-1;i++)
	{
		//cout<<i<<endl;
		//sum(gothic(n-i-1,mem),p,p);
	}
	mem[n]=p;
	return p;

}
uint* fucking_sol(int n,int max,uint ** mem)
{
	uint *p=new uint[MAX_VAL]();
	if(n==0)
		return p;
	if(max==1){
		return p;
	}
	uint last= getdigit(&n);
	for(int i=0;i<last;i++)
		sum(no_fft(gothic(4,mem+9),gothic(5,mem+9)),p,p);
	sum(fucking_sol(n,max,mem),p,p);
	return p;
}
uint sum_a(uint * p,uint * mem)
{
	uint res=0;
	for(uint i=1;i<MAX_VAL;i++)
		res=(is_happy(i,mem))?*(p+i)+res:res;
	return res;
}
int main()
{

    uint *memoization;
	memoization=(uint*)calloc(1000,sizeof(uint));
	uint A,B;
	scanf("%u %u",&A,&B);
	happy_range2(1,900,memoization);
	for(int i=0;i<900;i++)
		if(memoization[i]==1)
		cout<<i<<" ";
//	printf("%u\n",happy_range(A,B,memoization));
	//printf("%u\n",funky_fun(1,0,0,memoization));
	uint *mem[10];
//	memset(p,0,MAX_VAL * sizeof(uint));
	for(int j=1;j<10;j++){
	uint *p =new uint[MAX_VAL]();
	for(int i=0;i<10;i++){
	p[sqrs[i]]++;
	mem[j]=p;}}
	printf("%d\n",sum_a(gothic(9,mem),memoization));
	printf("%d\n",sum_a(fucking_sol(A,0,mem),memoization));
	cout<<"145674808"<<endl;;
//	cout<<ceil(1.0*8/2);
	//cout<<sum_a(no_fft(mem[1],mem[1]),memoization);
	return 0;	
}
