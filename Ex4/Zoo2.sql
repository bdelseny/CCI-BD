-- Nom et Types des animaux qui n'ont jamais été malades
spool ResZoo2
	select nomA, type
	from zoo.LesAnimaux 
		minus
	select nomA, type
	from zoo.LesMaladies natural join zoo.LesAnimaux;
spool off;

