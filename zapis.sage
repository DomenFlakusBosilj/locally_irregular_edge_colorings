#!/usr/bin/env python
# coding: utf-8

seznam_nepobarvanih.sort(key=len)

#ZAPIS V JSON DATOTEKO
import json
seznam_protiprimerov = []
for G in seznam_nepobarvanih:
    seznam_protiprimerov.append(G.sparse6_string())
with open("seznam_protiprimerov.json", "w") as f:
    json.dump(seznam_protiprimerov, f)
