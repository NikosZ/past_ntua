#!/usr/bin/env python
import simple_markov_chain_lib as lib
import math
def game(m):
    points1=0
    points2=0
    for i in xrange(10):
        m.move()
        if(m.running_state =='1'):
            points1 +=1
        else:
            points2 +=1
        if points1 == 3 and points2 == 3:
            return 0
        elif points1 <3 and points2 ==4:
            return -1
        elif points1==4 and points2<3:
            return 1
def tie(m):
    while m.running_state <>'3'and m.running_state <> '4':
        m.move()
    if m.running_state =='3':
        return 1
    else:
        return -1
if __name__ == "__main__":

    p = 3/5.0
# A dictionary for the initial distibution.
# Every state-key corresponds to an initial probability.
    init_probs = {'0':1.0,'1':0.0,'2':0.0,'3':0.0,'4':0.0}

  # A dictionary for the transition probability  matrix.
# Every state-key corresponds to a list with tuples of (Next_State,Probability)
    markov_game = {
          '0':[('1',p),('2',1-p)],
          '1':[('1',p),('2',1-p)],
          '2':[('1',p),('2',1-p)]
          }
    markov_tie = {
          '0':[('1',p),('2',1-p)],
          '1':[('3',p),('0',1-p)],
          '2':[('0',p),('4',1-p)],
          '3':[('3',1)],
          '4':[('4',1)]
          }

  # Ok... we are ready know
# Let's construct a Markov Chain. So let's call the constructor
# Experiment parameters
    N = 100000
    counter = 0
    for i in xrange(N):
        m1 = lib.markov_chain(init_probs,markov_game)
        m1.start()
        res = game(m1)
        if res==0:
            m2 = lib.markov_chain(init_probs,markov_tie)
            m2.start()
            res = tie(m2)
        if res==1:
            counter +=1
# and check if we end up in one of the goal_states
    print "So we estimate the Pr to win  by" ,float(counter)/N
