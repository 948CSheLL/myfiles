from numpy import *
import math
import matplotlib.pyplot as plt
from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D

m_= zeros(3,dtype=float)
m = zeros(3,dtype=float)
T = zeros([3,3],dtype=float)
B = zeros(3, dtype=float)

def form_m(pitch,yaw):
    pitch = pitch*pi/180
    yaw = yaw*pi/180
    m_[0]= math.cos(pitch)*math.cos(yaw)
    m_[1]= math.cos(pitch)*math.sin(yaw)
    m_[2]= math.sin(pitch)

def calT(x,y,z):
    r = math.sqrt(x*x+y*y+z*z)
    r5=1/r**5
    r3=1/r**3
    T[0][0]=3*x*x*r5-r3
    T[0][1]=3*x*y*r5
    T[0][2]=3*x*z*r5
    T[1][0]=T[0][1]
    T[1][1]=3*y*y*r5-r3
    T[1][2]=3*y*z*r5
    T[2][0]=T[0][2]
    T[2][1]=T[1][2]
    T[2][2]=3*z*z*r5-r3

def calB():
    B_ = dot(m,T)
    return B_

def calBt(x,y,z):
    calT(x,y,z)
    B = calB()
    bt=B[0]*m_[0]+B[1]*m_[1]+B[2]+m_[2]
    return bt

mb = input('enter mb: ')
yaw = input("enter yaw:")
pitch = input("enter pitch: ")
form_m(float(pitch),float(yaw))
m = float(mb)*m_

X = arange(-5,5,0.25,dtype=float)
Y = arange(-5,5,0.25,dtype=float)
X, Y = meshgrid(X, Y)
#z = arange(-5,5,0.25,dtype=float)
'''Bt=[]
for x in X:
    for y in Y:
        Bt.append(calBt(x,y,5))'''

fig = plt.figure()
ax = Axes3D(fig)
ax.plot_surface(X, Y, Z, rstride=1, cstride=1, cmap=cm.viridis)

plt.show()




