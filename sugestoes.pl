% Dados de municipios (mapear para todos os municipios):

localidade(1, gama, df).
localidade(2, taguatinga, df).
localidade(3, barreiras, ba).
localidade(4, ceilandia, df).

idhm(1, 5.3).
idhm(2, 5.0).
idhm(3, 4.5).
idhm(4, 6.2).

idhmEducacao(1, 5.3).
idhmEducacao(2, 5.0).
idhmEducacao(3, 4.5).
idhmEducacao(4, 6.2).

idhmRenda(1, 5.3).
idhmRenda(2, 5.0).
idhmRenda(3, 4.5).
idhmRenda(4, 6.2).

idhmLongevidade(1, 5.3).
idhmLongevidade(2, 5.0).
idhmLongevidade(3, 4.5).
idhmLongevidade(4, 6.2).

populacao(1, 20000).
populacao(2, 40000).
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

% Filtros
cidadePequena(Id, Populacao) :- populacao(Id, Populacao), Populacao =< 50000.
cidadeMedia(Id, Populacao) :- populacao(Id, Populacao), Populacao > 50000, Populacao =< 150000.
cidadeGrande(Id, Populacao) :- populacao(Id, Populacao), Populacao > 150000.


filtro(Tipo, Estado, Id) :-
    Tipo = 'pequena' -> cidadePequena(Id, _), localidade(Id, _, Estado);
    (Tipo = 'média' -> cidadeMedia(Id, _), localidade(Id, _, Estado));
    (Tipo = 'grande' -> cidadeGrande(Id, _), localidade(Id, _, Estado)).

sugere(Sexo,Raca,Tipo,Estado) :-
  /*Aqui temos todas as cidades filtradas por estado e tipo*/
  filtro(Tipo,Estado,Id),
  /*Aqui temos todos os indices das cidades já filtradas e de acordo aos dados do usuário*/
  indicesIDHM(Sexo,Raca,Id,Indice),
  /*Aqui devemos escolher as cidades com os 2 maiores índices*/
  /*maioresIndices(Id,Indice),*/
  /*Aqui iremos pegar o Nome e o estado dos locais a serem sugeridos*/
  localidade(Id,Nome,Estado),
  printIndices(Nome, Estado,Indice),fail;
  write('FIM').

printIndices(Nome, Estado, Indice) :-
  write('\nCidade  : '), write(Nome), write('/'), write(Estado), write(' - Indice:'), write(Indice), nl.


indicesIDHM(Sexo, Raca, Id, Indice) :-
    Sexo = 'fem', Raca = 'neg' -> calculoIDHM(Id, 1.0, 0.0, 1.0, 0.0, Indice);
    (Sexo = 'fem', Raca = 'bra' -> calculoIDHM(Id, 1.0, 0.0, 0.0, 1.0, Indice));
    (Sexo = 'mas', Raca = 'neg' -> calculoIDHM(Id, 0.0, 1.0, 1.0, 0.0, Indice));
    (Sexo = 'mas', Raca = 'bra' -> calculoIDHM(Id, 0.0, 1.0, 0.0, 1.0, Indice)).


calculoIDHM(Id, PesoF, PesoM, PesoN, PesoB, Indice) :-
    idhm(Id, IDHM), idhmEducacao(Id, IDHMEduc), idhmRenda(Id, IDHMRend), idhmLongevidade(Id, IDHMLong),
    localidade(Id, _, Estado),
    idhmMulheres(Estado, IDHMMul), idhmHomens(Estado, IDHMHom), idhmNegros(Estado, IDHMNeg), idhmBrancos(Estado, IDHMBra),
    idhmEducacaoMulheres(Estado, IDHMEducMul), idhmEducacaoHomens(Estado, IDHMEducHom), idhmEducacaoNegros(Estado, IDHMEducNeg), idhmEducacaoBrancos(Estado, IDHMEducBra),
    idhmRendaMulheres(Estado, IDHMRendMul), idhmRendaHomens(Estado, IDHMRendHom), idhmRendaNegros(Estado, IDHMRendNeg), idhmRendaBrancos(Estado, IDHMRendBra),
    idhmLongevidadeMulheres(Estado, IDHMLongMul), idhmLongevidadeHomens(Estado, IDHMLongHom), idhmLongevidadeNegros(Estado, IDHMLongNeg), idhmLongevidadeBrancos(Estado, IDHMLongBra),
    Indice is (IDHM + IDHMEduc + IDHMRend + IDHMLong) * 0.5 +
              (((IDHMMul + IDHMEducMul + IDHMRendMul + IDHMLongMul) * PesoF) +
              ((IDHMHom + IDHMEducHom + IDHMRendHom + IDHMLongHom) * PesoM) +
              ((IDHMNeg + IDHMEducNeg + IDHMRendNeg + IDHMLongNeg) * PesoN) +
              ((IDHMBra + IDHMEducBra + IDHMRendBra + IDHMLongBra) * PesoB)) * 0.5.

% indiceCriminalidade(Sexo, Raca, Id, Indice)
