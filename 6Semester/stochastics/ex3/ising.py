import random, math, pylab

L = 64
N = L*L
neighbors = {i : ((i // L) * L + (i + 1) % L, 	# RIGHT
		 (i + L) % N,			# DOWN
		 (i // L) * L + (i - 1) % L, 	# LEFT
		 (i - L) % N) 			# UP
      		for i in range(N)}

Temperature = 0.03
#Spin = [random.choice([1, -1]) for k in range(N)]
Spin = [random.choice([1,-1]) for k in range(N)]
spin_table = [[None for x in range(L)] for y in range(L)]

nsteps = N * 150
for step in range(nsteps):
  k = random.randint(0, N - 1)
  delta_E = 2.0 * Spin[k] * sum(Spin[n] for n in neighbors[k])
  if random.uniform(0.0, 1.0) < math.exp(-delta_E/Temperature): Spin[k] *= -1
  
for k in range(N):
  y = k // L
  x=  k % L
  spin_table[x][y] = Spin[k]

pylab.close()
pylab.imshow(spin_table,extent=[0,L,0,L],interpolation='nearest')
pylab.title("Temperature: "+str(Temperature)+", Grid Size: "+str(L))
pylab.show()
