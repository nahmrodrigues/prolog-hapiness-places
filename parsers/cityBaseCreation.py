# Python3

import pandas as pd
from idToUfDict import idToUf

def convertCityToProlog():
    filename = '../knowbases/idCityKnowBase.pl'
    df = pd.read_csv('../assets/dados_mun.csv', sep=',', engine='python')

    file = open(filename, "w")

    for index, row in df.iterrows():
        if row['ANO'] != 2010:
            continue
        cityName = row['Município']
        cityName = cityName.lower().replace(' ', '_').replace('\'', '')
        file.write('localidade(' +
                str(row['Codmun6']) + ', ' +
                cityName + ', ' +
                idToUf[row['UF']] + ').\n')

    file.close()

convertCityToProlog()