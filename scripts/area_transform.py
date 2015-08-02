import json
j=json.load(open('region.json'))

r=[]
for sheng in j:
    rr={'level':'sheng','name':sheng['provName'],'children':[]}
    rrr=[]
    for shi in sheng['cities']:
        rrr.append({'level':'shi','name':shi['cityName']})
    rr['children']=rrr
    r.append(rr)
print r
json.dump(r,open('area.json','wb'),indent=4)