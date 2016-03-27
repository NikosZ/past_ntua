"""
Simulated annealing applied to the metric traveling salesman problem.

The data needs to be in cvs format and the coordinates of the cities are
longitude and latitude. Thus, any gps data taken on the internet can
serve as input.

Once the annealing is done, the cities are plotted according to their
coordinates using the matplotlib package. The cities are then linked as to
show the order of visit in the final solution. Also, the evolution of the
tested and shortest distances is plotted.
"""

__docformat__ = "restructuredtext en" 

## Copyright (c) 2015 Emmanuel Vlatakis
##
## This file is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This file is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this file.  If not, see <http://www.gnu.org/licenses/>.

import csv
import math,random
import plot_lib
import matplotlib.pyplot as plt

def geodesic_distance(city_a, city_b):
  """
  Geodesic Distance of city_a,city_b 
  """
  a_latitude, a_longitude, a_name = city_a
  b_latitude, b_longitude, b_name = city_b
  radius_earth = 6378.7 # in kilometers
  if not city_a.index == city_b.index:
    lat = math.radians(a_latitude - b_latitude)
    lon = math.radians(a_longitude - b_longitude)
    a = math.pow(math.sin(lat/2), 2) \
    + math.cos(math.radians(a_latitude)) * math.cos(math.radians(b_latitude)) * pow(math.sin(lon/2), 2)
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
  else:
    c = 0
  return radius_earth * c

def euclidean_distance(city_a,city_b):
  """
  Euclidean Distance of city_a,city_b 
  """
  a_x, a_y, a_name = city_a
  b_x, b_y, b_name = city_b
  return math.sqrt((a_x-b_x)**2+(a_y-b_y)**2)

def compute_distance_matrix(cities):
  """
  Compute the Distance Matrix
  """
  dist_matrix = { city:{} for city in cities }
  for city_a in cities:
    for city_b in cities:
      dist_matrix[city_a][city_b] = geodesic_distance(city_a, city_b)
  return dist_matrix

def compute_total_distance(cities,dist_matrix):
  """
  Compute the total distance given a permutation of cities
  """
  result = 0
  for i in xrange(len(cities)):
    result += dist_matrix[cities[i-1]][cities[i]]
  return result

def read_cities(filename):
    """
    Read city data from a csv file.
    """
    reader = csv.reader(open(filename, "rb")) # may raise IOError
    cities = [(float(line[0]),float(line[1]),line[2]) for line in reader]
    return cities[1:]


	#########################################
	#					#
	#             Main Function             #
	#          Simulated Annealing          #
	#					#
	#########################################

if __name__ == '__main__':
  
  # READ CONFIGS
  filename = "eu.csv"
  cities = read_cities(filename)

  n_cities = len(cities)
  stage_steps = 100
  cooling_factor = 0.95
  temperature_begin = 10**7 
  temperature_end = 0.02
  random_seed = -1
  
  # If you want to repeat Simulated Annealing Process with the same random choices,
  # CHANGE random_seed to a specific number for example 5.
  # Whenever you run the script with the same random_seed the result will be the same
  # Leave random_seed = -1 to keep full randomization

  if random_seed == -1:
      random.seed() 
  else:
      random.seed(random_seed)

  
  # COMPUTE DISTANCE MATRIX
  dist_matrix = compute_distance_matrix(cities)

  # COMPUTE INITIAL TOTAL DISTANCE, PLOT INITIAL TOUR
  distance_begin = compute_total_distance(cities,dist_matrix)
  plot_lib.plot_cities(cities, 1, 'Initial tour\nDistance=%0.0f km'%distance_begin)
	


	#########################################
	#					#
	#       Simulated Annealing Code        #
	#	BEGIN				#
	#					#
	#########################################


  cities_best = cities[:]
  current_distances, best_distances= [], []
  distance_end, distance_current = distance_begin, distance_begin
  temperature = temperature_begin
  steps = 0

  while temperature_end < temperature:
    index = random.sample(range(1,len(cities)),2)
    min_index,max_index = min(index),max(index)
    min_index_prev,min_index_next = (min_index-1)%n_cities,(min_index+1)%n_cities
    max_index_prev,max_index_next = (max_index-1)%n_cities,(max_index+1)%n_cities
   
    distance_new = distance_current - dist_matrix[cities[min_index]][cities[min_index_next]] \
     				      - dist_matrix[cities[min_index_prev]][cities[min_index]] \
     				      - dist_matrix[cities[max_index]][cities[max_index_next]] \
     				      - dist_matrix[cities[max_index_prev]][cities[max_index]] \
     				      + dist_matrix[cities[min_index_prev]][cities[max_index]] \
     				      + dist_matrix[cities[max_index]][cities[min_index_next]] \
     				      + dist_matrix[cities[max_index_prev]][cities[min_index]] \
     				      + dist_matrix[cities[min_index]][cities[max_index_next]]
    if max_index_prev == min_index:
      distance_new += 2*dist_matrix[cities[min_index]][cities[max_index]]
                                                                                                
    diff = distance_new - distance_current
    if math.exp(-diff / temperature ) > random.uniform(0,1):
       cities[min_index], cities[max_index] = cities[max_index], cities[min_index]
       distance_current = distance_new
                                                                                                
    steps += 1
    if distance_current < distance_end :
      distance_end = distance_current
      cities_best = cities[:]
   
    current_distances.append(distance_current)
    best_distances.append(distance_end)

    if steps % stage_steps == 0:
      temperature = temperature * cooling_factor



	#########################################
	#					#
	#       Simulated Annealing Code        #
	#	END				#
	#					#
	#########################################




  # PLOT FINAL TOUR
  plot_lib.plot_cities(cities_best, 2, 'Optimal tour\nDistance=%.0f km'%distance_end)

  print 'Random Seed:                %d'  % random_seed
  print 'Improvement:          %8.0f %%'  % (100 * (distance_begin - distance_end) / distance_begin)
  print 'Initial distance:     %8.0f km'  % distance_begin
  print 'Optimal distance:     %8.0f km'  % distance_end

  # PLOT EVOLUTION OF OBJECTIVE FUNCTION
  plot_lib.plot_distances(current_distances, 3, best_distances, n_cities, cooling_factor, temperature_begin, temperature_end)
  plt.show()
