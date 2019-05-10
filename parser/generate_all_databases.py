#!/usr/bin/python3

import pandas as pd
from os import path, makedirs

from convert_to_prolog import convert_to_prolog
from databases_specs import databases

BASE_DIR = path.dirname(path.dirname(path.abspath(__file__)))

def generate_base(database, src_path=path.join(BASE_DIR, 'assets'), dest_path=path.join(BASE_DIR, 'knowledge_databases')):
    df = pd.read_csv(path.join(src_path, database.original_base + '.csv'), dtype='unicode')

    if database.query:
        df.query(database.query, inplace=True)

    prolog_database = convert_to_prolog(df, database.columns, database.fact_name)

    out_filename = path.join(dest_path, database.name + '.pl')
    makedirs(dest_path, exist_ok=True)
    with open(out_filename, 'w') as f:
        f.writelines(prolog_database)

if __name__ == '__main__':
    print('Generating databases...\n')

    for database in databases:
        generate_base(database)
        print("Generated database '{}'".format(database.name))

    print('\nGenerated databases:', ', '.join(database.name for database in databases))
