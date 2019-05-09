import pandas as pd
from os import path

from convert_to_prolog import convert_to_prolog
from bases import bases

def generate_base(base, src_path='../assets', dest_path='../knowledge_bases'):
    df = pd.read_csv(path.join(src_path, base.original_base + '.csv'), dtype='unicode')

    prolog_base = convert_to_prolog(df, base.columns, base.fact_name)

    out_filename = path.join(dest_path, base.name + '.pl')
    with open(out_filename, 'w') as f:
        f.writelines(prolog_base)

if __name__ == '__main__':
    print('Generating bases...\n')

    for base in bases:
        generate_base(base)
        print("Generated base '{}'".format(base.name))

    print('\nGenerated bases:', ', '.join(base.name for base in bases))
