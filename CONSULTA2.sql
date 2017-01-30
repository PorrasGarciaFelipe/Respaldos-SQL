/*
CANTIDAD
*/
WITH DESTAJOS (CONCEPTO, UBICACION, DESCRIPCIÓN, UNIDAD, CANTIDAD) AS(
select DISTINCT i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad,sum(t1.Cantidad) 
from accatinsumos i1 
inner join AoCatConceptos i2 on i1.DescripcionLarga like i2.DescripcionLarga
inner join AcCatUnidades u1 on i1.IdUnidad=u1.idUnidad
inner join Proyectos i3 on i2.IdProyecto=i3.idProyecto
inner join AoPresupuestoControl t5 on i2.idConcepto=t5.idConcepto
inner join AoDestajosEstDet t2 on t5.IdPresupuestoControl=t2.IdPresupuestoControl
inner join AoDestajosEstCC t1 on t2.IdDestajoDet=t1.IdDestajoDet
inner join Centros t9 on t1.idCentro=t9.idCentro
where t9.idProyecto in (select idProyecto from Proyectos where Proyecto like '%5a-3a ed%') and Centro like '%27A0%'
group by i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad, t1.Cantidad
)SELECT * FROM DESTAJOS
PIVOT (SUM(CANTIDAD) for
ubicacion in ([27A01],[27A02],[27A03],[27A04],[27A05],[27A06],[27A07],[27A08])) PVT
ORDER BY CONCEPTO

/*--------------------------------------------------------------------------------------------------------------------*/

/*COSTO 
*/
WITH DESTAJOS (CONCEPTO, UBICACION, DESCRIPCIÓN, UNIDAD,COSTO) AS(
select DISTINCT i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad,avg(t2.Costo) 
from accatinsumos i1 
inner join AoCatConceptos i2 on i1.DescripcionLarga like i2.DescripcionLarga
inner join AcCatUnidades u1 on i1.IdUnidad=u1.idUnidad
inner join Proyectos i3 on i2.IdProyecto=i3.idProyecto
inner join AoPresupuestoControl t5 on i2.idConcepto=t5.idConcepto
inner join AoDestajosEstDet t2 on t5.IdPresupuestoControl=t2.IdPresupuestoControl
inner join AoDestajosEstCC t1 on t2.IdDestajoDet=t1.IdDestajoDet
inner join Centros t9 on t1.idCentro=t9.idCentro
where t9.idProyecto in (select idProyecto from Proyectos where Proyecto like '%5a-3a ed%') and Centro like '%27A0%'
group by i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad, t1.Cantidad,t2.Costo
)SELECT *FROM DESTAJOS
PIVOT (AVG(costo) for
ubicacion in ([27A01],[27A02],[27A03],[27A04],[27A05],[27A06],[27A07],[27A08])) PVT
ORDER BY CONCEPTO
