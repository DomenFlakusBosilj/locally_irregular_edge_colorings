#!/usr/bin/env python
# coding: utf-8

import json

with open("seznam_protiprimerov2.json") as f:
    neuspesni = json.load(f)

for i, s in enumerate(neuspesni):
    G = Graph(str(s), multiedges=False)
    print(i, G.order())
    graf = poskusi_pobarvat(G, n=100*G.order())
    if graf != None:
        seznam_nepobarvanih.append(graf)
        print(s)
