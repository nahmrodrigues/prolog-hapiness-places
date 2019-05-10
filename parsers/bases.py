# If has time, change this file to yaml

from collections import namedtuple
from convert_to_prolog import TransformationTypes

Base = namedtuple('Base', ('name', 'original_base', 'fact_name', 'columns'))

bases = (
    # Municipios
    # Adicionar filtro de ano em todos
    Base(
        name='localidades',
        original_base='dados_mun',
        fact_name='localidade',
        columns={
            'Codmun6': TransformationTypes.NONE,
            'Município': TransformationTypes.NONE,
            'UF': TransformationTypes.ID_UF,
        }
    ),
    Base(
        name='idhm',
        original_base='dados_mun',
        fact_name='idhm',
        columns={
            'Codmun6': TransformationTypes.NONE,
            'IDHM': TransformationTypes.FLOAT,
        }
    ),
    Base(
        name='idhm_education',
        original_base='dados_mun',
        fact_name='idhmEducacao',
        columns={
            'Codmun6': TransformationTypes.NONE,
            'IDHM_E': TransformationTypes.FLOAT,
        }
    ),
    Base(
        name='idhm_income',
        original_base='dados_mun',
        fact_name='idhmRenda',
        columns={
            'Codmun6': TransformationTypes.NONE,
            'IDHM_R': TransformationTypes.FLOAT,
        }
    ),
    Base(
        name='idhm_longevity',
        original_base='dados_mun',
        fact_name='idhmLongevidade',
        columns={
            'Codmun6': TransformationTypes.NONE,
            'IDHM_L': TransformationTypes.FLOAT,
        }
    ),
    Base(
        name='population',
        original_base='dados_mun',
        fact_name='populacao',
        columns={
            'Codmun6': TransformationTypes.NONE,
            'pesotot': TransformationTypes.NONE,
        }
    ),


    # Estados
    Base( # Adicionar filtro mulher
        original_base='sexo-uf',
        name='idhm_women',
        fact_name='idhmMulheres',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro mulher
        name='idhm_women_education',
        original_base='sexo-uf',
        fact_name='idhmEducacaoMulheres',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_E': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro mulher
        name='idhm_women_income',
        original_base='sexo-uf',
        fact_name='idhmRendaMulheres',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_R': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro mulher
        name='idhm_women_longevity',
        original_base='sexo-uf',
        fact_name='idhmLongevidadeMulheres',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_L': TransformationTypes.FLOAT,
        }
    ),

    Base( # Adicionar filtro homem
        name='idhm_men',
        original_base='sexo-uf',
        fact_name='idhmHomens',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro homem
        name='idhm_men_education',
        original_base='sexo-uf',
        fact_name='idhmEducacaoHomens',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_E': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro homem
        name='idhm_men_income',
        original_base='sexo-uf',
        fact_name='idhmRendaHomens',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_R': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro homem
        name='idhm_men_longevity',
        original_base='sexo-uf',
        fact_name='idhmLongevidadeHomens',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_L': TransformationTypes.FLOAT,
        }
    ),

    Base( # Adicionar filtro negro
        name='idhm_black',
        original_base='cor-uf',
        fact_name='idhmNegros',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro negro
        name='idhm_black_education',
        original_base='sexo-uf',
        fact_name='idhmEducacaoNegros',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_E': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro negro
        name='idhm_black_income',
        original_base='sexo-uf',
        fact_name='idhmRendaNegros',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_R': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro negro
        name='idhm_black_longevity',
        original_base='sexo-uf',
        fact_name='idhmLongevidadeNegros',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_L': TransformationTypes.FLOAT,
        }
    ),

    Base( # Adicionar filtro branco
        name='idhm_white',
        original_base='cor-uf',
        fact_name='idhmBrancos',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro branco
        name='idhm_white_education',
        original_base='sexo-uf',
        fact_name='idhmEducacaoBrancos',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_E': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro branco
        name='idhm_white_income',
        original_base='sexo-uf',
        fact_name='idhmRendaBrancos',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_R': TransformationTypes.FLOAT,
        }
    ),
    Base( # Adicionar filtro branco
        name='idhm_white_longevity',
        original_base='sexo-uf',
        fact_name='idhmLongevidadeBrancos',
        columns={
            'CODIGO_ID': TransformationTypes.STATE_UF,
            'IDHM_L': TransformationTypes.FLOAT,
        }
    ),
)
