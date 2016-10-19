-- Quelles sont les dates des repas où on a servi uniquement de l'eau comme boisson

spool ResReq
	select dateR
	from repas.LeMenu
		minus
	select dateR
	from repas.Lemenu
	where nomV<>'eau';
	
spool off;
