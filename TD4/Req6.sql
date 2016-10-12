-- Donner les repas (date, plats, vin servis) auxquels Bernard et Philippe ont été invités (ensembles) :
-- Philippe et Bernard n'existent pas dans la relation LesRepas, j'ai donc choisi de prendre Marie et Phil pour avoir une sortie

spool ResReq6
	select R1.dater, nomp, nomv
	from repas.lesrepas R1 join repas.lesrepas R2 on ( R1.dater = R2.dater) join repas.lemenu M on ( M.dater = R1.dater ) 
	where R2.nomi =  'Phil' and R1.nomi = 'Marie'  ;
spool off ;

