--Donner les noms des amis qui ont eu, au moins une fois, un de leurs plat préféré

spool ResReq7
	select noma
	from repas.lespreferences P join repas.lemenu M on ( M.nomp = P.nomp ) join repas.lesrepas R on ( R.nomi = P.noma );
spool off ;
