-- donner les noms des invités à qui il a été servi au moins une fois du fois gras :

spool ResReq4
	select distinct nomi
	from repas.lesrepas R join repas.lemenu M on (R.dater = M.dater)
	where nomp = 'Foie gras';
spool off ;
