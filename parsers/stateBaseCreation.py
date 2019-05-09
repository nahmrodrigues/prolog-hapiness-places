# Python3

import pandas as pd
from idToUfDict import idToUf

def convertStateToProlog():
    filename = '../knowbases/idUfKnowBase.pl'
    df = pd.read_csv('../assets/dados_uf.csv', sep=',', engine='python')

    file = open(filename, "w")

    for index, row in df.iterrows():
        if row['ANO'] != 2010:
            continue
        stateName = row['UFN']
        stateName = stateName.lower().replace(' ', '_')
        file.write('estado(' +
                stateName + ', ' +
                str(row['UF']) + ', ' +
                idToUf[row['UF']] + ').\n')

    file.close()

convertStateToProlog()