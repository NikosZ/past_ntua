#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <set>
#include <algorithm>
#define range(v) v.begin();v.end()
typedef unsigned int uint;
typedef std::vector<uint>::iterator iter;
using namespace std;
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
int main()
{

    uint *memoization;
	memoization=(uint*)calloc(1000,sizeof(uint));
	uint A,B;
	//scanf("%u %u",&A,&B);
	happy_range2(1,900,memoization);
//	printf("%u\n",happy_range(A,B,memoization));
	printf("%u\n",funky_fun(1,0,0,memoization));
	return 0;	
}
