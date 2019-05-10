:- use_module(library(lists)).

:- consult(utils/hprolog).
:- use_module(utils/hprolog).

:- consult(knowledge_databases/localities).
:- consult(knowledge_databases/idhm).
:- consult(knowledge_databases/idhm_education).
:- consult(knowledge_databases/idhm_income).
:- consult(knowledge_databases/idhm_longevity). 
:- consult(knowledge_databases/population). 
:- consult(knowledge_databases/idhm_women).
:- consult(knowledge_databases/idhm_women_education).
:- consult(knowledge_databases/idhm_women_income).
:- consult(knowledge_databases/idhm_women_longevity).
:- consult(knowledge_databases/idhm_men).
:- consult(knowledge_databases/idhm_men_education).
:- consult(knowledge_databases/idhm_men_income).
:- consult(knowledge_databases/idhm_men_longevity).
:- consult(knowledge_databases/idhm_black).
:- consult(knowledge_databases/idhm_black_education).
:- consult(knowledge_databases/idhm_black_income).
:- consult(knowledge_databases/idhm_black_longevity).
:- consult(knowledge_databases/idhm_white).
:- consult(knowledge_databases/idhm_white_education).
:- consult(knowledge_databases/idhm_white_income).
:- consult(knowledge_databases/idhm_white_longevity).
:- consult(knowledge_databases/murder_rate).
:- consult(knowledge_databases/murder_rate_black_women).
:- consult(knowledge_databases/murder_rate_not_black_women).
:- consult(knowledge_databases/murder_rate_black_men).
:- consult(knowledge_databases/murder_rate_not_black_men).

:- use_module(knowledge_databases/localities).
:- use_module(knowledge_databases/idhm).
:- use_module(knowledge_databases/idhm_education).
:- use_module(knowledge_databases/idhm_income).
:- use_module(knowledge_databases/idhm_longevity). 
:- use_module(knowledge_databases/population). 
:- use_module(knowledge_databases/idhm_women).
:- use_module(knowledge_databases/idhm_women_education).
:- use_module(knowledge_databases/idhm_women_income).
:- use_module(knowledge_databases/idhm_women_longevity).
:- use_module(knowledge_databases/idhm_men).
:- use_module(knowledge_databases/idhm_men_education).
:- use_module(knowledge_databases/idhm_men_income).
:- use_module(knowledge_databases/idhm_men_longevity).
:- use_module(knowledge_databases/idhm_black).
:- use_module(knowledge_databases/idhm_black_education).
:- use_module(knowledge_databases/idhm_black_income).
:- use_module(knowledge_databases/idhm_black_longevity).
:- use_module(knowledge_databases/idhm_white).
:- use_module(knowledge_databases/idhm_white_education).
:- use_module(knowledge_databases/idhm_white_income).
:- use_module(knowledge_databases/idhm_white_longevity).
:- use_module(knowledge_databases/murder_rate).
:- use_module(knowledge_databases/murder_rate_black_women).
:- use_module(knowledge_databases/murder_rate_not_black_women).
:- use_module(knowledge_databases/murder_rate_black_men).
:- use_module(knowledge_databases/murder_rate_not_black_men).

% Filtros

menuSexo(EscolhaSexo) :-
  menu('Qual o seu sexo?',
        [ feminino: 'Feminino'
        , masculino: 'Masculino'
        ], EscolhaSexo).

menuRaca(EscolhaRaca) :-
  menu('Qual a sua raça?',
        [ negra: 'Negra'
        , branca: 'Branca'
      ], EscolhaRaca).

menuTipo(EscolhaTipo) :-
  menu('Em qual o tipo de cidade você prefere morar?',
        [ pequena: 'Cidade Pequena'
        , média: 'Cidade Média'
        , grande: 'Cidade Grande'
        ], EscolhaTipo).

