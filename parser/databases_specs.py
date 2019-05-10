# If has time, change this file to yaml

from collections import namedtuple
from convert_to_prolog import TransformationTypes

Database = namedtuple('Database', ('name', 'original_base', 'fact_name', 'query', 'columns'))

databases = (
    Database(
        name='localities',
        original_base='dados_mun',
        fact_name='localidade',
        query="ANO == '2010'",
        columns={
            'Codmun6': TransformationTypes.NONE,
            'Município': TransformationTypes.NAME,
            'UF': TransformationTypes.ID_UF,
        }
    ),
    Database(
        name='idhm',
        original_base='dados_mun',
        fact_name='idhm',
        query="ANO == '2010'",
        columns={
            'Codmun6': TransformationTypes.NONE,
            'IDHM': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_education',
        original_base='dados_mun',
        fact_name='idhmEducacao',
        query="ANO == '2010'",
        columns={
            'Codmun6': TransformationTypes.NONE,
            'IDHM_E': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_income',
        original_base='dados_mun',
        fact_name='idhmRenda',
        query="ANO == '2010'",
        columns={
            'Codmun6': TransformationTypes.NONE,
            'IDHM_R': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_longevity',
        original_base='dados_mun',
        fact_name='idhmLongevidade',
        query="ANO == '2010'",
        columns={
            'Codmun6': TransformationTypes.NONE,
            'IDHM_L': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='population',
        original_base='dados_mun',
        fact_name='populacao',
        query="ANO == '2010'",
        columns={
            'Codmun6': TransformationTypes.NONE,
            'pesotot': TransformationTypes.NONE,
        }
    ),


    # Estados
    Database(
        original_base='sexo-uf',
        name='idhm_women',
        fact_name='idhmMulheres',
        query="ANO == '2010' and DESAGREGAÇÃO == 'MULHER'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_women_education',
        original_base='sexo-uf',
        fact_name='idhmEducacaoMulheres',
        query="ANO == '2010' and DESAGREGAÇÃO == 'MULHER'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_E': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_women_income',
        original_base='sexo-uf',
        fact_name='idhmRendaMulheres',
        query="ANO == '2010' and DESAGREGAÇÃO == 'MULHER'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_R': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_women_longevity',
        original_base='sexo-uf',
        fact_name='idhmLongevidadeMulheres',
        query="ANO == '2010' and DESAGREGAÇÃO == 'MULHER'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_L': TransformationTypes.FLOAT,
        }
    ),

    Database(
        name='idhm_men',
        original_base='sexo-uf',
        fact_name='idhmHomens',
        query="ANO == '2010' and DESAGREGAÇÃO == 'HOMEM'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_men_education',
        original_base='sexo-uf',
        fact_name='idhmEducacaoHomens',
        query="ANO == '2010' and DESAGREGAÇÃO == 'HOMEM'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_E': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_men_income',
        original_base='sexo-uf',
        fact_name='idhmRendaHomens',
        query="ANO == '2010' and DESAGREGAÇÃO == 'HOMEM'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_R': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_men_longevity',
        original_base='sexo-uf',
        fact_name='idhmLongevidadeHomens',
        query="ANO == '2010' and DESAGREGAÇÃO == 'HOMEM'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_L': TransformationTypes.FLOAT,
        }
    ),

    Database(
        name='idhm_black',
        original_base='cor-uf',
        fact_name='idhmNegros',
        query="ANO == '2010' and DESAGREGAÇÃO == 'NEGRO'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_black_education',
        original_base='sexo-uf',
        fact_name='idhmEducacaoNegros',
        query="ANO == '2010' and DESAGREGAÇÃO == 'NEGRO'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_E': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_black_income',
        original_base='sexo-uf',
        fact_name='idhmRendaNegros',
        query="ANO == '2010' and DESAGREGAÇÃO == 'NEGRO'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_R': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_black_longevity',
        original_base='sexo-uf',
        fact_name='idhmLongevidadeNegros',
        query="ANO == '2010' and DESAGREGAÇÃO == 'NEGRO'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_L': TransformationTypes.FLOAT,
        }
    ),

    Database(
        name='idhm_white',
        original_base='cor-uf',
        fact_name='idhmBrancos',
        query="ANO == '2010' and DESAGREGAÇÃO == 'BRANCO'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_white_education',
        original_base='sexo-uf',
        fact_name='idhmEducacaoBrancos',
        query="ANO == '2010' and DESAGREGAÇÃO == 'BRANCO'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_E': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_white_income',
        original_base='sexo-uf',
        fact_name='idhmRendaBrancos',
        query="ANO == '2010' and DESAGREGAÇÃO == 'BRANCO'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_R': TransformationTypes.FLOAT,
        }
    ),
    Database(
        name='idhm_white_longevity',
        original_base='sexo-uf',
        fact_name='idhmLongevidadeBrancos',
        query="ANO == '2010' and DESAGREGAÇÃO == 'BRANCO'",
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_L': TransformationTypes.FLOAT,
        }
    ),
)
