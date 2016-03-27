#!/usr/bin/env python
import simple_markov_chain_lib as lib

if __name__ == "__main__":

  p = 1/6.0
# A dictionary for the initial distibution.
# Every state-key corresponds to an initial probability.
  init_probs = {
  '1':0.0,
  '2':0.0,
  '3':1.0
  }

# A dictionary for the transition probability  matrix.
# Every state-key corresponds to a list with tuples of (Next_State,Probability)
  markov_table = {
  '1':[('2',1.0)],
  '2':[('2',2/3.0),('3',1/3.0)],
  '3':[('1',p),('2',1-p)],
  }

# Ok... we are ready know
# Let's construct a Markov Chain. So let's call the constructor
  m = lib.markov_chain(init_probs,markov_table)

# Experiment parameters
  N = 100000
  steps = 20
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
  print "We executed", N," times the first", steps, "steps of the markov chain and we captured the running state in state '1' ", counter,"times"
  print "So we estimate the Pr[X_(%d) in 1|X_1 = 1] by" %(steps), float(counter)/N
