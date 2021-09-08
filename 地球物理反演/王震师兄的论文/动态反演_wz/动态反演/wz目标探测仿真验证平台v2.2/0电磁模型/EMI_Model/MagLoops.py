# -*- coding: utf-8 -*-
"""
Created on Wed Jul  4 15:50:54 2018

@author: boston
"""

import numpy as np
#import math

class Loops():
	
    def __init__(self,I,R,z0,f):
        self.R=R
        self.z=z0
        self.k=2*np.pi*f/(3*1e8)
        self.A=(R**2)*I
    
    def NearField(self,x,y,z):
        z=z-self.z
        r=np.sqrt(x**2+y**2+z**2)
        r_xy=np.sqrt(x**2+y**2)
        sint=r_xy/r
        cost=z/r
        r3=r**3
        
        He=np.exp(-1j*self.k*r)
        
        Hr=self.A*cost*He/(2*r3)
        Ht=self.A*sint*He/(4*r3)
        
        H=np.sqrt(Hr**2+Ht**2)
        
        return H
		
    def AllField(self,x,y,z,plotT=0):
        
        z=z-self.z
        r=np.sqrt(x**2+y**2+z**2)
        r_xy=np.sqrt(x**2+y**2)
        sint=r_xy/r
        cost=z/r
        sinf=y/r_xy
        cosf=x/r_xy
        r3=r**3
        r2=r**2
        
        He=np.exp(-1j*self.k*r)
        
        Hr=self.A*cost*0.5*(1/r3+1j*self.k/r2)
        Hr=Hr*He
        
        Ht=self.A*sint*0.25*((1/r3-(self.k**2)/r)+1j*self.k/r2)
        Ht=Ht*He
        
        Hxyz=np.zeros(3,dtype=complex)
        Hxyz[0]=Hr*sint*cosf+Ht*cost*cosf
        Hxyz[1]=Hr*sint*sinf+Ht*cost*sinf
        Hxyz[2]=Hr*cost+Ht*sint

        H=np.sqrt(Hr**2+Ht**2)
        if plotT==1:
            return H
        else:
            return Hxyz