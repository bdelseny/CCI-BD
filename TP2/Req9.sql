
spool Req9.lst

	select numc
	from(
		select numc, count(distinct vetape) as nb
		from (select nomv
				from agence.lesvilles
				where pays='Angleterre'
				) X
				join agence.lesetapes E 
				on (X.nomv = E.vetape)
				group by numc
		union
		select numc, count(vDep) as nb
		from (select nomv
				from agence.lesvilles
				where pays='Angleterre'
				) X
				join agence.lescircuits C1
				on (X.nomv = C1.vDep)
				group by numc
		union
		select numc, count(vArr) as nb
		from (select nomv
				from agence.lesvilles
				where pays='Angleterre'
				) X
				join agence.lescircuits C2
				on (X.nomv = C2.vArr)
				group by numc
				)
	group by numc	
	having sum(nb)=(select count(nomv)
		from agence.lesvilles 
		where pays='Angleterre');	
spool off;
