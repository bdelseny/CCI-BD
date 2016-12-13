
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

#### R3(\underline{numC, nb})

*$< nC, nb > \in R3 \iff \text{nC est un numéro de circuit qui a nb villes d'Angleterre pour départ}$*

```SQL
select numC, count(distinct vDep) as nb
	from R1 join LesEtapes E on (R1.nomV=E.vDep)
	group by numC
```


#### R4(\underline{numC, nb})

*$< nC, nb > \in R4 \iff \text{nC est un numéro de circuit qui a nb villes d'Angleterre pour arrivées}$*

```SQL
select numC, count(distinct vArr) as nb
	from R1 join LesEtapes E on (R1.nomV=E.vArr)
	group by numC
```


#### R5(\underline{nbv})

*$< nbv > \in R5 \iff \text{nbv le nombre de villes visitables (départ et arrivée compris) d'Angleterre}$*

```SQL
select count(nomV) as nbv
	from LesVilles
	where pays='Angleterre'
```

#### R6(\underline{numC})

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



-----------------------


# 2 Donner le numéro, le prix de base (sans tenir compte du prix des monuments visités), la date de départ et le nombre de places disponibles des programmations qui ont encore des places disponibles et dont le nombre de jours est inférieur ou égal à un entier donné.


## 2.1 Schéma et spécification de la relation résultat de la requête :

#### R1(\underline{numC})

*$< nC > \in R1 \iff \text{nC le numéro du circuit dont le séjour dure moins de 5 jours.}$*

```SQL
select numc
	from agence.lesetapes
	group by numc
	having sum(nbjours)<=5
```

#### R2(\underline{numC, dateDep}, nbP)

*$< nC, d, nbp > \in R2 \iff \text{nC et d le numéro du circuit et la date de départ}$* 
*$\text{pour le circuit auquel il reste nbp places disponibles.}$*

```SQL
select P.numc, P.datedep, (nbplaces-sum(nbres)) as nbp
	from R1 join
			agence.lesprogrammations P on (R1.numc=P.numc)
		left outer join
			agence.lesreservations Re on (P.datedep=Re.datedep)
	group by P.numc, P.datedep, nbplaces
	having(nbplaces-sum(nbres))>0
	order by P.numc, P.dateDep
```


#### R3(\underline{numC, dateDep}, nbP, prix)

*$< nC, d, nbp, p > \in R2 \iff \text{nC et d le numéro du circuit et la date de départ}$* 
*$\text{pour le circuit auquel il reste nbp places disponibles et de prix p.}$*

```SQL
select R2.numc, R2.datedep, R2.nbp, C.prix
	from agence.lescircuits C join R2 on (C.numc=R2.numc)
```


## 2.2 Tests

### Tableau test 1 : T1

	NUMC	 	NBJOURS
------------ ------------
1				2
1				3
2				3
2				3
3				2
4				10


#### Resultats attendus de la requete R1 avec T1

|	NUMC	|
|:-----------:|
|1			|
|3			|


### Tableau test 2 : T2 LesProgrammations

      NUMC DATEDEP     NBPLACES
---------- --------- ----------
         1 04-JAN-10         5
         1 21-JUL-10          8
         1 24-JUL-10          2
         2 05-SEP-10         28
         3 24-DEC-09         2
         3 31-DEC-09         5

		 
### Tableau test 2 : T2bis LesReservations

      NUMC DATEDEP     NBRES
---------- --------- ----------
         1 04-JAN-10         5
         1 21-JUL-10          3
         1 24-JUL-10          0
         2 05-SEP-10         2
         3 24-DEC-09         2
         3 31-DEC-09         2

#### Resultats attendus de la requete R2 avec T1, T2 et T2bis

      NUMC DATEDEP     NBP
---------- --------- ----------
         1 21-JUL-10          5
         1 24-JUL-10          2
         3 31-DEC-09         3
		 
### Tableau test 3 : T3 LesReservations

      NUMC PRIX    
---------- --------- 
         1 1000
         2 2500
         3 3000

#### Resultats attendus de la requete R3 avec T1, T2, T2bis et T3

      NUMC DATEDEP     NBP		PRIX
---------- --------- ---------- ------
         1 21-JUL-10          5	1000
         1 24-JUL-10          2	1000
         3 31-DEC-09         3	3000



## 2.3 Requête SQL :

```SQL
select R2.numc, R2.datedep, R2.nbp, C.prix
	from agence.lescircuits C join (
		select P.numc, P.datedep, (nbplaces-sum(nbres)) as nbp
			from (
				select numc
					from agence.lesetapes
					group by numc
					having sum(nbjours)<=5
				) R1 join
					agence.lesprogrammations P on (R1.numc=P.numc)
				left outer join
					agence.lesreservations Re on (P.datedep=Re.datedep)
			group by P.numc, P.datedep, nbplaces
			having(nbplaces-sum(nbres))>0
			order by P.numc, P.dateDep
	) R2 on (C.numc=R2.numc);

```

## 2.4 Résultats des requêtes

#### Résultat de la requête R1

|      NUMC |
|:-----------:|
|	1		|
|	2		|
|	3		|
|	4		|
|	5		|
|	6		|



#### Résultat de la requête R2

      NUMC DATEDEP          NBP
---------- --------- ----------
         1 04-FEB-10          8
         2 07-JAN-10          9
         3 03-JUL-10          1
         4 30-JUN-10         11
         5 31-AUG-10         64
         5 06-NOV-10          3


#### Résultat de la requête R3

 NUMC		 DATEDEP       NBP     PRIX
---------- --------- ---------- ----------
         1 04-FEB-10          8       1160
         2 07-JAN-10          9       1160
         3 03-JUL-10          1       1040
         4 30-JUN-10         11       1270
         5 31-AUG-10         64       2740
         5 06-NOV-10          3       2740


# 3 


## 3.1 Schéma et spécification de la relation résultat de la requête :

#### R1(\underline{numC}, rang, vDep, nbJours)

*$< c, r, v, j > \in R1 \iff \text{v la ville de départ du circuit c, de rang r et de j jours de visites.}$*

```SQL
select numc, 0 as rang, vDep, 0 as nbJours
	from agence.lescircuits
```

## 3.3 Requête SQL :

```SQL

```







