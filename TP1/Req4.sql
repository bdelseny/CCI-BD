-- Les amis qui aiment tous les plats servis le 6 mars 2005

spool ResReq4
	with X as (
		select M.nomp
			from repas.lemenu M
			where dater='06-MAR-05')
	select nomA
		from (
				select P.nomA, count(P.nomp) as nbPlats2
					from repas.lespreferences P join X on (P.nomp = X.nomp)
					group by P.nomA ) Z 
			join (
				select count(X.nomp) as nbPlats
					from X ) Y
			on (Z.nbPlats2 = Y.nbPlats);
spool off;