% menuEstado(EscolhaEstado) :-
%   menu('Em qual estado brasileiro você prefere morar?',
%         [ ac: 'Acre'
%         , al: 'Alagoas'
%         , ap: 'Amapá'
%         , am: 'Amazonas'
%         , ba: 'Bahia'
%         , ce: 'Ceará'
%         , df: 'Distrito Federal'
%         , es: 'Espírito Santo'
%         , go: 'Goiás'
%         , ma: 'Maranhão'
%         , mt: 'Mato Grosso'
%         , ms: 'Mato Grosso do Sul'
%         , mg: 'Minas Gerais'
%         , pa: 'Pará'
%         , pb: 'Paraíba'
%         , pr: 'Paraná'
%         , pe: 'Pernambuco'
%         , pi: 'Piauí'
%         , rj: 'Rio de Janeiro'
%         , rn: 'Rio Grande do Norte'
%         , rs: 'Rio Grande do Sul'
%         , ro: 'Rondônia'
%         , rr: 'Roraima'
%         , sc: 'Santa Catarina'
%         , sp: 'São Paulo'
%         , se: 'Sergipe'
%         , to: 'Tocantins'
%         ], EscolhaEstado).

iniciar(Estado) :-
  retractall(possiveisLocalidades(_, _)),
  menuSexo(Sexo), menuRaca(Raca), menuTipo(Tipo),
  sugere(Sexo, Raca, Tipo, Estado, Id, IndiceGeral),
  assertz((possiveisLocalidades(Id, IndiceGeral))),
  listaLocalidades(ListaSugestoes),
  reverse(ListaSugestoes, ListaReversa),
  shell(clear),
  write('\nOs lugares onde você tem maior possibilidade de ser feliz são: \n'),
  print(5, ListaReversa), fail, !;
  nl, nl, write('FIM'), nl.

print(0, _) :- !.
print(_, []).
print(N, [_/Id|T]) :-
  localidade(Id, Nome, Estado),
  write('\n* '), write(Nome), write(' - '), write(Estado),
  N1 is N-1, print(N1, T).

listaLocalidades(ListaPossiveisLocalidades) :-
  setof(IndiceGeral/Id, possiveisLocalidades(Id, IndiceGeral), ListaPossiveisLocalidades).

sugere(Sexo, Raca, Tipo, Estado, Id, IndiceGeral) :-
  filtro(Tipo, Estado, Id), % ids das possiveis cidades, filtradas por tipo e estado
  indicesIDHM(Sexo, Raca, Id, IndiceIDHM), % indices de idhm das cidades filtradas
  indicesCriminalidade(Sexo, Raca, Id, IndiceCriminalidade),
  indicesGerais(IndiceIDHM, IndiceCriminalidade, IndiceGeral).

filtro(Tipo, Estado, Id) :-
    Tipo = 'pequena' -> cidadePequena(Id, _), localidade(Id, _, Estado);
    (Tipo = 'média' -> cidadeMedia(Id, _), localidade(Id, _, Estado));
    (Tipo = 'grande' -> cidadeGrande(Id, _), localidade(Id, _, Estado)).

cidadePequena(Id, Populacao) :- populacao(Id, Populacao), Populacao =< 50000.
cidadeMedia(Id, Populacao) :- populacao(Id, Populacao), Populacao > 50000, Populacao =< 150000.
cidadeGrande(Id, Populacao) :- populacao(Id, Populacao), Populacao > 150000.

indicesGerais(IndiceIDHM, IndiceCriminalidade, IndiceGeral) :-
  IndiceGeral is (IndiceIDHM - IndiceCriminalidade).

