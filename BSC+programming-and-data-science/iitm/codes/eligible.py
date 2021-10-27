#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
df=pd.read_csv('marks.csv')


# In[37]:


D={"M":dict(),"P":dict(),"C":dict()}
print(D)


# In[43]:


def upd(D,Y,subject):
    if Y["city"] in D[subject]:
        if D[subject][Y["city"]]<Y[subject]:
            D[subject][Y["city"]]=Y[subject]
    else:
        D[subject][Y["city"]]=Y[subject]
    return D


# In[44]:


for std in df["ID"]:
    dat=df.loc[std]
    D=upd(D,dat,"M")
    D=upd(D,dat,"P")
    D=upd(D,dat,"C")


# In[46]:


def eligible(D,X):
    C=0
    for subj in ("M","P","C",):
        if D[subj][X.city]==X[subj]:
            C=C+1
    return C


# In[47]:


B=0
for std in df["ID"]:
    dat=df.loc[std]
    if eligible(D,dat)>1:
        B=B+1


# In[48]:


B


# In[ ]:




