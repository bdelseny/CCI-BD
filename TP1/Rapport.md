
\begin{center}

\huge\bf Compte rendu du TP1 \par

\end{center}

----------------------

\begin{center}

{\bf Auteur:} DELSENY Bastien

{\bf date:} \today

\end{center}

-----------------------


# 1 Quelles sont les dates des repas où on a servi uniqueemnt de l'eau comme boisson ?


## 1.1 Shéma et spécification de la relation résultat de la requête :

R1(\underline{dateR})

*$<d> \in R1 \iff$ La date d correspond aux menus exclusivement avec de l'eau*

$<d> \in R1 \iff \exists  (p, v) \text{ tel que} <d, p, v> \in LeMenu - \exists (p, v) \text{ tel que} <d, p, v> \in LeMenu \wedge nomV <> "eau"$



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



# 2 Quelles sont les dates des repas où plusieurs boissons différentes ont été servies ?


## 2.1 Shéma et spécification de la relation résultat de la requête :


R2(\underline{dateR})

*$<d> \in R2 \iff$ La date d correspond à une date où des boissons différentes ont été servies*

$<d> \in R2 \iff \exists (p, v) \text{ tel que} <d, p, v> \in LeMenu \wedge$



## 2.2 Requête SQL :

```SQL
select dateR
	from Repas.LeMenu
	group by dateR
	having count(distinct nomV) > 1;
```


## 2.3 Résultat de la requête :

|	DateR	|
|-----------|
| 21-OCT-03	|


## 2.4 Test de la requête :



# 3 Pour chaque invité, parmi les repas où il a été invité, donner la date de celui le plus ancien dans l'ordre chronologique, ainsi que les plats et les boissons servis ce jour là.


## 2.1 Shéma et spécification de la relation résultat de la requête :

R3(\underline{nomI, dateR, nomp}, nomv)

*$<n, d, p, v> \in R2 \iff$ La date d est le repas le plus ancien auquel n a été invité. Lors de ce repas les plats p accompagnés des vins v ont été servis*


## 2.2 Requête SQL :

```SQL
with X as (
	select nomI, min(dateR) as ancDate
		from Repas.LesRepas
		group by nomI)
select X.nomI, X.ancDate, M.nomP, M.nomv
	from Repas.LeMenu M join X on (M.dateR=X.ancDate);
```

## 2.3 Résultat de la requête :


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




















