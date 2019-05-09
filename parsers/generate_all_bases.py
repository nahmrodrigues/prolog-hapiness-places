import pandas as pd
from os import path
from collections import namedtuple

from convert_to_prolog import (
    convert_to_prolog,
    TransformationTypes,
)

Base = namedtuple('Base', ('name', 'original_base', 'base_name', 'fact_name', 'columns'))

bases = (
    Base(
        name='locality',
        original_base='dados_mun',
        base_name='localidades',
        fact_name='localidade',
        columns={
            'Codmun6': TransformationTypes.NONE,
            'Município': TransformationTypes.NONE,
            'UF': TransformationTypes.UF,
        }
    ),
)

def generate_base(base, src_path='../assets', dest_path='../knowbases'):
    df = pd.read_csv(path.join(src_path, base.original_base + '.csv'), dtype='unicode')

    prolog_base = convert_to_prolog(df, base.columns, base.fact_name)

    out_filename = path.join(dest_path, base.base_name + '.pl')
    with open(out_filename, 'w') as f:
        f.writelines(prolog_base)

if __name__ == '__main__':
    for base in bases:
        generate_base(base)

    print('Generated bases:', ', '.join(base.name for base in bases))
