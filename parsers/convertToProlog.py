import pandas as pd
from os import path
from idToUfDict import idToUf

def format_column_values(transformation, value):
    """
    Apply transformation on column value
        'name': substitue special characters
        'uf': get UF name from id
    """

    result = None

    if transformation is None:
        result = value
    elif transformation == 'name':
        result = value.lower().replace(' ', '_').replace("'", '')
    elif transformation == 'uf':
        result = idToUf[int(value)]

    return result


def convertToProlog(basename, csv_file, columns, fact_name):
    """
    basename = name of file that will be created
    csv_file = name of file to be readen
    columns = key is column name and value is the type of operation to be applied on value
    fact_name = name of functor that will be created
    """

    filename = path.join('../knowbases', basename)
    df = pd.read_csv(path.join('../assets', csv_file))

    df = df[df.ANO != 2010]

    lines = ['{}({}).\n'.format(
                fact_name,
                ','.join(
                   format_column_values(transf, str(row[name])) for name, transf in columns.items()
                )
             ) for _, row in df.iterrows()]

    with open(filename, 'w') as f:
        f.writelines(lines)

if __name__ == '__main__':
    convertToProlog(
        basename='test.pl',
        csv_file='dados_uf.csv',
        columns={'UF': 'uf',
                 'IDHM': None},
        fact_name='idhm'
    )
