


select t1.Insumo, t1.Descripcion, t2.Familia,t2.Descripcion
from accatinsumos t1 
inner join AcFamilias t2 on t1.idFamilia=t2.idFamilia 
where t1.Descripcion like '%cinta%'






update AcCatInsumos
set idtipoinsumo=9
where Insumo like '%indir%'
