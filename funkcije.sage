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

def lokalno_popravljanje(G):
    import random
    for u, v, c in iskanje_slabih(G):
        for u1, v1, c1 in G.edges_incident(u):
            A = Graph(G)
            B = Graph(G)
            c = [1,2,3]
            c.remove(G.edge_label(u1,v1))
            barva1 = random.choice(c)
            A.set_edge_label(u1, v1, barva1)
            c.remove(barva1)
            B.set_edge_label(u1, v1, c[0])
            g = len(iskanje_slabih(G))
            a = len(iskanje_slabih(A))
            b = len(iskanje_slabih(B))
            print iskanje_slabih(G)
            print G.edges()
            if a < b:
                if a < g:
                    G = Graph(A)
                    print 'spreminjam na A'
                    print G.edges()
            else:
                if b < g:
                    G = Graph(B)
                    print 'spreminjam na B'
                    print G.edges()
        for u1, v1, c1 in G.edges_incident(v):
            A = Graph(G)
            B = Graph(G)
            a = len(iskanje_slabih(G))
            c = [1,2,3]
            c.remove(G.edge_label(u1,v1))
            barva1 = random.choice(c)
            A.set_edge_label(u1, v1, barva1)
            c.remove(barva1)
            B.set_edge_label(u1, v1, c[0])
            g = len(iskanje_slabih(G))
            a = len(iskanje_slabih(A))
            b = len(iskanje_slabih(B))
            print iskanje_slabih(G)
            print G.edges()
            if a < b:
                if a < g:
                    G = Graph(A)
                    print 'spreminjam na A'
                    print G.edges()
            else:
                if b < g:
                    G = Graph(B)
                    print 'spreminjam na B'
                    print G.edges()
    return G

def poskusi_pobarvat(G, i=0):
    ind = 0
    while i < 10:
        print('barva{}'.format(i))
        barvanje(G)
        G = Graph(popravljanje(3000, G))
        if iskanje_slabih(G) != []:
            print 'grem lokalno popravljat'
            lokalno_popravljen = Graph(lokalno_popravljanje(G))
            slabi_po_lokalnem = iskanje_slabih(lokalno_popravljen)
            if (slabi_po_lokalnem != []) and (lokalno_popravljen.edges() != G.edges()):
                print 'grem se enkrat popravljat'
                G = Graph(popravljanje(3000, lokalno_popravljen))
                if iskanje_slabih(G) != []:
                    i += 1
                else:
                    print('uspelo pobarvat1')
                    ind = 1
                    break
            elif (slabi_po_lokalnem != []) and (lokalno_popravljen.edges() == G.edges()):
                i += 1
            elif slabi_po_lokalnem == []:
                print('uspelo pobarvat z lokalnim')
                ind = 1
                G = Graph(lokalno_popravljen)
                break
        else:
            print('uspelo pobarvat3')
            ind = 1
            break
    if iskanje_slabih(G) != []:
        print 'ni uspel pobarvat'
        return G
    else:
        if ind == 0:
            print('uspelo pobarvat4')

seznam_nepobarvanih = []
