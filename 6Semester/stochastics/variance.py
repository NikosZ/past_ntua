import markov_chain_lib as lib
import math as math
import matplotlib.pyplot as plt
import numpy as np
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
  y_axes2= list()
  y_axes1 = list()
  x_axes = list()
# Let's construct a Markov Chain. So let's call the constructor
  m = lib.markov_chain(init_probs,markov_table)
    # In the nested j-loop we estimate E_1[T_1^+] by simulating the chain N times, computing the time until the first return each time, and averaging
    # We will store our N samples of T_1^+ in a list called simulations, initially empty
  M=30
  for i in range(6,12):
      N=2**i

      mcestimates = list()
      for k in xrange(M):
         simulations = []
         for j in xrange(N):
            m.start()
            m.move()
            while( not m.running_state == '1' ):
                m.move()
     # The following command appends the sample t_j at the end of the list simulations   
            simulations.append(m.steps)
           # print "The chain returns at state '1'After %3d steps" % m.steps
         MCestimate = float( sum(simulations) ) / N
         mcestimates.append(MCestimate)
      #      print "In this experiment with %5d iterations, our Monte Carlo estimator of the mean duration of an excursion around state '1' is %.3lf" % (N,MCestimate)
      sample_mean = float( sum(mcestimates) ) / M
## Create a list with the distance of each estimated mean from the sample mean.
## Note how easy it is with the 'for e in simulations'
      squared_distance_from_mean = [ (e - sample_mean)**2 for e in mcestimates ]
      sample_variance = float(sum ( squared_distance_from_mean  )) / (M-1)
      sample_sd = math.sqrt(sample_variance)
      print "for N= %d sample mean: %3lf and sample variance:%3lf" %(N,sample_mean,sample_variance)
      y_axes1.append(sample_mean)
      y_axes2.append(sample_sd)
      x_axes.append(N)
  newx=np.log2(x_axes)
  newy1=np.log2(y_axes1)
  newy2=np.log2(y_axes2)
  plt.figure(1)
  plt.plot(newx,newy1)
  plt.ylabel("mean")
  plt.figure(2)
  plt.plot(newx,newy2)
  plt.ylabel("sd")
  plt.draw()
  plt.show(block =False)
  a,b = np.polyfit(newx,newy2,1)
  print "The fitted line is y=(%.2f)*x+(%.2f) " % (a,b)


