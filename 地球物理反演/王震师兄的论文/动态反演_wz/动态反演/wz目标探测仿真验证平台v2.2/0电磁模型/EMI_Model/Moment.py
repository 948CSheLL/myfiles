# -*- coding: utf-8 -*-
"""
Created on Tue Jul  3 20:16:28 2018

@author: boston
"""

import numpy as np

u0=4*np.pi*1e-7

class Moment():
    
    def __init__(self,u,e,f,R):
        self.R=R 
        self.u=u 
        self.e=e 
        self.w=2*np.pi*f
        self.A=(4*np.pi*(R**3))/3 

    def SphereM(self,H):
        alpha=np.sqrt(1j*self.w*self.u*self.e)*self.R
        x1=self.u*(np.tanh(alpha)-alpha)
        x2=u0*((alpha**2)*np.tanh(alpha)-alpha+np.tanh(alpha))
        x=1.5*(2*x1+x2)/(x1-x2)
        A=self.A*x

        m=np.zeros(3,dtype=complex)
        for i in np.arange(len(m)):
            m[i]=A*H[i]

        return m

    '''
    def CylineM(self,H):
'''       