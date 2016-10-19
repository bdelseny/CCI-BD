

spool ResReq3
	with X as (select nomi, min(dater) as ancDate
	from repas.lesrepas 
	group by nomi)
	select nomi, ancDate, nomp, nomv
	from repas.leMenu M join X on (M.dater=ancDate);
spool  off;
