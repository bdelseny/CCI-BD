-- Numéro, nom, et prénom des adhérents nés après 1960
-- et qui habitent Grenoble
spool Res2
	desc biblio.LesAdherents
	accept lannee prompt 'Donner une annee de naissance : '
	accept laville prompt 'Donner le nom de la ville : '
	select noAdh, nom, prenom
	from biblio.LesAdherents
	where adresse = '&laville' and anNais < &lannee;
spool off;

