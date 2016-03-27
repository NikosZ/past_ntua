"""
Simulated annealing plot moduler 
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

import matplotlib.pyplot as plt
import math

def plot_cities(cities, figure_id, title):
    """Plot the cities on a plan."""
    scale_factor = 100
    fig_map = plt.figure(figure_id)
    ax_map = fig_map.add_subplot(111)

    cities_y = [longitude*scale_factor for longitude,_,_ in cities + [cities[0]]]
    cities_x = [latitude*scale_factor for _,latitude,_ in cities + [cities[0]]]

    ax_map.plot(cities_x, cities_y, 'go-')
    ax_map.grid()

    spacing = math.fabs(min(cities_x) - max(cities_x)) * .1
    ax_map.set_xlim(min(cities_x) - spacing, max(cities_x) + spacing * 3)
    ax_map.set_ylim(min(cities_y) - spacing, max(cities_y) + spacing)
    
    if len(cities)<=30:
	    for index,city in enumerate(cities):
		    ax_map.text(
                    city[1]*scale_factor,
		    city[0]*scale_factor,
                    '%d: %s' % (index + 1, city[2]),
                    withdash = True,
                    dashdirection = 1,
                    dashlength = 30,
                    rotation = 0,
                    dashrotation = 15,
                    dashpush = 10)
    ax_map.set_title(title)
    return ax_map

def plot_distances(distances_current, figure_id, distances_best,  n_cities, cooling_factor, temperature_start, temperature_end):
    """Plot the evolution of the distance metrics."""
    # plot distances
    fig_distances = plt.figure(figure_id)
    ax_distances = fig_distances.add_subplot(111)
    line_current = ax_distances.plot(distances_current, linewidth=1)
    line_best = ax_distances.plot(distances_best, 'r', linewidth=2)
    title = 'Simulated annealing for %d cities\n' % n_cities
    title += 'c_factor: %.4f, t_start: %g, t_end: %.4f' % (cooling_factor, temperature_start, temperature_end)
    ax_distances.set_title(title)

    # plot iteration steps
    y_min = min(distances_current)
    y_max = max(distances_current)
    ax_distances.set_xlabel('Steps')
    ax_distances.set_ylabel('Distance (km)')
   
