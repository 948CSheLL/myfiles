# -*- coding: utf-8 -*-
"""
Created on Wens Jul  4 20:16:28 2018

@author: boston
"""

from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np
import MagDipole as md
import MagLoops as ml
import Moment as mm

'''
图形界面输入自定义数据：
define 
线圈：电流：20   半径：0.25    位置：(0,0,1)    频率：1000
物体：形状：sphere       半径：0.2m    位置：(1,1,-1)   磁导率u：      电导率e：   
'''
#define loop
loop=ml.Loops(20,0.25,1,1000)
#define object
obj=mm.Moment(1,1,1000,0.2)
#calculate Hprim
Hp=np.zeros(3,dtype=complex)
Hp=loop.AllField(3,1,-1)
#calculate magnetic momemt
mom=np.zeros(3,dtype=complex)
mom=obj.SphereM(Hp)
#calculate secondary feild data
def mo(a,b,c=0):
    return np.sqrt(a**2+b**2+c**2)

xmin, xmax, ymin, ymax, z = -5., 5., -5., 5., 1. # x, y bounds and elevation
profile_x = 0. # x-coordinate of y-profile
profile_y = 0. # y-coordinate of x-profile
h = 0.2 # grid interval
radii = (2., 5.) # how many layers of field lines for plotting
Naz = 10 # number of azimuth

xi, yi = np.meshgrid(np.r_[xmin:xmax+h:h], np.r_[ymin:ymax+h:h])
x1, y1 = xi.flatten(), yi.flatten()
z1 = np.full(x1.shape,z)
Bx, By, Bz = np.zeros(len(x1),dtype=complex), np.zeros(len(x1),dtype=complex), np.zeros(len(x1),dtype=complex)
Ba1 = np.zeros(len(x1),dtype=complex)
for i in np.arange(len(x1)):
    Bx[i], By[i], Bz[i] = md.MagneticDipoleField((1,1,-1),(x1[i],y1[i],z1[i]),mom)
    Ba1[i]=mo(Bx[i],By[i],Bz[i])

# get x-profile
x2 = np.r_[xmin:xmax+h:h]
y2, z2 = np.full(x2.shape,profile_y), np.full(x2.shape,z)
Bx, By, Bz = np.zeros(len(x2),dtype=complex), np.zeros(len(x2),dtype=complex), np.zeros(len(x2),dtype=complex)
Ba2=np.zeros(len(x2),dtype=complex)
for i in np.arange(len(x2)):
    Bx[i], By[i], Bz[i] = md.MagneticDipoleField((1,1,-1),(x2[i],y2[i],z2[i]),mom)
    Ba2[i] = mo(Bx[i],By[i],Bz[i])
# get y-profile
y3 = np.r_[ymin:ymax+h:h]
x3, z3 = np.full(y3.shape,profile_x), np.full(y3.shape,z)
Bx, By, Bz = np.zeros(len(x3),dtype=complex), np.zeros(len(x3),dtype=complex), np.zeros(len(x3),dtype=complex)
Ba3=np.zeros(len(x3),dtype=complex)
for i in np.arange(len(x3)):
    Bx[i], By[i], Bz[i] = md.MagneticDipoleField((1,1,-1),(x3[i],y3[i],z3[i]),mom)
    Ba3[i] = mo(Bx[i],By[i],Bz[i])
#plot
fig = plt.figure()
ax = fig.gca(projection='3d')

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
