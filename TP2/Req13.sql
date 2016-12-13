with R5 as (
	select R4.numc, R4.rang, R4.datedep, V.pays, R4.nbjours
		from (
			select P.numc, R3.rang, P.datedep, R3.villes, R3.nbjours
				from (
					select numc, 0 as rang, vDep as villes, 0 as nbjours --R1
						from agence.lescircuits
					union
					select C.numc, max(E.rang)+1 as rang, varr, 0 as nbjours	--R2
						from agence.lescircuits C join agence.lesetapes E on (C.numc=E.numc)
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
				from R5 R51 join R5 R52 on (R51.numc=R52.numc and R51.dateDep=R52.dateDep and R51.rang>R52.rang)
				group by R51.numc, R51.rang, R51.datedep, R51.pays
				union
			select *
				from R5
				where rang=0
				order by numc, datedep, rang) R61 
		join (
			select R51.numc, R51.rang, R51.datedep, R51.pays, sum(R52.nbJours) as nbj
				from R5 R51 join R5 R52 on (R51.numc=R52.numc and R51.dateDep=R52.dateDep and R51.rang>R52.rang)
				group by R51.numc, R51.rang, R51.datedep, R51.pays
				union
			select *
				from R5
				where rang=0
				order by numc, datedep, rang) R62 
		on (R61.numc=R62.numc and R61.datedep=R62.datedep and R61.pays!=R62.pays and R62.rang=(R61.rang-1))
		union
	select *
		from (
			select R51.numc, R51.rang, R51.datedep, R51.pays, sum(R52.nbJours) as nbj
				from R5 R51 join R5 R52 on (R51.numc=R52.numc and R51.dateDep=R52.dateDep and R51.rang>R52.rang)
				group by R51.numc, R51.rang, R51.datedep, R51.pays
				union
			select *
				from R5
				where rang=0
				order by numc, datedep, rang)
		where rang=0
		order by numc, datedep, rang)
	
	
	
	
R7	with R5 as (
	select R4.numc, R4.rang, R4.datedep, V.pays, R4.nbjours
		from (
			select P.numc, R3.rang, P.datedep, R3.villes, R3.nbjours
				from (
					select numc, 0 as rang, vDep as villes, 0 as nbjours --R1
						from agence.lescircuits
					union
					select C.numc, max(E.rang)+1 as rang, varr, 0 as nbjours	--R2
						from agence.lescircuits C join agence.lesetapes E on (C.numc=E.numc)
						group by C.numc, varr
					union
					select numc, rang, vetape, nbjours
						from agence.lesetapes
					) R3 join agence.lesprogrammations P
						on (R3.numc=P.numc)
				order by P.numc, P.datedep, R3.rang
			) R4 join agence.lesvilles V on (V.nomv=R4.villes)
		order by R4.numc, R4.datedep, R4.rang)
			select R61.numc, R61.rang, R61.datedep, R61.pays, R61.nbj
		from (
			select R51.numc, R51.rang, R51.datedep, R51.pays, sum(R52.nbJours) as nbj
				from R5 R51 join R5 R52 on (R51.numc=R52.numc and R51.dateDep=R52.dateDep and R51.rang>R52.rang)
				group by R51.numc, R51.rang, R51.datedep, R51.pays
				union
			select *
				from R5
				where rang=0
				order by numc, datedep, rang) R61 
		join (
			select R51.numc, R51.rang, R51.datedep, R51.pays, sum(R52.nbJours) as nbj
				from R5 R51 join R5 R52 on (R51.numc=R52.numc and R51.dateDep=R52.dateDep and R51.rang>R52.rang)
				group by R51.numc, R51.rang, R51.datedep, R51.pays
				union
			select *
				from R5
				where rang=0
				order by numc, datedep, rang) R62 
		on (R61.numc=R62.numc and R61.datedep=R62.datedep and R61.pays!=R62.pays and R62.rang=(R61.rang-1))
		union
	select *
		from (
			select R51.numc, R51.rang, R51.datedep, R51.pays, sum(R52.nbJours) as nbj
				from R5 R51 join R5 R52 on (R51.numc=R52.numc and R51.dateDep=R52.dateDep and R51.rang>R52.rang)
				group by R51.numc, R51.rang, R51.datedep, R51.pays
				union
			select *
				from R5
				where rang=0
				order by numc, datedep, rang)
		where rang=0
		order by numc, datedep, rang
	
	
	
R6	with R5 as (
	select R4.numc, R4.rang, R4.datedep, V.pays, R4.nbjours
		from (
			select P.numc, R3.rang, P.datedep, R3.villes, R3.nbjours
				from (
					select numc, 0 as rang, vDep as villes, 0 as nbjours --R1
						from agence.lescircuits
					union
					select C.numc, max(E.rang)+1 as rang, varr, 0 as nbjours	--R2
						from agence.lescircuits C join agence.lesetapes E on (C.numc=E.numc)
						group by C.numc, varr
					union
					select numc, rang, vetape, nbjours
						from agence.lesetapes
					) R3 join agence.lesprogrammations P
						on (R3.numc=P.numc)
				order by P.numc, P.datedep, R3.rang
			) R4 join agence.lesvilles V on (V.nomv=R4.villes)
		order by R4.numc, R4.datedep, R4.rang)
	select R51.numc, R51.rang, R51.datedep, R51.pays, sum(R52.nbJours) as nbj
				from R5 R51 join R5 R52 on (R51.numc=R52.numc and R51.dateDep=R52.dateDep and R51.rang>R52.rang)
				group by R51.numc, R51.rang, R51.datedep, R51.pays
				union
			select *
				from R5
				where rang=0
				order by numc, datedep, rang
	
	