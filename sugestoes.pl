:- use_module(library(lists)).

:- [hprolog].
:- use_module(hprolog).

% Dados de municipios (mapear para todos os municipios):

localidade(2, gama, df).
localidade(1, taguatinga, df).
localidade(3, barreiras, ba).
localidade(4, ceilandia, df).

idhm(2, 5.3).
idhm(1, 5.0).
idhm(3, 4.5).
idhm(4, 6.2).

idhmEducacao(2, 5.3).
idhmEducacao(1, 5.0).
idhmEducacao(3, 4.5).
idhmEducacao(4, 6.2).

idhmRenda(2, 5.3).
idhmRenda(1, 5.0).
idhmRenda(3, 4.5).
idhmRenda(4, 6.2).

idhmLongevidade(2, 5.3).
idhmLongevidade(1, 10).
idhmLongevidade(3, 4.5).
idhmLongevidade(4, 6.2).

populacao(2, 20000).
populacao(1, 40000).
populacao(3, 150000).
populacao(4, 100000).


% Dados que so existem por estado (mapear para todos):

idhmMulheres(df, 5.3).
idhmMulheres(ba, 5.0).

idhmHomens(df, 5.3).
idhmHomens(ba, 5.0).

idhmNegros(df, 5.3).
idhmNegros(ba, 5.0).

idhmBrancos(df, 5.3).
idhmBrancos(ba, 5.0).

idhmEducacaoMulheres(df, 5.3).
idhmEducacaoMulheres(ba, 5.0).

idhmEducacaoHomens(df, 5.3).
idhmEducacaoHomens(ba, 5.0).

idhmEducacaoNegros(df, 5.3).
idhmEducacaoNegros(ba, 5.0).

idhmEducacaoBrancos(df, 5.3).
idhmEducacaoBrancos(ba, 5.0).

idhmRendaMulheres(df, 5.3).
idhmRendaMulheres(ba, 5.0).

idhmRendaHomens(df, 5.3).
idhmRendaHomens(ba, 5.0).

idhmRendaNegros(df, 5.3).
idhmRendaNegros(ba, 5.0).

idhmRendaBrancos(df, 5.3).
idhmRendaBrancos(ba, 5.0).

idhmLongevidadeMulheres(df, 5.3).
idhmLongevidadeMulheres(ba, 5.0).

idhmLongevidadeHomens(df, 5.3).
idhmLongevidadeHomens(ba, 5.0).

idhmLongevidadeNegros(df, 5.3).
idhmLongevidadeNegros(ba, 5.0).

idhmLongevidadeBrancos(df, 5.3).
idhmLongevidadeBrancos(ba, 5.0).

% Dados de criminalidade

taxaHomicidios(2, 10.0).
taxaHomicidios(1, 10.0).
taxaHomicidios(3, 5.0).
taxaHomicidios(4, 5.0).

taxaHomicidiosMulheresNegras(df, 5.0).
taxaHomicidiosMulheresNegras(ba, 5.0).

taxaHomicidiosMulheresNaoNegras(df, 5.0).
taxaHomicidiosMulheresNaoNegras(ba, 5.0).

taxaHomicidiosHomensNegros(df, 5.0).
taxaHomicidiosHomensNegros(ba, 5.0).

taxaHomicidiosNaoNegros(df, 5.0).
taxaHomicidiosNaoNegros(ba, 5.0).


% Filtros
cidadePequena(Id, Populacao) :- populacao(Id, Populacao), Populacao =< 50000.
cidadeMedia(Id, Populacao) :- populacao(Id, Populacao), Populacao > 50000, Populacao =< 150000.
cidadeGrande(Id, Populacao) :- populacao(Id, Populacao), Populacao > 150000.
filtro(Tipo, Estado, Id) :-
    Tipo = 'pequena' -> cidadePequena(Id, _), localidade(Id, _, Estado);
    (Tipo = 'média' -> cidadeMedia(Id, _), localidade(Id, _, Estado));
    (Tipo = 'grande' -> cidadeGrande(Id, _), localidade(Id, _, Estado)).

