
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

*$< n > \in R1 \iff \text{n est une ville d'Angleterre}$*

```SQL
select nomV
	from LesVilles
	where pays='Angleterre';
```



#### R2(\underline{numC, nb})

*$< nC, nb > \in R2 \iff \text{nC est un numéro de circuit qui visite nb villes d'Angleterre}$*

```SQL
select numC, count(distinct vEtape) as nb
	from R1 join LesEtapes E on (R1.nomV=E.vEtape)
	group by numC;
```

#### R3(\underline{numC, nb})

*$< nC, nb > \in R3 \iff \text{nC est un numéro de circuit qui a nb villes d'Angleterre pour départ}$*

```SQL
select numC, count(distinct vDep) as nb
	from R1 join LesEtapes E on (R1.nomV=E.vDep)
	group by numC;
```


#### R4(\underline{numC, nb})

*$< nC, nb > \in R4 \iff \text{nC est un numéro de circuit qui a nb villes d'Angleterre pour arrivées}$*

```SQL
select numC, count(distinct vArr) as nb
	from R1 join LesEtapes E on (R1.nomV=E.vArr)
	group by numC;
```


#### R5(\underline{nbv})

*$< nbv > \in R5 \iff \text{nbv le nombre de villes visitables (départ et arrivée compris) d'Angleterre}$*

```SQL
select count(nomV) as nbv
	from LesVilles
	where pays='Angleterre';
```

#### R6(\underline{numC})

*$< nC > \in R6 \iff \text{nC est le numéro du circuit passant par toutes les villes d'Angleterre}$*


```SQL
select numC
	from R2 union R3 union R4
	group by numC
	having sum(nb)=R5;
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
|:-----------:|
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
|:-----------:|
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
|:---------------:|
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
|:---------------:|
|6				|


#### Résultat de la requête R6

| numC	|
|:---------------:|
|9				|



\clearpage


# 2 Donner le numéro, le prix de base (sans tenir compte du prix des monuments visités), la date de départ et le nombre de places disponibles des programmations qui ont encore des places disponibles et dont le nombre de jours est inférieur ou égal à un entier donné.


## 2.1 Schéma et spécification de la relation résultat de la requête :

#### R1(\underline{numC})

*$< nC > \in R1 \iff \text{nC le numéro du circuit dont le séjour dure moins de 5 jours.}$*

```SQL
select numc
	from agence.lesetapes
	group by numc
	having sum(nbjours)<=5;
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
	order by P.numc, P.dateDep;
```


#### R3(\underline{numC, dateDep}, nbP, prix)

*$< nC, d, nbp, p > \in R2 \iff \text{nC et d le numéro du circuit et la date de départ}$* 
*$\text{pour le circuit auquel il reste nbp places disponibles et de prix p.}$*

```SQL
select R2.numc, R2.datedep, R2.nbp, C.prix
	from agence.lescircuits C join R2 on (C.numc=R2.numc);
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

\clearpage

# 3 Pour chaque programmation de circuit, retrouver les pays dans lesquels passe le circuit et la date à laquelle le circuit arrive dans ce pays.


## 3.1 Schéma et spécification de la relation résultat de la requête :

#### R1(\underline{numC, rang}, vDep, nbJours)

*$< c, r, v, j > \in R1 \iff \text{v la ville de départ du circuit c, de rang r et de j jours de visites.}$*

```SQL
select numc, 0 as rang, vDep, 0 as nbJours
	from agence.lescircuits;
```

#### R2(\underline{numC, rang}, vArr, nbJours)

*$< c, r, v, j > \in R1 \iff \text{v la ville d'arrivée du circuit c, de rang r et de j jours de visites.}$*

```SQL
select C.numc, max(E.rang)+1 as rang, varr, 0 as nbjours
	from agence.lescircuits C join agence.lesetapes E on (C.numc=E.numc)
	group by C.numc, varr;
```

#### R3(\underline{numC, rang}, villes, nbJours)

*$< c, r, v, j > \in R1 \iff \text{v la ville de rang r par laquelle passe pendant j jours le circuit c.}$*

```SQL
R1
union
R2
union
	select numc, rang, vetape, nbjours
		from agence.lesetapes;
```

#### R4(\underline{numC, rang, dateDep}, villes, nbJours)

*$< c, r, d, v, j > \in R1 \iff \text{v la ville de rang r par laquelle passe pendant j jours}$*
*$\text{le circuit c de date de départ d.}$*

```SQL
select P.numc, R3.rang, P.datedep, R3.villes, R3.nbjours
	from R3 join agence.lesprogrammations P
			on (R3.numc=P.numc)
	order by P.numc, P.datedep, R3.rang;
```

#### R5(\underline{numC, rang, dateDep}, pays, nbJours)

*$< c, r, d, p, j > \in R1 \iff \text{p le pays de rang r par lequelle passe pendant j jours}$*
*$\text{le circuit c de date de depart d.}$*

```SQL
select R4.numc, R4.rang, R4.datedep, V.pays, R4.nbjours
	from R4 join agence.lesvilles V on (V.nomv=R4.villes)
	order by R4.numc, R4.datedep, R4.rang;
```

#### R6(\underline{numC, rang, dateDep}, pays, nbj)

*$< c, r, d, p, j > \in R1 \iff \text{p le pays de rang r par lequelle passe le circuit c}$*
*$\text{de date de depart d et de jours d'arrivee j pour chaque ville du pays.}$*

```SQL
select R51.numc, R51.rang, R51.datedep, R51.pays, sum(R52.nbJours) as nbj
	from R5 R51 join R5 R52 on (R51.numc=R52.numc 
		and R51.dateDep=R52.dateDep and R51.rang>R52.rang)
	group by R51.numc, R51.rang, R51.datedep, R51.pays
union
select *
	from R5
	where rang=0 --Pour garder les pays de départ
	order by numc, datedep, rang;
```

#### R7(\underline{numC, rang, dateDep}, pays, nbj)

*$< c, r, d, p, j > \in R1 \iff \text{p le pays de rang r par lequelle passe le circuit c}$*
*$\text{de date de depart d et de jours d'arrivée j.}$*

```SQL
select R61.numc, R61.rang, R61.datedep, R61.pays, R61.nbj
	from R6 R61 join R6 R62 on (R61.numc=R62.numc 
		and R61.datedep=R62.datedep
		and R61.pays!=R62.pays and R62.rang=(R61.rang-1))
union
select *
	from R6
	where rang=0 --Pour garder les pays de départ
	order by numc, datedep, rang;
```

#### R8(\underline{numC, dateDep}, pays, dateEntree)

*$< c, r, d, p, dE > \in R1 \iff \text{p le pays de rang r par lequelle passe}$*
*$\text{à la date dE le circuit c de date de départ d.}$*

```SQL
select numc, datedep, pays, (nbj+datedep) as dateEntree
	from R7;
```

## 3.2 Tests

### Tableau test 1 : T1

	NUMC	 	VDEP		VARR
------------ ------------ ----------
1				Londres		Paris
2				Paris		Paris
3				Paris		Paris


#### Resultats attendus de la requete R1 avec T1


	NUMC		RANG 	VDEP		NBJOURS
------------ -------- ------------ ----------
1				0		Londres		0
2				0		Paris		0
3				0		Paris		0


### Tableau test 2 : T2


	NUMC		RANG 	VETAPE			NBJOURS
------------ -------- -------------- -----------
1				1		Paris			2
1				2		Toulouse		2
1				3		Paris			1
2				1		Paris			1
2				2		Toulouse		1
3				1		Londres			3
3				2		Canterburry		2
3				3		Londres			5


#### Resultats attendus de la requete R2 avec T1 et T2

	NUMC		RANG 	VARR		NBJOURS
------------ -------- ------------ ----------
1				4		Paris		0
2				3		Paris		0
3				4		Paris		0

#### Resultats attendus de la requete R3 avec T1 et T2

	NUMC		RANG 	VILLES			NBJOURS
------------ -------- -------------- -----------
1				0		Londres			0
1				1		Paris			2
1				2		Toulouse		2
1				3		Paris			1
1				4		Paris			0
2				0		Paris			0
2				1		Paris			1
2				2		Toulouse		1
2				3		Paris			0
3				0		Paris			0
3				1		Londres			3
3				2		Canterburry		2
3				3		Londres			5
3				4		Paris			0

### Tableau test 3 : T3

	NUMC		DATEDEP 	
------------ --------------
1				11-DEC-10	
2				11-DEC-10	
2				01-JAN-11	
3				02-JAN-11	

#### Resultats attendus de la requete R4 avec T1, T2, T3

	NUMC		DATEDEP 		RANG 	VILLES			NBJOURS
------------ -------------- -------- -------------- -----------
1				11-DEC-10		0		Londres			0
1				11-DEC-10		1		Paris			2
1				11-DEC-10		2		Toulouse		2
1				11-DEC-10		3		Paris			1
1				11-DEC-10		4		Paris			0
2				11-DEC-10		0		Paris			0
2				11-DEC-10		1		Paris			1
2				11-DEC-10		2		Toulouse		1
2				11-DEC-10		3		Paris			0
2				01-JAN-11		0		Paris			0
2				01-JAN-11		1		Paris			1
2				01-JAN-11		2		Toulouse		1
2				01-JAN-11		3		Paris			0
3				02-JAN-11		0		Paris			0
3				02-JAN-11		1		Londres			3
3				02-JAN-11		2		Canterburry		2
3				02-JAN-11		3		Londres			5
3				02-JAN-11		4		Paris			0

### Tableau test 4 : T4

	NOMV		Pays 	
------------ --------------
Paris			France
Toulouse		France
Agen			France
Londres			Angleterre
Canterburry		Angleterre
Rome			Italie

#### Resultats attendus de la requete R5 avec T1, T2, T3, T4

	NUMC		DATEDEP 		RANG 	PAYS			NBJOURS
------------ -------------- -------- -------------- -----------
1				11-DEC-10		0		Angleterre			0
1				11-DEC-10		1		France			2
1				11-DEC-10		2		France			2
1				11-DEC-10		3		France			1
1				11-DEC-10		4		France			0
2				11-DEC-10		0		France			0
2				11-DEC-10		1		France			1
2				11-DEC-10		2		France			1
2				11-DEC-10		3		France			0
2				01-JAN-11		0		France			0
2				01-JAN-11		1		France			1
2				01-JAN-11		2		France			1
2				01-JAN-11		3		France			0
3				02-JAN-11		0		France			0
3				02-JAN-11		1		Angleterre			3
3				02-JAN-11		2		Angleterre		2
3				02-JAN-11		3		Angleterre			5
3				02-JAN-11		4		France			0

#### Resultats attendus de la requete R6 avec T1, T2, T3, T4

	NUMC		DATEDEP 		RANG 	PAYS			NBJOURS
------------ -------------- -------- -------------- -----------
1				11-DEC-10		0		Angleterre		0
1				11-DEC-10		1		France			0
1				11-DEC-10		2		France			2
1				11-DEC-10		3		France			4
1				11-DEC-10		4		France			5
2				11-DEC-10		0		France			0
2				11-DEC-10		1		France			0
2				11-DEC-10		2		France			1
2				11-DEC-10		3		France			2
2				01-JAN-11		0		France			0
2				01-JAN-11		1		France			0
2				01-JAN-11		2		France			1
2				01-JAN-11		3		France			2
3				02-JAN-11		0		France			0
3				02-JAN-11		1		Angleterre		0
3				02-JAN-11		2		Angleterre		3
3				02-JAN-11		3		Angleterre		5
3				02-JAN-11		4		France			10

#### Resultats attendus de la requete R7 avec T1, T2, T3, T4

	NUMC		DATEDEP 		RANG 	PAYS			NBJOURS
------------ -------------- -------- -------------- -----------
1				11-DEC-10		0		Angleterre		0
1				11-DEC-10		1		France			0
2				11-DEC-10		0		France			0
2				01-JAN-11		0		France			0
3				02-JAN-11		0		France			0
3				02-JAN-11		1		Angleterre		0
3				02-JAN-11		4		France			10

#### Resultats attendus de la requete R8 avec T1, T2, T3, T4

	NUMC		DATEDEP 		RANG 	PAYS			DATEENTREE
------------ -------------- -------- -------------- --------------
1				11-DEC-10		0		Angleterre		11-DEC-10
1				11-DEC-10		1		France			11-DEC-10
2				11-DEC-10		0		France			11-DEC-10
2				01-JAN-11		0		France			01-JAN-11
3				02-JAN-11		0		France			02-JAN-11
3				02-JAN-11		1		Angleterre		02-JAN-11
3				02-JAN-11		4		France			12-JAN-11

## 3.3 Requête SQL :

```SQL
with R5 as (
	select R4.numc, R4.rang, R4.datedep, V.pays, R4.nbjours
		from (
			select P.numc, R3.rang, P.datedep, R3.villes, R3.nbjours
				from (
					select numc, 0 as rang, vDep as villes, 0 as nbjours --R1
						from agence.lescircuits
					union
					select C.numc, max(E.rang)+1 as rang, varr, 0 as nbjours	--R2
						from agence.lescircuits C join agence.lesetapes E
							on (C.numc=E.numc)
						group by C.numc, varr
					union
					select numc, rang, vetape, nbjours
						from agence.lesetapes
					) R3 join agence.lesprogrammations P
						on (R3.numc=P.numc)
				order by P.numc, P.datedep, R3.rang
			) R4 join agence.lesvilles V on (V.nomv=R4.villes)
		order by R4.numc, R4.datedep, R4.rang)
select numc, datedep, pays, (nbj+datedep) as dateEntree
	from (
			select R61.numc, R61.rang, R61.datedep, R61.pays, R61.nbj
		from (
			select R51.numc, R51.rang, R51.datedep, R51.pays, sum(R52.nbJours) as nbj
				from R5 R51 join R5 R52 on (R51.numc=R52.numc 
					and R51.dateDep=R52.dateDep and R51.rang>R52.rang)
				group by R51.numc, R51.rang, R51.datedep, R51.pays
				union
			select *
				from R5
				where rang=0
				order by numc, datedep, rang) R61 
		join (
			select R51.numc, R51.rang, R51.datedep, R51.pays, sum(R52.nbJours) as nbj
				from R5 R51 join R5 R52 on (R51.numc=R52.numc 
					and R51.dateDep=R52.dateDep and R51.rang>R52.rang)
				group by R51.numc, R51.rang, R51.datedep, R51.pays
				union
			select *
				from R5
				where rang=0
				order by numc, datedep, rang) R62 
		on (R61.numc=R62.numc and R61.datedep=R62.datedep 
			and R61.pays!=R62.pays and R62.rang=(R61.rang-1))
		union
	select *
		from (
			select R51.numc, R51.rang, R51.datedep, R51.pays, sum(R52.nbJours) as nbj
				from R5 R51 join R5 R52 on (R51.numc=R52.numc 
					and R51.dateDep=R52.dateDep and R51.rang>R52.rang)
				group by R51.numc, R51.rang, R51.datedep, R51.pays
				union
			select *
				from R5
				where rang=0
				order by numc, datedep, rang)
		where rang=0
		order by numc, datedep, rang);
```

## 2.4 Résultats des requêtes

### 2.4.1 Resultats de la requête R1

      NUMC       RANG VILLES                  NBJOURS                           
---------- ---------- -------------------- ----------                           
         1          0 Paris                         0                           
         2          0 Paris                         0                           
         3          0 Paris                         0                           
         4          0 Paris                         0                           
...				...				...			...                         
...				...				...			...                                
        19          0 Rome                          0                           
        21          0 Paris                         0                           
        20          0 Briancon                      0                           

21 rows selected.

### 2.4.2 Resultats de la requête R2

      NUMC       RANG VARR                    NBJOURS                           
---------- ---------- -------------------- ----------                           
         4          2 Paris                         0                           
        18          6 Paris                         0                           
        20          2 Briancon                      0                           
         7          6 Hoedic                        0                         
...				...				...			...                         
...				...				...			...                                 
        11          8 Shannon                       0                           
        12          8 Dublin                        0                           
        19         14 Rome                          0                           

21 rows selected.

### 2.4.3 Resultats de la requête R3

      NUMC       RANG VILLES                  NBJOURS                           
---------- ---------- -------------------- ----------                           
         1          0 Paris                         0                           
         1          1 Londres                       2                           
         1          2 Paris                         0                           
         2          0 Paris                         0                           
         2          1 Londres                       2
...				...				...			...                         
...				...				...			...                                  
        21         11 Ravenne                       2                           
        21         12 Verone                        1                           
        21         13 Venise                        3                           
        21         14 Rome                          0                           

151 rows selected.

### 2.4.4 Resultats de la requête R4

      NUMC       RANG DATEDEP   VILLES                  NBJOURS                 
---------- ---------- --------- -------------------- ----------                 
         1          0 04-JAN-10 Paris                         0                 
         1          1 04-JAN-10 Londres                       2                 
         1          2 04-JAN-10 Paris                         0                 
         1          0 04-FEB-10 Paris                         0                 
         1          1 04-FEB-10 Londres                       2                 
         1          2 04-FEB-10 Paris                         0                 
         1          0 06-FEB-10 Paris                         0 
...				...		...			...      		    ...               
...				...		...			...       			   ...               
        21         10 06-APR-10 Florence                      3                 
        21         11 06-APR-10 Ravenne                       2                 
        21         12 06-APR-10 Verone                        1                 
        21         13 06-APR-10 Venise                        3                 
        21         14 06-APR-10 Rome                          0                 

654 rows selected.


### 2.4.5 Resultats de la requête R5

      NUMC       RANG DATEDEP   PAYS                    NBJOURS                 
---------- ---------- --------- -------------------- ----------                 
         1          0 04-JAN-10 France                        0                 
         1          1 04-JAN-10 Angleterre                    2                 
         1          2 04-JAN-10 France                        0                 
         1          0 04-FEB-10 France                        0                 
         1          1 04-FEB-10 Angleterre                    2                 
         1          2 04-FEB-10 France                        0                 
         1          0 06-FEB-10 France                        0 
...				...		...			...      		    ...               
...				...		...			...       			   ...                      
        21         10 06-APR-10 Italie                        3                 
        21         11 06-APR-10 Italie                        2                 
        21         12 06-APR-10 Italie                        1                 
        21         13 06-APR-10 Italie                        3                 
        21         14 06-APR-10 Italie                        0                 

654 rows selected.

### 2.4.6 Resultats de la requête R6

      NUMC       RANG DATEDEP   PAYS                        NBJ                 
---------- ---------- --------- -------------------- ----------                 
         1          0 04-JAN-10 France                        0                 
         1          1 04-JAN-10 Angleterre                    0                 
         1          2 04-JAN-10 France                        2                 
         1          0 04-FEB-10 France                        0                 
         1          1 04-FEB-10 Angleterre                    0                 
         1          2 04-FEB-10 France                        2                 
         1          0 06-FEB-10 France                        0
...				...		...			...      		    ...               
...				...		...			...       			   ...                     
        21         10 06-APR-10 Italie                       13                 
        21         11 06-APR-10 Italie                       16                 
        21         12 06-APR-10 Italie                       18                 
        21         13 06-APR-10 Italie                       19                 
        21         14 06-APR-10 Italie                       22                 

654 rows selected.

### 2.4.7 Resultats de la requête R7

      NUMC       RANG DATEDEP   PAYS                        NBJ                 
---------- ---------- --------- -------------------- ----------                 
         1          0 04-JAN-10 France                        0                 
         1          1 04-JAN-10 Angleterre                    0                 
         1          2 04-JAN-10 France                        2                 
         1          0 04-FEB-10 France                        0                 
         1          1 04-FEB-10 Angleterre                    0                 
         1          2 04-FEB-10 France                        2                 
         1          0 06-FEB-10 France                        0   
...				...		...			...      		    ...               
...				...		...			...       			   ...                     
        21          1 25-JAN-10 Finlande                      0                 
        21          2 25-JAN-10 Norvege                       2                 
        21          9 25-JAN-10 Italie                       10                 
        21          0 26-FEB-10 France                        0                 
        21          1 26-FEB-10 Finlande                      0                 
        21          2 26-FEB-10 Norvege                       2                 
        21          9 26-FEB-10 Italie                       10                 
        21          0 06-APR-10 France                        0                 
        21          1 06-APR-10 Finlande                      0                 
        21          2 06-APR-10 Norvege                       2                 
        21          9 06-APR-10 Italie                       10                 

198 rows selected.

### 2.4.8 Resultats de la requête R8

      NUMC DATEDEP   PAYS                 DATEENTRE                             
---------- --------- -------------------- ---------                             
         1 04-JAN-10 France               04-JAN-10                             
         1 04-JAN-10 Angleterre           04-JAN-10                             
         1 04-JAN-10 France               06-JAN-10                             
         1 04-FEB-10 France               04-FEB-10                             
         1 04-FEB-10 Angleterre           04-FEB-10                             
         1 04-FEB-10 France               06-FEB-10                             
         1 06-FEB-10 France               06-FEB-10
...				...				...			...                       
...				...				...			...                                  
        21 26-FEB-10 Norvege              28-FEB-10                             
        21 26-FEB-10 Italie               08-MAR-10                             
        21 06-APR-10 France               06-APR-10                             
        21 06-APR-10 Finlande             06-APR-10                             
        21 06-APR-10 Norvege              08-APR-10                             
        21 06-APR-10 Italie               16-APR-10                             

198 rows selected.        



