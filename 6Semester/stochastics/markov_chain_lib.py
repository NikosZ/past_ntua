#!/usr/bin/env python
import time as clock
import random as r
import numpy as n
import bisect as b2
import logging 
import sys
import os.path
from scipy.sparse import coo_matrix
from graph_tool.all import *
from gi.repository import Gtk, Gdk, GdkPixbuf, GObject
import time
#CHANGED

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
    self.Graph = MC_Graph(self)

  def start(self):
    self.Graph = MC_Graph(self)
    self.steps, choice, p = 0, r.uniform(0,1), 0
    for key in self.initial_distribution.keys():
      p += self.initial_distribution[key]
      if(choice <= p):
        self.running_state = key
        r_state = self.Graph.Graph.vertex(self.enum[self.running_state])
        self.Graph.Graph.vertex_properties['running_state'][r_state]=True
        self.Graph.Graph.vertex_properties['color'][r_state]=[0, 1, 0, 0.6]
        break
    self.probs_vector = [0 for i in xrange(self.size)]
    for s in self.enum:
      if s in self.initial_distribution.keys():
      	self.probs_vector[self.enum[s]] = self.initial_distribution[s]
    self.probs_vector=n.array(self.probs_vector)

  def move(self):
    r_state = self.Graph.Graph.vertex(self.enum[self.running_state])
    self.Graph.Graph.vertex_properties['running_state'][r_state]=False
    self.Graph.Graph.vertex_properties['color'][r_state]=[0, 0.8, 0.9, 0.9]

    self.running_state = self.states[self.running_state].next_state()

    r_state = self.Graph.Graph.vertex(self.enum[self.running_state])
    self.Graph.Graph.vertex_properties['running_state'][r_state]=True
    self.Graph.Graph.vertex_properties['color'][r_state]=[0, 1, 0, 0.6]


    self.probs_vector = self.probs_vector*self.adj_matrix
    self.steps += 1
    return self.steps,self.running_state

  def eigenvalues(self):

    return list(n.sort(n.linalg.eigvals(self.adj_matrix.toarray())))

  def states_distribution(self,rounding_level=3):
    return { self.invenum[i] : round(self.probs_vector[i],rounding_level) for i in xrange(self.size)}

  def communication_classes(self):
    cls,is_sink = self.Graph.strogly_connected_components() 
    ccs = {'Closed' : [],'Open' : []}
    for i in xrange(len(cls)):
      if is_sink[i]:
        ccs['Closed'].append(cls[i])
      else:
        ccs['Open'].append(cls[i])
    return ccs

  def run(self,turns,geometry=(640,640),display=True,save=False,weights=False,names=True,sleeping_time=0.05):
    d = self.Graph.run(turns,geometry,display,save,weights,names,sleeping_time)
    turns = d.keys()
    turns.sort()
    return [(t,d[t]) for t in turns]

  def show(self, geometry=(640,640), init_positions=False, save_positions=True, weights = False, names = True):
    self.Graph.general_draw(geometry, init_positions, save_positions, None, weights, names, "show")
  
  def save_draw(self, geometry=(640,640), directory=".", filename="mc_frame", choosen_format="pdf", weights = False, names = True, manually = False):
    fullname = normalname = directory+"/"+filename+''+"."+choosen_format
    if not manually:
      if normalname not in self.filename_counters.keys():
          self.filename_counters[normalname] = 0
      while(True):
        if not os.path.exists(fullname):
          break
        self.filename_counters[normalname] += 1
        fullname = directory+"/"+filename+str(self.filename_counters[normalname])+"."+choosen_format
    self.Graph.general_draw(geometry, False, False ,fullname, weights, names, "save_draw")    
  