retornaSugestoes(Sexo, Raca, Tipo, Estado, ListaSugestoes) :-
  sugere(Sexo, Raca, Tipo, Estado, Id, IndiceGeral),
  assertz((possiveisLocalidades(Id, IndiceGeral))),
  listaLocalidades(Lista),
  sort(2, @=<, Lista, ListaPossiveisLocalidades),
  maiores(ListaPossiveisLocalidades, ListaSugestoes),
  printSugestoes(ListaSugestoes), fail.

printSugestoes([]).
printSugestoes([Id/_|Tail]) :-
  localidade(Id, Nome, Estado),
  write('\n* '), write(Nome), write(' - '), write(Estado),
  printSugestoes(Tail).

maiores(ListaPossiveisLocalidades, ListaSugestoes) :-
  length(ListaPossiveisLocalidades, Len),
  Len < 5 -> take(Len, ListaPossiveisLocalidades, ListaSugestoes);
  (Len >= 5 -> take(5, ListaPossiveisLocalidades, ListaSugestoes)).

listaLocalidades(ListaPossiveisLocalidades) :-
  findall(Id/IndiceGeral, possiveisLocalidades(Id, IndiceGeral), ListaPossiveisLocalidades).

sugere(Sexo, Raca, Tipo, Estado, Id, IndiceGeral) :-
  filtro(Tipo, Estado, Id), % ids das possiveis cidades, filtradas por tipo e estado
  indicesIDHM(Sexo, Raca, Id, IndiceIDHM), % indices de idhm das cidades filtradas
  indicesCriminalidade(Sexo, Raca, Id, IndiceCriminalidade),
  indicesGerais(IndiceIDHM, IndiceCriminalidade, IndiceGeral).

indicesGerais(IndiceIDHM, IndiceCriminalidade, IndiceGeral) :-
  IndiceGeral is (IndiceIDHM - IndiceCriminalidade).

indicesCriminalidade(Sexo, Raca, Id, IndiceCriminalidade) :-
  Sexo = 'fem', Raca = 'neg' -> calculoCriminalidade(Id, 1.0, 0.0, 0.0, 0.0, IndiceCriminalidade);
  (Sexo = 'fem', Raca = 'nne' -> calculoCriminalidade(Id, 0.0, 1.0, 0.0, 0.0, IndiceCriminalidade));
  (Sexo = 'mas', Raca = 'neg' -> calculoCriminalidade(Id, 0.0, 0.0, 1.0, 0.0, IndiceCriminalidade));
  (Sexo = 'mas', Raca = 'bra' -> calculoCriminalidade(Id, 0.0, 0.0, 0.0, 1.0, IndiceCriminalidade)).


calculoCriminalidade(Id, PesoMN, PesoMNN, PesoHN, PesoHNN, IndiceCriminalidade) :-
  taxaHomicidios(Id, Taxa),
  localidade(Id, _, Estado),
  taxaHomicidiosMulheresNegras(Estado, TaxaMN), taxaHomicidiosMulheresNaoNegras(Estado, TaxaMNN),
  taxaHomicidiosHomensNegros(Estado, TaxaHN), taxaHomicidiosNaoNegros(Estado, TaxaHNN),
  IndiceCriminalidade is (Taxa + 
                         (TaxaMN * PesoMN) + 
                         (TaxaMNN * PesoMNN) + 
                         (TaxaHN * PesoHN) + 
                         (TaxaHNN * PesoHNN)).

indicesIDHM(Sexo, Raca, Id, IndiceIDHM) :-
    Sexo = 'fem', Raca = 'neg' -> calculoIDHM(Id, 1.0, 0.0, 1.0, 0.0, IndiceIDHM);
    (Sexo = 'fem', Raca = 'nne' -> calculoIDHM(Id, 1.0, 0.0, 0.0, 1.0, IndiceIDHM));
    (Sexo = 'mas', Raca = 'neg' -> calculoIDHM(Id, 0.0, 1.0, 1.0, 0.0, IndiceIDHM));
    (Sexo = 'mas', Raca = 'bra' -> calculoIDHM(Id, 0.0, 1.0, 0.0, 1.0, IndiceIDHM)).


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
