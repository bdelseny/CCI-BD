-- Donner les noms des plats (avec le vin qui les accompagne) qui ont été servis le 21 octobre 2003 :

spool ResReq3
	select nomp, nomv
	from repas.lemenu
	where dater = to_date('21/10/03', 'DD/MM/YY');
spool off ;
