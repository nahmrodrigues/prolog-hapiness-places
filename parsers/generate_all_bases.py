import pandas as pd
from os import path

from convert_to_prolog import convert_to_prolog
from databases_specs import databases

def generate_base(database, src_path='../assets', dest_path='../knowledge_bases'):
    df = pd.read_csv(path.join(src_path, database.original_base + '.csv'), dtype='unicode')

    if database.query:
        df.query(database.query, inplace=True)

    prolog_database = convert_to_prolog(df, database.columns, database.fact_name)

    out_filename = path.join(dest_path, database.name + '.pl')
    with open(out_filename, 'w') as f:
        f.writelines(prolog_database)

if __name__ == '__main__':
    print('Generating bases...\n')

    for database in databases:
        generate_base(database)
        print("Generated base '{}'".format(database.name))

    print('\nGenerated bases:', ', '.join(database.name for database in databases))
