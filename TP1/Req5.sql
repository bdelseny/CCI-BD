

spool ResReq5
	with X as (
		select nomI, count(distinct dateR) as nbI
			from Repas.LesRepas
			group by nomI )
	select X.nomI, nbI, count(P.nomP) as nbP
		from Repas.LesPreferences P right outer join X on (P.nomA = X.nomI)
		group by X.nomI, nbI;
spool off;
