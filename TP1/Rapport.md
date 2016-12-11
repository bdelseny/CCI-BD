
\begin{center}

\huge\bf Compte rendu du TP1 \par

\end{center}

----------------------

\begin{center}

{\bf Auteur:} DELSENY Bastien

{\bf date:} \today

\end{center}

-----------------------


# 1 Quelles sont les dates des repas où on a servi uniquement de l'eau comme boisson ?


## 1.1 Schéma et spécification de la relation résultat de la requête :

R1(\underline{dateR})

$< d > \in R1 \iff \exists (p, v) \text{ tel que} <d, p, v> \in LeMenu$

```SQL
select dateR
	from LeMenu
```



R2(\underline{dateR})

$< d > \in R2 \iff \exists (p, v) \text{ tel que} <d, p, v> \in LeMenu \wedge nomV <> "eau"$

```SQL
select dateR
	from LeMenu
	where nomV <> "eau"
```


R3(\underline{dateR})

*$<d> \in R1 \iff$ La date d correspond aux menus exclusivement avec de l'eau*

$<d> \in R1 \iff d \in R1 - d \in R2$



## 1.2 Requête SQL :

```SQL
select dateR
	from Repas.LeMenu
minus
select dateR
	from Repas.LeMenu
	where nomV <> "eau";
```


## 1.3 Résultat de la requête

|  DATER  |
|---------|
|31-DEC-04|

## 1.4 Test de la requête

- La date du 06 mars 2005 n'est pas dans les résultats car il n'y a pas eu d'eau de servie a ce repas.

- La date du 21 octobre 2003 n'est pas dans les résultat car il y a eu d'autres boissons que de l'eau de servie lors de ce repas.


# 2 Quelles sont les dates des repas où plusieurs boissons différentes ont été servies ?


## 2.1 Shéma et spécification de la relation résultat de la requête :


R1(\underline{dateR})

*$<d> \in R1 \iff$ La date d correspond à une date où des boissons différentes ont été servies*




## 2.2 Requête SQL :

```SQL
select dateR
	from Repas.LeMenu
	group by dateR
	having count(distinct nomV) > 1;
```


## 2.3 Résultat de la requête :

|	DATER	|
|-----------|
| 21-OCT-03	|


## 2.4 Test de la requête :

- Les dates du 31 décembre 2004 et du 06 mars 2005 ne sont pas dans les résultats car il n'y a eu qu'une seule boisson de servie.


# 3 Pour chaque invité, parmi les repas où il a été invité, donner la date de celui le plus ancien dans l'ordre chronologique, ainsi que les plats et les boissons servis ce jour là.


## 3.1 Schéma et spécification de la relation résultat de la requête :

R1(\underline{nomI}, ancDate)

*$< i, d > \in R1 \iff$ La date d est le repas le plus ancien auquel l'invité i a assisté*

```SQL
select nomI, min(dateR) as ancDate
	from LesRepas
	group by nomI
```

R3(\underline{nomI, dateR, nomp}, nomv)

*$<n, d, p, v> \in R2 \iff$ La date d est le repas le plus ancien auquel n a été invité. Lors de ce repas les plats p accompagnés des vins v ont été servis*


## 3.2 Requête SQL :

```SQL
with X as (
	select nomI, min(dateR) as ancDate
		from Repas.LesRepas
		group by nomI)
select X.nomI, X.ancDate, M.nomP, M.nomv
	from Repas.LeMenu M join X on (M.dateR=X.ancDate);
```

## 3.3 Résultat de la requête :


|NOMI                |ANCDATE  |NOMP                |NOMV               |       
|--------------------|---------|--------------------|-------------------|        
|Adrian              |10-OCT-03|                    |                   |        
|Toto                |10-OCT-03|                    |                   |        
|Marie               |21-OCT-03|Mousse chocolat     |eau                |        
|Marie               |21-OCT-03|Ile flottante       |eau                |        
|Marie               |21-OCT-03|Steak hache         |Cote de Nuits      |        
|Marie               |21-OCT-03|Foie gras           |Veuve Cliquot      |        
|Myriam              |21-OCT-03|Steak hache         |Cote de Nuits      |        
|Myriam              |21-OCT-03|Mousse chocolat     |eau                |        
|Myriam              |21-OCT-03|Ile flottante       |eau                |        
|Myriam              |21-OCT-03|Foie gras           |Veuve Cliquot      |        
|Thomas              |21-OCT-03|Mousse chocolat     |eau                |        
|Thomas              |21-OCT-03|Foie gras           |Veuve Cliquot      |        
|Thomas              |21-OCT-03|Steak hache         |Cote de Nuits      |        
|Thomas              |21-OCT-03|Ile flottante       |eau                |        
|Jacques             |31-DEC-04|Medaillon langouste |eau                |        
|Jacques             |31-DEC-04|Mousse chocolat     |eau                |        
|Jacques             |31-DEC-04|Plateau fromages    |eau                |        
|Malou               |31-DEC-04|Medaillon langouste |eau                |        
|Malou               |31-DEC-04|Plateau fromages    |eau                |        
|Malou               |31-DEC-04|Mousse chocolat     |eau                |        
|Patrick             |31-DEC-04|Mousse chocolat     |eau                |        
|Patrick             |31-DEC-04|Medaillon langouste |eau                |        
|Patrick             |31-DEC-04|Plateau fromages    |eau                |        
|Jackie              |06-MAR-05|Mousse chocolat     |Vasse Felix        |        
|Jackie              |06-MAR-05|Pates beurre        |Vasse Felix        |        
|Phil                |06-MAR-05|Mousse chocolat     |Vasse Felix        |        
|Phil                |06-MAR-05|Pates beurre        |Vasse Felix 		|



