#!/usr/bin/env python
# coding: utf-8

#ZA VELIKE GRAFE
for i in [14, 16, 18, 20, 30 , 40, 50, 60, 70, 80, 90, 100]:
    print(i)
    for m in range(5):
        print("%d.%d" % (i, m))
        G = graphs.RandomRegular(3, i)
        graf = poskusi_pobarvat(G, n=100*i)
        if graf != None:
            seznam_nepobarvanih.append(graf)
            print(graf.sparse6_string())
