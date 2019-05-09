# Python3

import pandas as pd
from idToUfDict import idToUf

def baseCreation(basename='base.pl', csv='', columns=[], funcname=''):
    """
    basename = name of file that will be created\n
    csv = name of file to be readen\n
    columns = list of columns that should be readen\n
        each list item must be a list where:\n
        1 element of sublist is the column name\n
        2 element of sublist must be one of:\n
            'none' if no special treatment is required\n
            'name' if the columns may contain uppercases, spaces or special char\n
            'uf' if the colmns are uf id that must be translated to its initials\n
    funcname = name of functor that will be created\n
    """

    filename = '../knowbases/' + basename
    df = pd.read_csv('../assets/' + csv, sep=',', engine='python')

    file = open(filename, "w")

    for index, row in df.iterrows():
        if row['ANO'] != 2010:
            continue
 
        line = funcname + '('
        for i, item in enumerate(columns):
            
            if i: # print separator if this isn't first element
                line += ', '

            if item[1] == 'none':
                line += str(row[item[0]])
            elif item[1] == 'name':
                line += row[item[0]].lower().replace(' ', '_').replace('\'', '')
            elif item[1] == 'uf':
                line += idToUf[row[item[0]]]

        line += ').\n'
        file.write(line)

    file.close()

baseCreation(basename='test.pl',
             csv='dados_uf.csv',
             columns=[['UF', 'uf'],
                      ['IDHM', 'none']
                     ],
             funcname='idhm'
            )