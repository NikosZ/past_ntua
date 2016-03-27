# IMPORT numpy FOR EASY MATHEMATICAL CALCULATIONS
import numpy as np
# IMPORT matplotlib.pyplot FOR PLOTS
import matplotlib.pyplot as plt
# Create a list of real numbers from start to end by step
start = 0.01
end = 6
step = 0.01
x = np.arange(start,end,step)

# Define a list named y, containing the cubes of the elements in x. len(x) returns the length of x
y = []
for i in xrange(len(x)):
  t = 32*pow(x[i],3)
  y.append(t)
  # the command y.append(t) appends the element t at the end of the list y

# Let's plot (x,y)
plt.figure(1)
plt.plot(x,y)
# Label the x-axis
plt.xlabel('x')
# Label the y-axis
plt.ylabel('32*x^3')
# Give a title to the plot 
plt.title('This is my first python plot')
plt.draw()

# Let's now create a handmade log-log plot
newx = np.log2(x)
newy = np.log2(y)

plt.figure(2)
plt.plot(newx,newy)
plt.xlabel('logx')
plt.ylabel('log(32*x^3)')
plt.title('This is a simple log log plot')
plt.draw()

plt.show(block = False)
a,b = np.polyfit(newx,newy,1)
print "The fitted line is y=(%.2f)*x+(%.2f) " % (a,b)
