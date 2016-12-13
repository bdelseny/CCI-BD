select R4.numc, R4.rang, R4.datedep, V.pays, R4.nbjours
	from (
		select P.numc, R3.rang, P.datedep, R3.villes, R3.nbjours
			from (
				select numc, 0 as rang, vDep as villes, 0 as nbjours --R1
					from agence.lescircuits
				union
				select numc, 42, varr, 0	--R2
					from agence.lescircuits
				union
				select numc, rang, vetape, nbjours
					from agence.lesetapes
				) R3 join agence.lesprogrammations P
					on (R3.numc=P.numc)
			order by P.numc, P.datedep, R3.rang
		) R4 join agence.lesvilles V on (V.nomv=R4.villes)
	order by R4.numc, R4.datedep, R4.rang
