# Python3

import pandas as pd

filename = 'idUfKnowBase.pl'
df = pd.read_csv('../assets/dados_uf.csv', sep=',', engine='python')

file = open(filename, "w")

for index, row in df.iterrows():
    if row['ANO'] != 2010:
        continue
    stateName = row['UFN']
    stateName = stateName.lower().replace(' ', '_')
    file.write('temId(' + stateName + ', ' + str(row['UF']) + ').\n')

file.close()