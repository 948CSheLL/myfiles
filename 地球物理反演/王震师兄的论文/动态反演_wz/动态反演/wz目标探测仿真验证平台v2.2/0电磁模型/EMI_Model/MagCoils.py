import numpy as np
from numpy import *


class Coils():
	
	def __init__(self,I,R,z0,num):
		self.R=R
		self.z=z0
		self.num=num
		self.step=2*np.pi/num
		self.A=I/(4*np.pi)
		
	def delta(self,x,y,z):
		i=0
		dBx,dBy,dBz=0,0,0
		while(i<self.num):
			x00=self.R*np.sin(i*self.step)
			y00=self.R*np.cos(i*self.step)
			i+=1
			x01=self.R*np.sin(i*self.step)
			y01=self.R*np.cos(i*self.step)
		
			dlx=x01-x00
			dly=y01-y00
			dlz=0
	
			xlc=(x01+x00)/2
			ylc=(y01+y00)/2
		
			rx=(x-xlc)
			ry=(y-ylc)
			rz=(z-self.z)
			r3=(sqrt(rx**2+ry**2+rz**2))**3
		
			dBx+=self.A*(rz*dly-ry*dlz)/r3
			dBy+=self.A*(rx*dlz-rz*dlx)/r3
			dBz+=self.A*(ry*dlx-rx*dly)/r3
			
		return dBx,dBy,dBz
		
	
		


	
	
	
	
	
	
	