class MC_Graph:
  
  def __init__(self,mc):
    self.Graph = Graph()
    self.mc = mc
    self.positions = None
    self.Graph.add_vertex(mc.size)
    self.Graph.vertex_properties['name'] = self.Graph.new_vertex_property('string')
    self.Graph.vertex_properties['no_name'] = self.Graph.new_vertex_property('string')
    self.Graph.vertex_properties['running_state'] = self.Graph.new_vertex_property("bool")
    self.Graph.vertex_properties['color'] = self.Graph.new_vertex_property("vector<double>")
    self.Graph.edge_properties['weight'] = self.Graph.new_edge_property('string')
    self.Graph.edge_properties['no_weight'] = self.Graph.new_edge_property('string')
    self.Graph.edge_properties['color'] = self.Graph.new_edge_property("vector<double>")
    
    for s in self.mc.enum:
      v = self.Graph.vertex(self.mc.enum[s])
      self.Graph.vertex_properties['name'][v]=str(s)
      self.Graph.vertex_properties['no_name'][v]=''
      self.Graph.vertex_properties['running_state'][v]=False
      self.Graph.vertex_properties['color'][v] = [0, 0.8, 0.9, 0.9]
      for neighbor in self.mc.states[s].Pr.keys():
        u = self.Graph.vertex(self.mc.enum[neighbor])
        e = self.Graph.add_edge(v,u)
        self.Graph.edge_properties['weight'][e] = str(round(self.mc.states[s].Pr[neighbor],3))
        self.Graph.edge_properties['no_weight'][e] = ''
        self.Graph.edge_properties['color'][e] = [0.6, 0.6, 0.6, 1]

  def strogly_connected_components(self):
    comp, hist, is_attractor = label_components(self.Graph,directed=True,attractors=True)
    num_classes = len(is_attractor)
    classes = {i:[] for i in xrange(num_classes)}
    for v in self.Graph.vertices():
      classes[comp[v]].append(self.Graph.vertex_properties['name'][v])
    return classes,is_attractor

  def general_draw(self, choosen_geometry, init_positions, save_positions ,filename, weights, names, command):
    if init_positions:
      self.positions = None
    g = self.Graph
    pos = (sfdp_layout(g) if (self.positions == None) else self.positions.copy())
    weights_table = (g.edge_properties['weight'] if weights else g.edge_properties['no_weight'])
    names_table = (g.vertex_properties['name'] if names else g.vertex_properties['no_name'])
    vcolor = g.vertex_properties['color']   
    ecolor = g.edge_properties['color']   

    if command == "save_draw":
      graph_draw(g, pos, 
         edge_color=ecolor,
         vertex_fill_color=vcolor,
         vertex_text=names_table,
         vertex_size = 20,
         edge_text=weights_table,
         geometry=choosen_geometry,
         output_size=choosen_geometry,
         output=filename
      )    
    elif command == "show":
      graph_draw(g, pos, 
         geometry=choosen_geometry,
         edge_color=ecolor,
         vertex_fill_color=vcolor,
         vertex_text=names_table,
         vertex_size = 20,
         vertex_halo=self.Graph.vertex_properties['running_state'],
         vertex_halo_color=[0, 1, 0, 0.6],
         edge_text=weights_table
      )
      if save_positions:
        self.positions = pos.copy()

  def run(self,turns,choosen_geometry,display,save,weights,names,sleeping_time):
    g = self.Graph
    pos = (sfdp_layout(g) if (self.positions == None) else self.positions)
    weights_table = (g.edge_properties['weight'] if weights else g.edge_properties['no_weight'])
    names_table = (g.vertex_properties['name'] if names else g.vertex_properties[' no_name'])
    vcolor = g.vertex_properties['color']   
    ecolor = g.edge_properties['color'] 
    if not display and not save:
      result = {}
      for i in xrange(turns):
        t,s = self.mc.move()
        result[t] = s
      return result
    elif display and not save:
      elem = BypassedInfos(GraphWindow(g, pos, 
         geometry=choosen_geometry,
         edge_color=ecolor,
         vertex_fill_color=vcolor,
         vertex_text=names_table,
         vertex_size = 20,
         vertex_halo=self.Graph.vertex_properties['running_state'],
         vertex_halo_color=[0, 1, 0, 0.6],
         edge_text=weights_table)
      ,turns,sleeping_time,time.time())
      def update_state():
#      	print "Turns:", elem.turns
#	print elem.stamp
        if elem.turns <= 0:
          return False
        else:
          elem.turns -= 1
          t,s = self.mc.move()
#	  print "Elected State:",t,s
          elem.result[t] = s
        elem.win.graph.regenerate_surface()
        elem.win.graph.queue_draw()
        clock.sleep(elem.sleeping_time)
#	print "End Phase"
        return True
      GObject.idle_add(update_state)
      elem.win.connect("delete_event", Gtk.main_quit)
      #elem.win.connect("motion_notify_event",update_state)
      elem.win.show_all()
      Gtk.main()
      elem.turns = 0
      return elem.result

class BypassedInfos:
  def __init__(self,win,turns,sleeping_time,nowtime):
    self.win = win
    self.turns = turns
    self.sleeping_time = sleeping_time
    self.result = {}
    self.stamp = nowtime
