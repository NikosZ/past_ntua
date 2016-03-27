import random as r
import bisect as b
class interval:
    def __init__(self,T):
        self.ls =[0 for i in xrange(len(T))]
        for i in xrange(1,len(T)):
            self.ls[i]=sum(T[:i])
        self.ls.append(1.0)
    def find(self,num):
        i=b.bisect_left(self.ls,num)
        return i-1
def myread(a):
    a=a.split('/')
    if len(a)==1:
        return float(a[0])
    else:
        return float(a[0]) / float(a[1])
class mygen:
    def __init__(self,array,start):
        self.matrix = array
        self.num_moves=0
        temp_interval=interval(start)
        self.pos=temp_interval.find(r.uniform(0,1))
        self.intervals = []
        for i in array:
            temp_int=interval(i)
            self.intervals.append(temp_int)
    def next_move(self):
        self.pos=self.intervals[self.pos].find(r.uniform(0,1))
        self.num_moves=self.num_moves+1
    def print_method(self):
        print 'I am at the state %d'%(self.pos)
        print 'Press n for next move or e to exit'
ls=[]
n=int(raw_input('Insert number of states\n'))
for i in xrange(n):
    print 'Insert the %d line of the matrix'%(i)
    temp=raw_input().split(' ')
    ls.append(list(map(myread,temp)))
start=map(myread,raw_input('Insert the start vector\n').split(' '))
markov =mygen(ls,start)
markov.print_method()
d=raw_input()
while d=='n':
    markov.next_move()
    markov.print_method()
    d=raw_input()
print 'Bye Bye'
