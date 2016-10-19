-- Quelles sont les dates des repas où plusieurs boissons différentes ont été servis

spool ResReq2
	select dater
	from repas.lemenu
	group by dater
	having count(distinct nomv)>1;
spool off;