indicesCriminalidade(Sexo, Raca, Id, IndiceCriminalidade) :-
  Sexo = 'feminino', Raca = 'negra' -> calculoCriminalidade(Id, 1.0, 0.0, 0.0, 0.0, IndiceCriminalidade);
  (Sexo = 'feminino', Raca = 'branca' -> calculoCriminalidade(Id, 0.0, 1.0, 0.0, 0.0, IndiceCriminalidade));
  (Sexo = 'masculino', Raca = 'negra' -> calculoCriminalidade(Id, 0.0, 0.0, 1.0, 0.0, IndiceCriminalidade));
  (Sexo = 'masculino', Raca = 'branca' -> calculoCriminalidade(Id, 0.0, 0.0, 0.0, 1.0, IndiceCriminalidade)).


calculoCriminalidade(Id, PesoMN, PesoMNN, PesoHN, PesoHNN, IndiceCriminalidade) :-
  taxaHomicidios(Nome, _, Taxa),
  localidade(Id, Nome, Estado),
  taxaHomicidiosMulheresNegras(Estado, _, TaxaMN), taxaHomicidiosMulheresNaoNegras(Estado, _,TaxaMNN),
  taxaHomicidiosHomensNegros(Estado, _, TaxaHN), taxaHomicidiosHomensNaoNegros(Estado, _, TaxaHNN),
  IndiceCriminalidade is (Taxa + 
                         (TaxaMN * PesoMN) + 
                         (TaxaMNN * PesoMNN) + 
                         (TaxaHN * PesoHN) + 
                         (TaxaHNN * PesoHNN)).

indicesIDHM(Sexo, Raca, Id, IndiceIDHM) :-
    Sexo = 'feminino', Raca = 'negra' -> calculoIDHM(Id, 1.0, 0.0, 1.0, 0.0, IndiceIDHM);
    (Sexo = 'feminino', Raca = 'branca' -> calculoIDHM(Id, 1.0, 0.0, 0.0, 1.0, IndiceIDHM));
    (Sexo = 'masculino', Raca = 'negra' -> calculoIDHM(Id, 0.0, 1.0, 1.0, 0.0, IndiceIDHM));
    (Sexo = 'masculino', Raca = 'branca' -> calculoIDHM(Id, 0.0, 1.0, 0.0, 1.0, IndiceIDHM)).


calculoIDHM(Id, PesoF, PesoM, PesoN, PesoB, IndiceIDHM) :-
    idhm(Id, IDHM), idhmEducacao(Id, IDHMEduc), idhmRenda(Id, IDHMRend), idhmLongevidade(Id, IDHMLong),
    localidade(Id, _, Estado),
    idhmMulheres(Estado, IDHMMul), idhmHomens(Estado, IDHMHom), idhmNegros(Estado, IDHMNeg), idhmBrancos(Estado, IDHMBra),
    idhmEducacaoMulheres(Estado, IDHMEducMul), idhmEducacaoHomens(Estado, IDHMEducHom), idhmEducacaoNegros(Estado, IDHMEducNeg), idhmEducacaoBrancos(Estado, IDHMEducBra),
    idhmRendaMulheres(Estado, IDHMRendMul), idhmRendaHomens(Estado, IDHMRendHom), idhmRendaNegros(Estado, IDHMRendNeg), idhmRendaBrancos(Estado, IDHMRendBra),
    idhmLongevidadeMulheres(Estado, IDHMLongMul), idhmLongevidadeHomens(Estado, IDHMLongHom), idhmLongevidadeNegros(Estado, IDHMLongNeg), idhmLongevidadeBrancos(Estado, IDHMLongBra),
    IndiceIDHM is (IDHM + IDHMEduc + IDHMRend + IDHMLong) +
              (((IDHMMul + IDHMEducMul + IDHMRendMul + IDHMLongMul) * PesoF) +
              ((IDHMHom + IDHMEducHom + IDHMRendHom + IDHMLongHom) * PesoM) +
              ((IDHMNeg + IDHMEducNeg + IDHMRendNeg + IDHMLongNeg) * PesoN) +
              ((IDHMBra + IDHMEducBra + IDHMRendBra + IDHMLongBra) * PesoB)).
