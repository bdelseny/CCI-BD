-- no et fonction des cages inoccupées

spool ResZoo4
	select noCage, fonction
	from zoo.LesCages
		minus
	select noCage, fonction
	from zoo.LesAnimaux natural join zoo.LesCages;
spool off;
