

select * from Proyectos
where Proyecto like '%6a%'

select * from AoCatDestajistas

select * from AoConceptosXDestajista

select * from AoPresupuestoControl
where IdProyecto=24

select * from AoCatConceptos
where idProyecto=24


select t1.RazonSocial,t1.Observaciones,t2.DescripcionLarga,t3.CantidadOriginal, t3.CantidadDESEstimada
from AoCatDestajistas t1
inner join AoConceptosXDestajista t4 on t1.idDestajista= t4.idDestajista
inner join AoPresupuestoControl t3 on t3.IdPresupuestoControl=t4.IdPresupuestoControl
inner join AoCatConceptos t2 on t3.idConcepto=t2.idConcepto
where t3.IdProyecto=24
order by t4.idDestajista
