
#include <iostream>
#include <vector>
#include <set>
#define pb(l) push_back(l)
#define all(x) begin(x),end(x)

using namespace std;

vector<double> digitalize (int n)
{
	vector<double> ret;
	ret.reserve(10);
	while(n>0)
	{
		ret.pb(n%10);
		n/=10;
	}
	return ret;
}
int main()
{
	auto x=10;
	cout<<x;
	return 0;
}
