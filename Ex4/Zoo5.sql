-- <nomA, nomM> des animaux hermaphrodites

spool ResZoo5
	select nomA, nomM
	from zoo.LesMaladies natural join zoo.LesAnimaux
	where sexe='hermaphrodite';
spool off;
