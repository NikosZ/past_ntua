#!/usr/bin/env python
import random as r
import numpy as n
import bisect as b2
import time as clock
 
from scipy.sparse import coo_matrix
 
import sys
import os.path
import logging 
 
 
 
 
class state:
 
  def __init__(self,distribution,name):
    self.Pr = { d[0]:d[1] for d in distribution if d[1]>0}
    self.choice_intervals = n.cumsum([self.Pr[key] for key in self.Pr])
    self.name = name
 
  def next_state(self):
    coin = r.uniform(0,1)
    return self.Pr.keys()[b2.bisect_left(self.choice_intervals,coin)]
 
 
class markov_chain:
 
  def __init__(self,initial_distribution,markov_table):
    logging.captureWarnings(True)
    self.size , self.running_state , self.steps = len(markov_table) , None, 0
    self.states, self.filename_counters = { d : state(markov_table[d],d) for d in markov_table }, {}
    self.initial_distribution = initial_distribution
    self.enum = dict(zip(markov_table.keys(),list(xrange(self.size))))
    self.invenum = dict(zip(list(xrange(self.size)),markov_table.keys()))
    data, i, j = [],[],[]
    for s in markov_table:
      for t,w in markov_table[s]:
        if w>0:
          i.append(self.enum[s])
          j.append(self.enum[t])
          data.append(w)
    self.adj_matrix = coo_matrix((data,(i,j)),shape=(self.size,self.size))
 
 
  def start(self):
    self.steps, choice, p = 0, r.uniform(0,1), 0
    for key in self.initial_distribution.keys():
      p += self.initial_distribution[key]
      if(choice <= p):
        self.running_state = key
        break
    self.probs_vector = [0 for i in xrange(self.size)]
    for s in self.enum:
      if s in self.initial_distribution.keys():
        self.probs_vector[self.enum[s]] = self.initial_distribution[s]
    self.probs_vector = n.array(self.probs_vector)
     
  def move(self):
    self.running_state = self.states[self.running_state].next_state()
    self.probs_vector = self.probs_vector*self.adj_matrix
    self.steps += 1
    return self.steps,self.running_state
 
  def eigenvalues(self):
    return list(n.sort(n.linalg.eigvals(self.adj_matrix.toarray())))
 
  def states_distribution(self,rounding_level=3):
    return { self.invenum[i] : round(self.probs_vector[i],rounding_level) for i in xrange(self.size)}
