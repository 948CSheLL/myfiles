import numpy as np
import math
from numpy import *


class Loops():
	
	def __init__(self,I,R,z0,w):
		self.R=R
		self.z=z0
		self.k=2*np.pi*w/(3*1e8)
		self.A=(R**2)*I
		
	def NearField(self,x,y,z):
		z=z-self.z
		r=sqrt(x**2+y**2+z**2)
		r_xy=sqrt(x**2+y**2)
		sint=r_xy/r
		cost=z/r
		sinf=y/r_xy
		cosf=x/r_xy
		r3=r**3
		
		hr_A=self.A*cost/(2*r3)
		hr_real=hr_A*math.cos(-self.k*r)
		hr_imag=hr_A*math.sin(-self.k*r)
		
		ht_A=self.A*sint/(4*r3)
		ht_real=ht_A*math.cos(-self.k*r)
		ht_imag=ht_A*math.sin(-self.k*r)
		
		#hx_real=hr_real*sint*cosf+ht_real*cost*cosf
		#hx_imag=hr_imag*sint*cosf+ht_imag*cost*cosf
		#hy_real=hr_real*sint*sinf+ht_real*cost*sinf
		#hy_imag=hr_imag*sint*sinf+ht_imag*cost*sinf
		#hz_real=hr_real*cost+ht_real*sint
		#hz_imag=hr_imag*cost+ht_imag*sint
		
		#return hx_real,hy_real,hz_real,hx_imag,hy_imag,hz_imag
		
		h_real=sqrt(hr_real**2+ht_real**2)
		h_imag=sqrt(hr_imag**2+ht_imag**2)
		
		return h_real,h_imag
		
	def AllField(self,x,y,z):
		z=z-self.z
		r=sqrt(x**2+y**2+z**2)
		r_xy=sqrt(x**2+y**2)
		sint=r_xy/r
		cost=z/r
		sinf=y/r_xy
		cosf=x/r_xy
		r3=r**3
		r2=r**2
		
		e_real=math.cos(-self.k*r)
		e_imag=math.sin(-self.k*r)
		
		hr_r=self.A*cost/(2*r3)
		hr_i=self.A*self.k*cost/(2*r2)
		
		ht_r=self.A*sint*0.25*(1/r3-(self.k**2)/r)
		ht_i=self.A*self.k*sint/(4*r2)
		
		hr_real=hr_r*e_real-hr_i*e_imag
		hr_imag=hr_i*e_real+hr_r*e_imag
		ht_real=ht_r*e_real-ht_i*e_imag
		ht_imag=ht_i*e_real+ht_r*e_imag
		
		h_real=sqrt(hr_real**2+ht_real**2)
		h_imag=sqrt(hr_imag**2+ht_imag**2)
		
		return h_real,h_imag
		
		