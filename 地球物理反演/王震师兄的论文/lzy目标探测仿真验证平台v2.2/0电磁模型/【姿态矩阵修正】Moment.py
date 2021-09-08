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

#适用条件：任意均匀球体的响应公式，没有乘U0
#param in：H_prim(hx,hy,hz)  主场
#param out：m(mx,my,mz)  磁矩
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

#适用条件：
    def HC_SphereM(self,H):
        tao=(self.R**2)*self.e*self.u*u0
        z1=np.sqrt(1j*self.w*tao)-2
        z2=np.sqrt(1j*self.w*tao)+1
        z=z1/z2
        A=self.A*z

        m=np.zeros(3,dtype=complex)
        for i in np.arange(len(m)):
            m[i]=A*H[i]

        return m

#适用条件：圆柱体长宽比：4：1，高磁导率材料

    def HC_CylinderM(self,H,p,theta,gama,plot=1):
        
        fai=0
        theta=theta*np.pi/180
        gama=gama*np.pi/180
        sf=np.sin(fai)
        cf=np.cos(fai)
        st=np.sin(theta)
        ct=np.cos(theta)
        sg=np.sin(gama)
        cg=np.cos(gama)
        tao=(self.R**2)*self.e*self.u*u0
        z1=np.sqrt(1j*self.w*tao)-2
        z2=np.sqrt(1j*self.w*tao)+1
        z0=z1/z2
        z01=np.sqrt(1j*self.w*31*tao)-2
        z02=np.sqrt(1j*self.w*31*tao)+1
        z00=z01/z02
        z=np.zeros(3,dtype=complex)
        
        z[0]=p/2*((1.35-1)+z0)
        z[1]=p/2*((1.35-1)+z0)
        z[2]=0.5*((0.3-1)+z00)

        PT=np.diag(z)
        
        RT=np.zeros([3,3])
        RT[0][0]=cg
        RT[0][1]=0
        RT[0][2]=-sg
        RT[1][0]=st*sg
        RT[1][1]=ct
        RT[1][2]=st*cg
        RT[2][0]=ct*sg
        RT[2][1]=-st
        RT[2][2]=ct*cg
        
        A=np.dot(RT,PT)
        A=np.dot(A,RT.T)
        A=np.dot(A,H.T)
        m=self.A*A

        return m