## 3.4 Test de la requete

- La contrainte d'intégrité suivante : $LeMenu[dateR] = LesRepas[dateR]$ n'est pas respectée dans la base de données.

- Il n'est associé que la date du repas le plus ancien auquel Adrian a assisté. Il a pourtant assisté à 4 repas différents.

- Les plats et boissons du 21 octobre 2003 sont bien repectées et répétées pour chaque personne présente dont c'est le repas le plus ancien.


# 4 Quels sont les amis qui aiment tous les plats servis le 6 mars 2005 ?

## 4.1 Schéma et spécification de la relation résultat de la requête :

R1(\underline{nomP})

*$< p > \in R1 \iff$ Les plats p on t été servis le 06 mars 2005*

```SQL
select nomP
	from LeMenu 
	where dateR='06 mars 2005'
```


R2(\underline{nbP})

*$< nbP > \in R2 \iff$ Le nombre de plats nbP servis le 06 mars 2005*

```SQL
select count(R1.nomP) as nbPlats
	from R1 
```

R3(\underline{nomA}, nbP2)

*$< a, p2 > \in R3 \iff$ Les amis a aiment un nombre p2 de plats servis le 06 mars 2005*

```SQL
select P.nomA, count(P.nomP) as nbPlats2
	from LesPreferences P join R1 on (P.nomP = R1.nomp)
	group by P.nomA 
```



R4(\underline{nomA})

*$< a > \in R4 \iff$ Les amis a aiment tous les plats servis le 06 mars 2005*


## 4.2 Requête SQL

```SQL
with X as (
	select M.nomP
		from Repas.LeMenu M
		where dateR='06-MAR-05')
select nomA
	from (
			select P.nomA, count(P.nomP) as nbPlats2
				from Repas.LesPreferences P join X on (P.nomP = X.nomP)
				group by P.nomA ) Z 
		join (
			select count(X.nomP) as nbPlats
				from X ) Y
		on (Z.nbPlats2 = Y.nbPlats);
```

## 4.3 Résultat de la requête :

| NOMA    |
|---------|
| Adrian  |
| Patrick |


## 4.4 Test de la requête :


- Malou n'est pas dans la table des résultats car il n'aime que la mousse au chocolat parmi les plats présentés le 06 mars 2005.


# 5 Pour chaque invité donner le nombre de fois où il a été invité et le nombre de plats qu'il aime.

Le résultat doit faire apparaître aussi les invités dont on ne connaît pas de préférence (dans ce cas le nombre de plats est 0).

## 5.1 Schéma et spécifiaction de la relation résultat de la requête :

R1(\underline{nomI}, nbI)

*$< i, nbI > \in R1 \iff$ Les invités i ont été invités nbI fois.*

```SQL
select nomI, count(distinct dateR) as nbI
	from LesRepas
	group by nomI 
```

R2(\underline{nomI}, nbI, nbP)

*$< i, nbI, nbP > \in R2 \iff$ Les invités i ont été invités un nombre nbI fois et aiment nbP plats.*


## 5.2 Reqête SQL :

```SQL
with X as (
	select nomI, count(distinct dateR) as nbI
		from Repas.LesRepas
		group by nomI )
select X.nomI, nbI, count(P.nomP) as nbP
	from Repas.LesPreferences P right outer join X on (P.nomA = X.nomI)
	group by X.nomI, nbI;
```

## 5.3 Résultat de la requête :

|NOMI                |        NBI| NBP			|                                   
|--------------------|-----------|--------------|                                   
|Adrian              |          4|            11|                                   
|Thomas              |          2|             1|                                   
|Myriam              |          1|             0|                                   
|Jacques             |          1|             1|                                   
|Toto                |          1|             0|                                   
|Patrick             |          1|             3|                                   
|Jackie              |          1|             1|                                   
|Phil                |          1|             1|                                   
|Malou               |          1|             3|                                  
|Marie               |          3|             0|


## 5.4 Test de la requête :

- Toto n'est pas un ami, il n'est donc pas dans la table des préférences et on ne connaît donc pas les plats qu'il aime. On obtient donc 0 pour ses préférences.









