#!/usr/bin/env python
import simple_markov_chain_lib as lib
if __name__ == "__main__":

# initialize the markov chain process
  init_probs = {
  '1':1/3.0,
  '2':1/3.0,
  '4':1/3.0,
  '5':0.0
  } 
# Give a dictionary of State:Probability. For the initial_probability
  markov_table = {
  '1':[('2',1/2.0),('3',1/2.0)],
  '2':[('1',1/3.0),('4',2/3.0)],
  '3':[('3',1.0)],
  '4':[('4',1/2.0),('1',1/2.0)],
  '5':[('5',1.0)]
  }
# A dictionary for the transition matrix. Every key coresponds to a list with tuples of (Next_State,Probability) 

  m = lib.markov_chain(init_probs,markov_table)

  m.start()
  for i in xrange(10):
    print "State after", m.steps,"moves is", m.running_state
    m.move()
