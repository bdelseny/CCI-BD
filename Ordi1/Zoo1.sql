-- Noms des animaux qui n'ont jamais été malades
spool ResZoo1
select nomA
from zoo.LesAnimaux
	minus
select nomA
from zoo.LesMaladies
spool off;
