# -*- coding: utf-8 -*-
"""
Created on Tue Jul  3 20:16:28 2018

@author: boston
"""

from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np
import MagLoops as ML

loop=ML.Loops(20,0.5,1,1000)

xmin, xmax, ymin, ymax, z = -5., 5., -5., 5., 0. # 空间边界,观察平面
profile_x = 0. # 
profile_y = 0. # 
h = 0.2 # 格点间隔
radii = (2., 5.)

def mo(a,b,c=0):
    mo=np.sqrt(a**2+b**2+c**2)
    return mo

# get map
xi, yi = np.meshgrid(np.r_[xmin:xmax+h:h], np.r_[ymin:ymax+h:h])
x1, y1 = xi.flatten(), yi.flatten()
z1 = np.full(x1.shape,z)
#Hx_real,Hy_real,Hz_real = np.zeros(len(x2)), np.zeros(len(x2)),np.zeros(len(x2))
#Hx_imag,Hy_imag,Hz_imag = np.zeros(len(x2)), np.zeros(len(x2)),np.zeros(len(x2))
H = np.zeros(len(x1),dtype=complex)
Ba1=np.zeros(len(x1))
for i in np.arange(len(x1)):
    H[i] = loop.AllField(x1[i], y1[i], z1[i])
    Ba1[i] = abs(H[i])
    #Hx_real[i],Hy_real[i],Hz_real[i],Hx_imag[i],Hy_imag[i],Hz_imag[i] = loop.delta(x1[i],y1[i],z1[i])
    #Ba1[i]=mo(mo(Hx_real[i],Hx_imag[i]),mo(Hy_real[i],Hy_imag[i]),mo(Hz_real[i],Hz_imag[i]))
#Ba1 = np.dot(np.r_[1,1,1], np.vstack((Hx_real,Hy_real,Hz_real)))

    

# get x-profile
x2 = np.r_[xmin:xmax+h:h]
y2, z2 = np.full(x2.shape,profile_y), np.full(x2.shape,z)
H = np.zeros(len(x2),dtype=complex)
Ba2=np.zeros(len(x2))
for i in np.arange(len(x2)):
    H[i] = loop.AllField(x2[i], y2[i], z2[i])
    Ba2[i] = abs(H[i])
    #Hx_real[i],Hy_real[i],Hz_real[i],Hx_imag[i],Hy_imag[i],Hz_imag[i] = loop.delta(x2[i],y2[i],z2[i])
#Ba2=np.dot(np.r_[0,0,1], np.vstack((Hx_real,Hy_real,Hz_real)))

# get y-profile
y3 = np.r_[ymin:ymax+h:h]
x3, z3 = np.full(y3.shape,profile_x), np.full(y3.shape,z)
H= np.zeros(len(x3),dtype=complex)
Ba3=np.zeros(len(x3))
for i in np.arange(len(x3)):
    H[i] = loop.AllField(x3[i], y3[i], z3[i])
    Ba3[i] = abs(H[i])
    #Hx_real[i],Hy_real[i],Hz_real[i],Hx_imag[i],Hy_imag[i],Hz_imag[i] = loop.delta(x3[i],y3[i],z3[i])
#Ba3=np.dot(np.r_[0,0,1], np.vstack((Hx_real,Hy_real,Hz_real)))
    
fig = plt.figure()
ax = fig.gca(projection='3d')

# plot map
ax.scatter(x1,y1,z1,s=2,alpha=0.3)
Bt = Ba1.reshape(xi.shape)*1e9 # contour and color scale in nT 
c = ax.contourf(xi,yi,Bt,alpha=1,zdir='z',offset=z-max(radii)*2,cmap='jet',
                  levels=np.linspace(Bt.min(),Bt.max(),50,endpoint=True))
fig.colorbar(c)

# auto-scaling for profile plot
ptpmax = np.max((Ba2.ptp(),Ba3.ptp())) # dynamic range
autoscaling = np.max(radii) / ptpmax

# plot x-profile
ax.scatter(x2,y2,z2,s=2,c='black',alpha=0.3)
ax.plot(x2,Ba2*autoscaling,zs=ymax,c='black',zdir='y')

# plot y-profile
ax.scatter(x3,y3,z3,s=2,c='black',alpha=0.3)
ax.plot(y3,Ba3*autoscaling,zs=xmin,c='black',zdir='x')

ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

ax.set_xlim(xmin, xmax)
ax.set_ylim(ymin, ymax)
ax.set_zlim(z-max(radii)*2, max(radii)*1.5)

plt.show()
    
    
