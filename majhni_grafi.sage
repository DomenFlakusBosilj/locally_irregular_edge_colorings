#!/usr/bin/env python
# coding: utf-8

#ZA MALE GRAFE
for i in range(4,13,2):
    print(i)
    for G in graphs.nauty_geng('{} -c -d3 -D3'.format(i)):
        graf = poskusi_pobarvat(G)
        if graf != None:
            seznam_nepobarvanih.append(graf)
            print(seznam_nepobarvanih)
