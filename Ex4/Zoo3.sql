-- Nom des Animaux originaires du Kenya et qui ont contracté une grippe

spool ResZoo3
	select nomA
	from zoo.LesAnimaux natural join zoo.LesMaladies
	where (nomM='grippe') and (pays='Kenya');
spool off;
