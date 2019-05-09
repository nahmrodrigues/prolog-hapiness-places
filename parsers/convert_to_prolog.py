import pandas as pd

from os import path
from enum import Enum

from idToUfDict import idToUf

class TransformationTypes(Enum):
    NONE, UF, FLOAT = range(3)

def _format_column_values(transformation, value):
    """
    Tranform a column value representation for better fitting database

    :param int transformation: type of tranformation to be applied
    :param str value: the value to be tranformed
    """

    result = None

    if transformation == TransformationTypes.NONE:
        result = value
    elif transformation == TransformationTypes.UF:
        result = idToUf[int(value)]
    elif transformation == TransformationTypes.FLOAT:
        result = str(value).replace(',', '.')

    return result


def convert_to_prolog(df, columns, fact_name):
    """
    Convert a CSV base to Prolog

    :param pandas.DataFrame df: name of file that will be created
    :param dict columns: key is column name and value is the type of operation to be applied on value
    :param str fact_name: name of functor that will be created
    """

    return ('{}({}).\n'.format(
                fact_name,
                ', '.join(
                   _format_column_values(transf, str(row[name])) for name, transf in columns.items()
                )
             ) for _, row in df.iterrows())
