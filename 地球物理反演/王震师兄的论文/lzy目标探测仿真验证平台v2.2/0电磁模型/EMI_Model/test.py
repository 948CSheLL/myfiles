# -*- coding: utf-8 -*-
"""
Created on Wed Jul  4 15:36:07 2018

@author: boston
"""
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np
import MagDipole as md
import MagLoops as ml
import Moment as mm

loop=ml.Loops(20,0.25,1,1000)
#define object
obj=mm.Moment(1,1,1000,0.2)
#calculate Hprim
Hp=np.zeros(3,dtype=complex)
Hp=loop.AllField(1,1,-1)
print(Hp)
#calculate magnetic momemt
mom=np.zeros(3,dtype=complex)
mom=obj.SphereM(Hp)
print(mom)
