import random,numpy,math

def random_walk_next(state):
  if random.uniform(0,1) < 0.5:
    return 0
  else:
    return state+1

def f(x):
  return x

x = list()
N = 100* (10**6)
running_state = 0
sum_result = 0
for j in xrange(50):
    running_state =0
    sum_result =0
    for i in xrange(N):
### APPLY f(x) to X
        running_state = random_walk_next(running_state)
        sum_result += f(running_state)
    x.append((float(sum_result/N) -1)**2)

### Ergodic Limit Theorem
#print "The simulated ergodic average [X1+X2+X3+...+XN]/N is ", float(sum_result)/N
print "Variance is " , float((sum (x))/49 )
