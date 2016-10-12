-- Donner les noms des amis qui n'ont jamais été invités

spool resReq5
	select noma
	from repas.lespreferences
		minus
	select nomi
	from repas.lesrepas; 
spool off ;
