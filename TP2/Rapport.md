
\begin{center}

\huge\bf Compte rendu du TP2 \par

\end{center}

----------------------

\begin{center}

{\bf Auteur:} DELSENY Bastien

{\bf date:} \today

\end{center}

-----------------------


# 1 Donner la liste des numéros des circuits qui passent dans toutes les villes d'un pays donné.


## 1.1 Schéma et spécification de la relation résultat de la requête :

#### R1(\underline{nomV})

*$< n > \in R1 \iff \text{n est une ville de circuit d'Angleterre}$*

```SQL
select nomV
	from LesVilles
	where pays='Angleterre'
```



#### R2(\underline{numC, nb})

*$< nC, nb > \in R2 \iff \text{nC est un numéro de circuit qui visite nb villes d'Angleterre}$*

```SQL
select numC, count(distinct vEtape) as nb
	from R1 join LesEtapes E on (R1.nomV=E.vEtape)
	group by numC
```

R3(\underline{numC, nb})

*$< nC, nb > \in R3 \iff \text{nC est un numéro de circuit qui a nb villes d'Angleterre pour départ}$*

```SQL
select numC, count(distinct vDep) as nb
	from R1 join LesEtapes E on (R1.nomV=E.vDep)
	group by numC
```


R4(\underline{numC, nb})

*$< nC, nb > \in R4 \iff \text{nC est un numéro de circuit qui a nb villes d'Angleterre pour arrivées}$*

```SQL
select numC, count(distinct vArr) as nb
	from R1 join LesEtapes E on (R1.nomV=E.vArr)
	group by numC
```


R5(\underline{nbv})

*$< nbv > \in R5 \iff \text{nbv le nombre de villes visitables (départ et arrivée compris) d'Angleterre}$*

```SQL
select count(nomV) as nbv
	from LesVilles
	where pays='Angleterre'
```

R6(\underline{numC})

*$< nC > \in R6 \iff \text{nC est le numéro du circuit passant par toutes les villes d'Angleterre}$*


```SQL
select numC
	from R2 union R3 union R4
	group by numC
	having sum(nb)=R5
```

## 1.2 Tests

### Tableau test 1 : T1


|	Pays		|	Ville 		|
|---------------|---------------|
|Angleterre		| Londres		|
|Angleterre		| Canterburry	|
|France			| Paris 		|

#### Resultats attendus de la requete R1 avec T1

|	Ville		|
|---------------|
| Londres		|
| Canterburry	|

#### Resultats attendus de la requete R5 avec T1

|	nbv		|
|-----------|
|2			|

### Tableau test 2 : T2


|	Pays		|	Ville 		|
|---------------|---------------|
|France			| Paris 		|

#### Resultats attendus de la requete R1 avec T2

|	Ville		|
|---------------|

#### Resultats attendus de la requete R5 avec T2

|	nbv		|
|-----------|
| 0			|

### Tableau test 3 : T3


|numc	|	Ville 		|
|-------|---------------|
|6		| Londres		|
|6		| Canterburry	|
|7		| Londres		|
|8		| Paris 		|


#### Resultats attendus de la requete R2 avec T3 et T1


|	numC		|	nb 		|
|---------------|-----------|
|	6			| 2 		|
|	7			| 1 		|


### Tableau test 4 : T4


|numC	|	vDep		| vArr		|
|-------|---------------|-----------|
|7		| Paris			|Canterburry|
|8		| Londres		|Paris		|
|9		| Paris 		|Paris		|


#### Resultats attendus de la requete R3 avec T4 et T1


|	numC		|	nb 		|
|---------------|-----------|
|	7			| 1 		|

#### Resultats attendus de la requete R3 avec T4 et T1


|	numC		|	nb 		|
|---------------|-----------|
|	8			| 1 		|

#### Resultats attendus de la requete R6 avec T4, T3 et T1

|	numC		|
|---------------|
|6				|
|7				|

## 1.3 Requête SQL :

```SQL
select numc
	from(
		select numc, count(distinct vetape) as nb
			from (
				select nomv
					from agence.lesvilles
					where pays='Angleterre'
				) X
				join agence.lesetapes E 
				on (X.nomv = E.vetape)
			group by numc
		union
		select numc, count(vDep) as nb
			from (
				select nomv
					from agence.lesvilles
					where pays='Angleterre'
				) X
				join agence.lescircuits C1
				on (X.nomv = C1.vDep)
			group by numc
		union
		select numc, count(vArr) as nb
			from (
				select nomv
					from agence.lesvilles
					where pays='Angleterre'
				) X
				join agence.lescircuits C2
				on (X.nomv = C2.vArr)
			group by numc
		)
	group by numc	
	having sum(nb)=(
		select count(nomv)
			from agence.lesvilles 
			where pays='Angleterre');
```

## 1.4 Résultats des requêtes

#### Résultat de la requête R1

| nomV			|
|---------------|
|Londres		|
|St Ives		|
|Sissinghurst	|
|Exeter			|
|Bath			|
|Salisbury		|

#### Résultat de la requête R2

| numC	|nb	|
|-------|---|
|1		|1	|
|2		|1	|
|9		|6	|

#### Résultat de la requête R3

*no rows selected*

#### Résultat de la requête R4

*no rows selected*

#### Résultat de la requête R5

| count(nomV)	|
|---------------|
|6				|


#### Résultat de la requête R6

| numC	|
|---------------|
|9				|










