import math, random, numpy
import matplotlib.pyplot as plt
plt.ion()

minima = 3
gamma = 0.5
iterations = 1
n_plus = 0
delta = 0.1
animation = True

solution = {1:(0.6,1.4),2:(3.4,3.8),3:(-4.9,-4.5),4:(0,6,1,4)}
def V(x_value):
   x = [1]
   if minima==4:
     for i in xrange()
   if minima==3:
     for i in xrange(1,11): x.append(x_value*x[-1])
     v = 0.0000476742*x[10]-0.000332066*x[9]-0.00217427*x[8]+0.0175017*x[7]+0.0234317*x[6]
     v = v +-0.300376*x[5]+0.111949*x[4]+1.95424*x[3]-1.63325*x[2]-2.67103*x[1]+2.5
   elif minima==2:
     for i in xrange(1,5): x.append(x_value*x[-1])
     v = (13* x[4])/90.0-(3* x[3])/10.0-(101* x[2])/45.0+(13* x[1])/15.0+4
   elif minima==1:
     for i in xrange(1,3): x.append(x_value*x[-1])
     v = x[2]-2*x[1]-5
   return v

for _ in xrange(iterations):
  T = 128.0
  x = random.uniform(-3.5,3.5)
  step = 0

  ### ANIMATION ###
  if animation:
    image_p = {1:(-5,6),2:(-4,5),3:(-5,4)}
    text_p = {1:(0,5),2:(-3.5,-5),3:(-3.5,8)}
    x_array = list(numpy.linspace(image_p[minima][0],image_p[minima][1],1000))
    y_array = map(V,x_array)
    plt.plot(x_array,y_array,'r')
    point_x, = plt.plot([x],[V(x)],color='g',marker='o', linestyle='None')
    text_temp = plt.text(text_p[minima][0],text_p[minima][1],"Temperature=%0.3f"%(T))
    text_x = plt.text(text_p[minima][0],text_p[minima][1]-2,"x=%0.3f"%(x))
    plt.axvline()
    plt.axhline()


  ### SIMULATED ANNEALING ###
  while T > 0.01:
    step += 1

    ### EVERY 100 STEPS DROP TEMPERATURE DOWN
    if step == 100:
      T *= (1.0 - gamma)
      if animation: text_temp.set_text("Temperature=%0.3f"%(T))
      step = 0
     

    ### CANDIDATE NEW STATE
    x_new = x + random.uniform(-delta, delta)
    
    if random.uniform(0.0, 1.0) < math.exp(- (V(x_new) - V(x)) / T):
      x = x_new

    if animation:
      point_x.set_data([x],[V(x)])
      text_x.set_text("x=%0.3f"%(x))
      plt.pause(0.000001)


  ### SUCCESS ###
  if x > solution[minima][0] and x < solution[minima][1]: n_plus += 1
  plt.close()

print "Cooling Factor: ", gamma
print "Success Rate: ", 100*n_plus / float(iterations) , "%"
