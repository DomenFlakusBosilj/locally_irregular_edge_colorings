#!/usr/bin/env python
# coding: utf-8

# In[2]:


barve = {'red': 1, 'green': 2, 'blue': 3}

def barvanje(G):
    barve = {'red': 1, 'green': 2, 'blue': 3}
    for u, v in G.edges(labels=False):
        c = randint(1, 3)
        G.set_edge_label(u, v, c)

def iskanje_slabih(G):
    slabe = []
    dobre = []
    G1 = G.subgraph(edges=[(u, v) for u, v, c in G.edges() if c == 1])
    G2 = G.subgraph(edges=[(u, v) for u, v, c in G.edges() if c == 2])
    G3 = G.subgraph(edges=[(u, v) for u, v, c in G.edges() if c == 3])
    for u, v, c in G1.edges():
        if G1.adjacency_matrix()[u][v] == 1:
            if G1.degree(u) == G1.degree(v):
                slabe.append((u, v, c))
            else:
                dobre.append((u, v, c))

    for u, v, c in G2.edges():
        if G2.adjacency_matrix()[u][v] == 1:
            if G2.degree(u) == G2.degree(v):
                slabe.append((u, v, c))
            else:
                dobre.append((u, v, c))

    for u, v, c in G3.edges():
        if G3.adjacency_matrix()[u][v] == 1:
            if G3.degree(u) == G3.degree(v):
                slabe.append((u, v, c))
            else:
                dobre.append((u, v, c))
    return slabe

def popravljanje(kolikokrat, G):
    import random
    A = Graph(G)
    B = Graph(G)
    for i in range(kolikokrat):
        u, v, c = G.random_edge()
        barva0 = [1,2,3]
        barva0.remove(c)
        barva1 = random.choice(barva0)
        A.set_edge_label(u, v, barva1)
        barva0.remove(barva1)
        B.set_edge_label(u, v, barva0[0])
        g = len(iskanje_slabih(G))
        a = len(iskanje_slabih(A))
        b = len(iskanje_slabih(B))
        if a < b:
            if a < g:
                G = Graph(A)
                #print 'spreminjam na A'
        else:
            if b < g:
                G = Graph(B)
                #print 'spreminjam na B'
    return G

def poskusi_pobarvat(G, i=0):
    ind = 0
    while i < 10:
        barvanje(G)
        G = Graph(popravljanje(3000, G))
        if iskanje_slabih(G) != []:
            i += 1
        else:
            print('uspelo pobarvat')
            ind = 1
            break
    if iskanje_slabih(G) != []:
        print 'ni uspel pobarvat'
        return G
    else:
        if ind == 0:
            print('uspelo pobarvat')


seznam_nepobarvanih = []

#ZA MALE GRAFE
for i in range(4,13,2):
    print(i)
    for G in graphs.nauty_geng('{} -c -d3 -D3'.format(i)):
        graf = poskusi_pobarvat(G)
        if graf != None:
            seznam_nepobarvanih.append(graf)
            print(seznam_nepobarvanih)

#ZA VELIKE GRAFE
for i in [14, 16, 18, 20, 30 , 40, 50, 60, 70, 80, 90, 100]:
    print(i)
    for m in range(10):
        G = graphs.RandomRegular(3, i)
        G.plot()
        graf = poskusi_pobarvat(G)
        if graf != None:
            seznam_nepobarvanih.append(graf)
            print(seznam_nepobarvanih)

seznam_nepobarvanih.sort(key=len)

#ZAPIS V JSON DATOTEKO
import json
seznam_protiprimerov = []
for G in seznam_nepobarvanih:
    seznam_protiprimerov.append(G.sparse6_string())
with open("seznam_protiprimerov.json", "w") as f:
    json.dump(seznam_protiprimerov, f)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




