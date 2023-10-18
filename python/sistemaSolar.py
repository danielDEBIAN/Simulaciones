import numpy as np
import matplotlib.pyplot as plt

T = 1 * 86400  # increment in time, 1 day = 86400 seconds
G = 6.67E-11  # m^3/s^2/Kg, gravity constant
N = 6  # number of particles: Sun, Mercury, Venus, Earth, Mars, Jupiter
M = np.array([333000, 0.0558, 0.815, 1, 0.07, 310]) * 5.98E24  # masses of the celestial bodies
R = np.array([[0, 0], [57.9E9, 0], [108E9, 0], [150E9, 0], [228E9, 0], [778E9, 0]])  # initial positions
Rf = R.copy()  # auxiliary
V = np.array([[0, 0], [0, 47.9E3], [0, 35E3], [0, 29.8E3], [0, 24.1E3], [0, 13.1E3]])  # initial velocities (tangential)

while True:
    for i in range(N):
        A = np.array([0, 0])  # initialize acceleration
        for j in range(N):
            if i != j:
                r = R[i] - R[j]
                r2 = np.linalg.norm(r)
                # A += -G * M[j] * r / (r2 ** 3)  # acceleration due to gravity
                np.add(A,(-G * M[j] * r / (r2 ** 3)),out=A,casting="unsafe")
        V[i] += A * T
        Rf[i] = R[i] + V[i] * T
    R = Rf.copy()
    plt.plot(R[:N, 0], R[:N, 1], '.b')
    plt.axis([-1E12, 1E12, -1E12, 1E12])
    plt.pause(0.1)

plt.show()