-- Donner les noms des invités qui n'aiment que les dessert :

spool ResReq8
	select nomi
	from repas.lesrepas R join repas.lespreferences P on ( R.nomi = P.noma )
		minus
	select nomi
	from repas.lespreferences P join repas.lesrepas R on ( R.nomi = P.noma ) join repas.lesplats P2 on ( P.nomp = P2.nomp )
	where P2.typep <> 'dessert';
spool off ; 
