-- Donner les noms des invités du repas organisé le 31 Décembre 2004

spool ResReq1
	select nomI
	from repas.lesrepas
	where dateR = TO_DATE('31/12/2004', 'DD/MM/YYYY');
spool off;
