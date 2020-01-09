#!/usr/bin/env python
# coding: utf-8

import json

with open("seznam_protiprimerov.json") as f:
    neuspesni = json.load(f)

for s in neuspesni:
    G = Graph(str(s), multiedges=False)
    print(G.order())
    graf = poskusi_pobarvat(G)
    if graf != None:
        seznam_nepobarvanih.append(graf)
        print(s)
