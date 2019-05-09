import pandas as pd

from os import path
from enum import Enum

from idToUfDict import idToUf

class TranformationTypes(Enum):
    NONE = 0
    UF = 1
    FLOAT = 2

def format_column_values(transformation, value):
    """
    Tranform a column value representation for better fitting database

    :param int transformation: type of tranformation to be applied
    :param str value: the value to be tranformed
    """

    result = None

    if transformation is None:
        result = value
    elif transformation == TranformationTypes.NONE:
        result = value.lower().replace(' ', '_').replace("'", '')
    elif transformation == TranformationTypes.UF:
        result = idToUf[int(value)]
    elif transformation == TranformationTypes.FLOAT:
        result = str(value).replace(',', '.')

    return result


def convertToProlog(basename, csv_file, columns, fact_name):
    """
    Convert a CSV base to Prolog

    :param str basename: name of file that will be created
    :param str csv_file: name of file to be readen
    :param dict columns: key is column name and value is the type of operation to be applied on value
    :param str fact_name: name of functor that will be created
    """

    filename = path.join('../knowbases', basename)
    df = pd.read_csv(path.join('../assets', csv_file))

    df = df[df.ANO != 2010]

    lines = ['{}({}).\n'.format(
                fact_name,
                ', '.join(
                   format_column_values(transf, str(row[name])) for name, transf in columns.items()
                )
             ) for _, row in df.iterrows()]

    with open(filename, 'w') as f:
        f.writelines(lines)

if __name__ == '__main__':
    columns = {
        'UF': TranformationTypes.UF,
        'IDHM': TranformationTypes.FLOAT,
    }

    convertToProlog(
        basename='test.pl',
        csv_file='dados_uf.csv',
        columns=columns,
        fact_name='idhm'
    )
