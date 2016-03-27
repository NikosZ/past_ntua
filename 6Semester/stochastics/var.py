import markov_chain_lib as lib
import math as math

if __name__ == "__main__":

# Let's initialize the markov chain process
  init_probs = {
  '1':1.0
  } 

  markov_table = {
  '1':[('2',1/2.0),('3',1/2.0)],
  '2':[('3',1/3.0),('4',2/3.0)],
  '3':[('3',0.8),('5',0.2)],
  '4':[('4',1/2.0),('5',1/2.0)],
  '5':[('1',0.2),('5',0.8)]
  }

# Let's construct a Markov Chain. So let's call the constructor
  m = lib.markov_chain(init_probs,markov_table)

  N = 2**5
    # In the nested j-loop we estimate E_1[T_1^+] by simulating the chain N times, computing the time until the first return each time, and averaging
    # We will store our N samples of T_1^+ in a list called simulations, initially empty
  simulations = []
  for j in xrange(N):
     m.start()
     m.move()
     while( not m.running_state == '1' ):
        m.move()
     # The following command appends the sample t_j at the end of the list simulations   
     simulations.append(m.steps)
     print "The chain returns at state '1'After %3d steps" % m.steps
  MCestimate = float( sum(simulations) ) / N
  print "In this experiment with %5d iterations, our Monte Carlo estimator of the mean duration of an excursion around state '1' is %.3lf" % (N,MCestimate)
  
#  sample_mean = float( sum(mcestimates) ) / M
## Create a list with the distance of each estimated mean from the sample mean.
## Note how easy it is with the 'for e in simulations'
#  squared_distance_from_mean = [ (e - sample_mean)**2 for e in mcestimates ]
#  sample_variance = float(sum ( squared_distance_from_mean  )) / (M-1)
#  sample_sd = math.sqrt(sample_variance)
