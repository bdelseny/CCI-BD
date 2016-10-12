-- Donner les noms des vins qui ont été servis avec un médaillon de langouste :

spool ResReq2
	select distinct nomv
	from repas.lemenu
	where nomp = 'Medaillon langouste';
spool off;
