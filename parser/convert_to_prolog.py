import pandas as pd
from enum import Enum

from id_to_uf import id_to_uf
from state_to_uf import state_to_uf

class TransformationTypes(Enum):
    NONE, ID_UF, STATE_UF, FLOAT, NAME = range(5)

def _format_column_values(transformation, value):
    """
    Transform a column value representation for better fitting database

    :param int transformation: type of tranformation to be applied
    :param str value: the value to be tranformed
    """

    result = None

    if transformation == TransformationTypes.NONE:
        result = value
    elif transformation == TransformationTypes.STATE_UF:
        result = state_to_uf[value]
    elif transformation == TransformationTypes.ID_UF:
        result = id_to_uf[int(value)]
    elif transformation == TransformationTypes.NAME:
        result = str(value).replace(' ', '_').replace("'", '')
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
