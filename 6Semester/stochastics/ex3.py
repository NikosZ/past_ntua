#!/usr/bin/env python
import simple_markov_chain_lib as lib
import math
if __name__ == "__main__":

  p = 1/6.0
# A dictionary for the initial distibution.
# Every state-key corresponds to an initial probability.
  init_probs = {
  '1':1.0,
  '2':0.0
  }

# A dictionary for the transition probability  matrix.
# Every state-key corresponds to a list with tuples of (Next_State,Probability)
  markov_table = {
  '1':[('1',1/11.0),('2',10/11.0)],
  '2':[('1',10/11.0),('2',1/11.0)]
  }

# Ok... we are ready know
# Let's construct a Markov Chain. So let's call the constructor
  m = lib.markov_chain(init_probs,markov_table)

# Experiment parameters
  N = 100000
  steps = int(raw_input())
  counter = 0
  for i in xrange(N):
# Let's initiate the running state for t=0.
# We must do this every time we want to restart the Chain
    m.start()
# Let the markov chain move by 20 steps
    for j in xrange(steps):
      m.move()
# and check if we end up in one of the goal_states
    if m.running_state == '1':
      counter += 1
  print "So we estimate the Pr[X_(%d) in 1|X_1 = 1] by" %(steps),float(counter)/N
  print "The Pr that we had calculated was %f"  %(1/2.0 +(1/2.0) * math.pow((-9/11.0),steps) )
